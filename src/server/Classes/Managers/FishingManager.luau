local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Fish = require(ServerScriptService.Server.Classes.Fish)
local Difficulty = require(ServerScriptService.Server.Classes.Modules.Difficulty)
local Notification = require(ServerScriptService.Server.Classes.Modules.Notification)
local Trove = require(ReplicatedStorage.Packages.Trove)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local Animator = require(ReplicatedStorage.Shared.Utils.Animator)

-- //SECTION - Tagged Fishing Locations within Workspace
local taggedFishingLocs = CollectionService:GetTagged("FishingLocation")
-- //!SECTION

-- //SECTION - Fishing Sessions Management
local FishingSessions = {}
-- //!SECTION

local FishingManager = {}
FishingManager.__index = FishingManager

type FishingManager = typeof(setmetatable({}, FishingManager))

function FishingManager.New(player: Player, teamId: number, currentRealm: number)
	local self = setmetatable({}, FishingManager)

	self.Player = player
	self.Owner = self.Owner or player.UserId
	self.TeamId = teamId
	self.RealmId = currentRealm
	self.CurrentFishingLocTier = 1
	self.FishingLocations = self:GetLocations()
	self.GeneratedFish = {}
	self.FishingSessions = FishingSessions

	self._cleaner = Trove.new()

	self:SetupProximityPrompts()

	self:AttachAttListeners()

	return self
end

function FishingManager.GetLocations(self: FishingManager)
	local locations = {}

	local index = 1
	for _, location in pairs(taggedFishingLocs) do
		local taggedLocationTeamId = location:GetAttribute(FFGEnum.ATTRIBUTES.TeamId)
		if taggedLocationTeamId and taggedLocationTeamId ~= self.TeamId then continue end

		locations[index] = location
		index += 1
	end

	return locations
end

function FishingManager.StartFishingSession(self: FishingManager, player: Player, fishConfig: Fish.Fish, tier: number)
	local sessionId = HttpService:GenerateGUID(false)

	-- Calculate difficulty factors for the minigame
	local playerData = { FishingLevel = 1 } -- TODO: Get actual player data
	local rodData = self:GetPlayerRod()
	local difficultyFactor = Difficulty.GetDifficultyFactor(playerData, rodData, fishConfig)
	local playerPower = Difficulty.GetPlayerPower(playerData, rodData)
	local fishPower = Difficulty.GetFishPower(fishConfig)
	local powerRatio = playerPower / math.max(fishPower, 1)

	-- Calculate escape attempts based on power ratio (higher if player is stronger)
	local baseEscapeAttempts = 3
	local escapeAttempts = math.floor(baseEscapeAttempts + (powerRatio - 1.0) * 2) -- +2 attempts per power ratio above 1
	escapeAttempts = math.clamp(escapeAttempts, 1, 6) -- Min 1, max 6 attempts

	-- Calculate minimum hits before escape attempts can trigger (higher if player is stronger)
	local baseMinHits = 3
	local minHitsBeforeEscape = math.floor(baseMinHits + (powerRatio - 1.0) * 2) -- +2 hits per power ratio above 1
	minHitsBeforeEscape = math.clamp(minHitsBeforeEscape, 1, 8) -- Min 1, max 8 hits

	-- Calculate minigame modifiers based on power ratio and difficulty
	local minigameConfig = {
		-- Hit zone size: Better when overpowered, harder when underpowered
		HitZoneSize = math.clamp(0.20 + (rodData.Stats.LineControl * 0.02) + (powerRatio - 1.0) * 0.1, 0.08, 0.40),
		
		-- Marker speed: Slower when underpowered (struggle), faster when overpowered (easy)
		MarkerSpeed = math.clamp(0.6 + (powerRatio - 1.0) * 0.4 - (rodData.Stats.Stability * 0.05), 0.15, 2.5),
		
		-- HP decay rate: Reduced when overpowered
		DecayRate = math.clamp(0.8 + (difficultyFactor * 0.8) - (powerRatio - 1.0) * 0.4 - (rodData.Stats.Stability * 0.15), 0.2, 3.0),
		
		-- Heal amount per hit: Increased when overpowered
		HealMultiplier = math.clamp(1.0 + (rodData.Stats.ReelPower * 0.02) + (powerRatio - 1.0) * 0.2 - (difficultyFactor * 0.15), 0.4, 2.5),
		
		-- Fish escape attempts: More forgiving when player is stronger
		EscapeAttempts = escapeAttempts,
		
		-- Minimum hits before escape attempts can trigger: Higher for stronger players
		MinHitsBeforeEscape = minHitsBeforeEscape,
	}

	self.FishingSessions[sessionId] = {
		Player = player,
		Fish = fishConfig,
		Tier = tier,
		StartedAt = os.clock(),
		DifficultyFactor = difficultyFactor,
		MinigameConfig = minigameConfig,
	}

	-- Send fishConfig + sessionId + difficulty config to client
	Events.FireEvent(Events.RemoteNames.StartFishingMiniGame, player, {
		Fish = fishConfig,
		Rod = rodData,
		Tier = tier,
		SessionId = sessionId,
		MinigameConfig = minigameConfig, -- NEW: Send difficulty-based config
	})

	return sessionId
end

function FishingManager.ValidateAndScoreFishing(self: FishingManager, player: Player, sessionId: string, result: {})
	local session = self.FishingSessions[sessionId]
	if not session then return false, "Invalid session", false end
	if session.Player ~= player then return false, "Wrong player", false end

	local now = os.clock()
	local elapsed = now - session.StartedAt

	-- Anti-cheat: Check duration
	if elapsed < 1.0 then
		print("Fishing validation failed: Too fast completion")
		return false, "Too fast", false
	end

	if elapsed > 300 then -- Max 5 minutes
		print("Fishing validation failed: Too slow completion")
		return false, "Too slow", false
	end

	-- Clamp client-reported values to prevent exploitation
	local clampedDuration = math.clamp(result.Duration or elapsed, 1, 300)
	local maxPossibleHits = math.floor(clampedDuration * 3) -- Assume max 3 hits per second
	local totalHits = math.clamp(result.TotalHits or 0, 0, maxPossibleHits)
	local perfectHits = math.clamp(result.PerfectHits or 0, 0, totalHits)

	-- Get player data for difficulty calculation
	local playerData = { FishingLevel = 1 } -- TODO: Replace with actual player data
	local rodData = self:GetPlayerRod()

	-- Calculate difficulty factor
	local difficultyFactor = Difficulty.GetDifficultyFactor(playerData, rodData, session.Fish)
	local playerPower = Difficulty.GetPlayerPower(playerData, rodData)
	local fishPower = Difficulty.GetFishPower(session.Fish)

	-- Server-side scoring system with power scaling
	local score = totalHits * 1 + perfectHits * 2
	
	-- Dynamic required score based on power difference
	local powerRatio = playerPower / math.max(fishPower, 1)
	local baseRequirement = 8 -- Base hits needed
	
	-- If player power >> fish power, much easier catch
	local scaledRequirement = baseRequirement / math.max(powerRatio, 0.5)
	local requiredScore = math.ceil(math.clamp(scaledRequirement, 1, 15)) -- Min 1, max 15

	-- Additional validation: Check if client claims success
	local clientClaimsSuccess = result.Success == true

	-- Server decision: Fish is caught if all conditions are met
	local fishCaught = clientClaimsSuccess and score >= requiredScore and elapsed >= 1.0

	print(
		string.format(
			"Fishing validation - Player: %s, Score: %d/%d, Duration: %.1fs, Difficulty: %.2f, Caught: %s",
			player.Name,
			score,
			requiredScore,
			elapsed,
			difficultyFactor,
			tostring(fishCaught)
		)
	)

	-- Debug: Show difficulty breakdown
	print(
		string.format(
			"  Fish: %s %s (Q%d, T%d) | Rod: %s (Q%d) | Player: Lvl%d",
			session.Fish.Species,
			session.Fish.Variant,
			session.Fish.QualityId,
			session.Tier,
			rodData.Name,
			rodData.QualityId,
			playerData.FishingLevel
		)
	)
	print(string.format("  Hits: %d total, %d perfect | Client claimed: %s | Time valid: %s",
		totalHits, perfectHits, tostring(clientClaimsSuccess), tostring(elapsed >= 1.0)))
	print(string.format("  Power: Player=%.1f vs Fish=%.1f (ratio=%.2fx) | Req=%.1f→%d", 
		playerPower, fishPower, powerRatio, scaledRequirement, requiredScore))

	-- Store fish data before cleanup
	local fishData = session.Fish

	-- Clean up session
	self.FishingSessions[sessionId] = nil

	return true,
		"Validation complete",
		fishCaught,
		{
			Score = score,
			RequiredScore = requiredScore,
			Difficulty = difficultyFactor,
			Duration = elapsed,
			TotalHits = totalHits,
			PerfectHits = perfectHits,
			FishData = fishData,
		}
end

function FishingManager.GetRandomFish(self: FishingManager, fishingLocTier: number)
	local fish = Fish.New({}, self.Player, self.TeamId, fishingLocTier, self.RealmId)
	if fish then self.GeneratedFish[fish.Id] = fish end
	return fish
end

function FishingManager.SaveCaughtFish(self: FishingManager, caughtFish: Fish.Fish)
	if not self.GeneratedFish[caughtFish.Id] then return end

	local fish = self.GeneratedFish[caughtFish.Id]
	fish:Save()

	local updateCaughtFishEvent = Events.GetBindableEvent(Events.BindableNames.UpdateCaughtFish)
	if updateCaughtFishEvent then updateCaughtFishEvent:Fire({ Fish = fish:Serialize(), Player = self.Player }) end

	Notification.SendSuccess(self.Player, `You caught a {fish.Name}`)
end

function FishingManager.GetPlayerRod(self: FishingManager)
	-- TODO: Replace with actual player rod data from inventory/equipment
	return {
		Name = "Fishing Rod of Doom",
		QualityId = 2,
		BaseDmg = 10,
		Stats = {
			ReelPower = 3,    -- ★★★☆☆☆ (3/6 stars)
			LineControl = 2,  -- ★★☆☆☆☆ (2/6 stars)  
			Stability = 2,    -- ★★☆☆☆☆ (2/6 stars)
		},
		Perks = {
			-- Example perks that could be added
			-- "Perfect Hook", "Forgiving Line", "Tide Sync"
		},
	}
end

function FishingManager.SetupProximityPrompts(self: FishingManager)
	for _, location in pairs(self.FishingLocations) do
		local taggedLocationTeamId = location:GetAttribute(FFGEnum.ATTRIBUTES.TeamId)
		if taggedLocationTeamId ~= self.TeamId then continue end

		local taggedLocationTier = location:GetAttribute(FFGEnum.ATTRIBUTES.Tier)

		local proximityPrompt = Instance.new("ProximityPrompt")
		proximityPrompt.ObjectText = `Tier {taggedLocationTier}`
		proximityPrompt.ActionText = "Begin Fishing"
		proximityPrompt:SetAttribute(FFGEnum.ATTRIBUTES.Tier, taggedLocationTier)
		proximityPrompt.Parent = location

		self._cleaner:Add(proximityPrompt.Triggered:Connect(function(player: Player)
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			self.CurrentFishingLocTier = taggedLocationTier

			local fishConfig = self:GetRandomFish(taggedLocationTier, self.RealmId)
			self:StartFishingSession(player, fishConfig, taggedLocationTier)

			proximityPrompt.Enabled = false
		end))

		local gameEndedEvent = Events.GetRemote(Events.RemoteNames.GameEnded)
		if gameEndedEvent then
			self._cleaner:Add(gameEndedEvent.OnServerEvent:Connect(function(player: Player, tier: number)
				if self.Player ~= player or self.Owner ~= player.UserId then return end

				local promptTier = proximityPrompt:GetAttribute(FFGEnum.ATTRIBUTES.Tier)

				if tier ~= promptTier then return end

				proximityPrompt.Enabled = true
			end))
		end
	end
end

local ANIMATIONS = {
	FishCaught1 = "FishCaught1",
}

function FishingManager.PlayerAnim(self: FishingManager, player: Player)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local animator = humanoid:WaitForChild("Animator")
	local animation: Animation = Animator.GetAnimation(ANIMATIONS.FishCaught1)

	if animator then
		local animationTrack: AnimationTrack = animator:LoadAnimation(animation)
		animationTrack.Priority = Enum.AnimationPriority.Action

		task.wait()
		animationTrack:Play()

		-- Animation plays but doesn't restart fishing - player must click proximity prompt again
		animationTrack.Ended:Connect(function()
			-- No auto-restart - let player initiate next fishing session manually
		end)
	end
end

function FishingManager.AttachAttListeners(self: FishingManager)
	local getFishItemEvent = Events.GetRemoteFn(Events.RemoteFunctionNames.GetFishItem)
	if getFishItemEvent then
		getFishItemEvent.OnServerInvoke = function(player: Player)
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			return { Fish = self:GetRandomFish(self.CurrentFishingLocTier, self.RealmId), Rod = self:GetPlayerRod() }
		end
		self._cleaner:Add(getFishItemEvent)
	end

	local caughtFishEvent = Events.GetRemote(Events.RemoteNames.FishCaught)
	if caughtFishEvent then
		self._cleaner:Add(caughtFishEvent.OnServerEvent:Connect(function(player: Player, fish: Fish.Fish)
			if self.Player ~= player or self.Owner ~= player.UserId then return end
			self:SaveCaughtFish(fish)

			self:PlayerAnim(player)
		end))
	end

	local fishingResultEvent = Events.GetRemote(Events.RemoteNames.FishingResult)
	if fishingResultEvent then
		self._cleaner:Add(fishingResultEvent.OnServerEvent:Connect(function(player: Player, sessionId: string, result: {})
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			local isValid, message, fishCaught, stats = self:ValidateAndScoreFishing(player, sessionId, result)
			if not isValid then
				print("Invalid fishing attempt by:", player.Name, "Reason:", message)
				-- Optionally kick player or log incident for repeated offenses
				return
			end

			-- Check if fish escaped due to too many failures
			if result.Success == false and result.EscapeReason then
				local escapeAttempts = tonumber(result.EscapeAttempts) or 3
				print(string.format("Fish escaped from %s. Reason: %s (Attempts: %d)", 
					player.Name, tostring(result.EscapeReason), escapeAttempts))
				if Notification and Notification.SendInfo then
					Notification.SendInfo(player, string.format("The fish got away after %d escape attempts!", escapeAttempts))
				end
				return
			end

			if fishCaught then
				-- SERVER authorizes the catch
				local fishData = stats.FishData
				if fishData then
					self:SaveCaughtFish(fishData)
					self:PlayerAnim(player)
					print(string.format("Fish caught by %s! Score: %d/%d", player.Name, stats.Score, stats.RequiredScore))
				else
					print("Missing fish data for successful catch by:", player.Name)
				end
			else
				print(string.format("Fish escaped from %s. Score: %d/%d (insufficient)", 
					player.Name, stats.Score, stats.RequiredScore))
				if Notification and Notification.SendInfo then
					Notification.SendInfo(player, "The fish got away! Try to land more perfect hits.")
				end
			end
		end))
	end
end

-- //SECTION - Cleanup
function FishingManager.Destroy(self: FishingManager)
	if self._cleaner then
		self._cleaner:Clean()
		self._cleaner = nil
	end

	self.Player = nil
	self.Owner = nil
end
-- //!SECTION

return FishingManager
