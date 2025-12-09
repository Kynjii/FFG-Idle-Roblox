local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Fish = require(ServerScriptService.Server.Classes.Fish)
local Difficulty = require(ServerScriptService.Server.Classes.Modules.Difficulty)
local Notification = require(ServerScriptService.Server.Classes.Modules.Notification)
local FishingXP = require(ServerScriptService.Server.Data.FishingXP)
local DataService = require(ServerScriptService.Server.Services.DataService)
local Trove = require(ReplicatedStorage.Packages.Trove)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local RodType = require(ReplicatedStorage.Shared.Types.RodType)
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

local DEBUG_FISHING = true -- set to false for release

function FishingManager.DebugSummary(self, player, session, rodData, result, simStats)
	if not DEBUG_FISHING then return end

	local fish = session.Fish
	local cfg = session.MinigameConfig

	print(string.rep("-", 60))
	print(string.format("[FISH DEBUG] Player=%s | Fish=%s %s (Q%d T%d)", player.Name, fish.Species, fish.Variant, fish.QualityId, session.Tier))

	print(string.format("  Duration: %.2fs", result.Duration))
	print(string.format("  Hits: %d (Perfect: %d)", simStats.TotalHits or 0, simStats.PerfectHits or 0))

	print(string.format("  Reason: %s", simStats.Reason or "Unknown"))
	print(string.format("  FinalHP: %.1f / %.1f", simStats.FinalHP or 0, fish.MaxHP))

	print(string.format("  Escapes: %d / %d", simStats.EscapeAttempts or 0, cfg.EscapeAttempts or 3))

	print(string.format("  DifficultyFactor: %.2f", session.DifficultyFactor or 1.0))

	print(string.format("  Rod BaseDamage: %.1f", rodData.BaseDmg))
	print(string.format("  HealMultiplier: %.2f | DecayRate: %.2f", cfg.HealMultiplier or 1.0, cfg.DecayRate or 1.0))

	print(string.rep("-", 60))
end

-- //SECTION - Constructor

function FishingManager.New(player: Player, teamId: number, currentRealm: number): FishingManager
	local self = setmetatable({}, FishingManager)

	self.Player = player
	self.Owner = player.UserId
	self.TeamId = teamId
	self.RealmId = currentRealm

	self.CurrentFishingLocTier = 1
	self.CurrentFishingLocId = 1
	self.FishingLocations = self:GetLocations()
	self.GeneratedFish = {}
	self.FishingSessions = FishingSessions
	self.CurrentlyEquippedRod = nil

	self._cleaner = Trove.new()

	self:SetupProximityPrompts()
	self:AttachAttListeners()

	return self
end

-- //SECTION - Locations

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

-- //SECTION - Session Start

function FishingManager.StartFishingSession(self: FishingManager, player: Player, fishConfig: Fish.Fish, tier: number)
	local sessionId = HttpService:GenerateGUID(false)

	-- Calculate difficulty factors for the minigame
	local playerData = DataService.GetSkillData(self.Player, "Fishing")
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
		MinigameConfig = minigameConfig,
	})

	return sessionId
end

-- //SECTION - Server-side Simulation

-- Simulate the minigame on the server using only:
-- - session.Fish
-- - session.MinigameConfig
-- - rodData.BaseDmg
-- - hitTimeline: { {time = number, area = 0..3}, ... }
-- - duration: client-reported duration (sanitized by caller)
--
-- Returns:
--   didCatch: boolean
--   stats: {
--      Reason: "HPFilled" | "Escape" | "InsufficientPower",
--      EscapeAttempts: number,
--      TotalHits: number,
--      PerfectHits: number,
--      FinalHP: number,
--   }
function FishingManager.SimulateFishingMinigame(self, session, rodData, hitTimeline, duration)
	local fish = session.Fish
	local config = session.MinigameConfig or {}

	local maxHP = fish.MaxHP or 100
	local hp = 0

	local healMultiplier = config.HealMultiplier or 1.0
	local decayRate = config.DecayRate or 1.0
	local escapeLimit = config.EscapeAttempts or 3
	local minHitsBeforeEscape = config.MinHitsBeforeEscape or 3

	local decayPerSecond = (maxHP / 40) * decayRate

	local totalHits = 0
	local perfectHits = 0
	local escapeAttempts = 0

	-- Defensive copy + sort by time
	local timeline = {}
	for i, hit in ipairs(hitTimeline) do
		timeline[i] = hit
	end

	table.sort(timeline, function(a, b)
		return (a.time or 0) < (b.time or 0)
	end)

	local lastTime = 0

	-- Helper to apply decay for dt seconds
	local function applyDecay(dt)
		if dt <= 0 then return end

		local steps = math.floor(dt) -- approx 1x per second
		for _ = 1, steps do
			hp -= decayPerSecond

			if hp <= 0 then
				if totalHits < minHitsBeforeEscape then
					-- Too early for a true escape: give another chance
					hp = 1
				else
					escapeAttempts += 1
					if escapeAttempts >= escapeLimit then
						return true -- early stop → escape
					end
					-- fish struggles but stays barely on the line
					hp = 1
				end
			end
		end

		return false
	end

	-- Process hits in time order
	for _, hit in ipairs(timeline) do
		local t = math.clamp(hit.time or 0, 0, duration)

		-- decay between lastTime and this hit
		local dt = t - lastTime
		if dt > 0 then
			local escaped = applyDecay(dt)
			if escaped then return false, {
				Reason = "Escape",
				EscapeAttempts = escapeAttempts,
				TotalHits = totalHits,
				PerfectHits = perfectHits,
				FinalHP = hp,
			} end
		end

		lastTime = t

		-- apply the hit
		local area = hit.area or 0

		if area > 0 then
			totalHits += 1
			if area == 3 then
				perfectHits += 1
			end

			local heal = rodData.BaseDmg * area * healMultiplier
			hp += heal

			if hp >= maxHP then
				-- Bar filled at some point in the fight → catch
				return true, {
					Reason = "HPFilled",
					EscapeAttempts = escapeAttempts,
					TotalHits = totalHits,
					PerfectHits = perfectHits,
					FinalHP = hp,
				}
			end
		else
			-- Miss penalty
			local missPenalty = rodData.BaseDmg * decayRate
			hp -= missPenalty
			if hp < 0 then hp = 0 end
		end
	end

	-- After the last hit, decay until duration ends
	local remaining = duration - lastTime
	if remaining > 0 then
		local escaped = applyDecay(remaining)
		if escaped then return false, {
			Reason = "Escape",
			EscapeAttempts = escapeAttempts,
			TotalHits = totalHits,
			PerfectHits = perfectHits,
			FinalHP = hp,
		} end
	end

	-- No HP fill, no hard escape → just didn't overpower it
	return false, {
		Reason = "InsufficientPower",
		EscapeAttempts = escapeAttempts,
		TotalHits = totalHits,
		PerfectHits = perfectHits,
		FinalHP = hp,
	}
end

-- //SECTION - Validation

-- Server-side validation & scoring
-- Returns:
--   isValid: boolean (anti-cheat / session sanity)
--   message: string (for logs)
--   didCatch: boolean
--   stats: table (for XP + logging)
function FishingManager.ValidateAndScoreFishing(self, player, sessionId, result)
	local session = self.FishingSessions[sessionId]
	if not session then return false, "Invalid session", false end

	if session.Player ~= player then return false, "Wrong player", false end

	local now = os.clock()
	local elapsed = now - session.StartedAt

	-- Basic anti-cheat on real-world session duration
	local MIN_DURATION = 0.1
	local MAX_DURATION = 300

	if elapsed < MIN_DURATION then return false, "Impossible speed", false end

	if elapsed > MAX_DURATION then return false, "Too slow", false end

	-- SANITIZE CLIENT INPUT
	local clientDuration = math.clamp(result.Duration or elapsed, MIN_DURATION, MAX_DURATION)
	local rawHits = result.Hits or {}

	-- Max 3 hits per second
	local maxHits = math.floor(clientDuration * 3)
	local timeline = {}

	for _, hit in ipairs(rawHits) do
		if #timeline >= maxHits then break end

		local t = tonumber(hit.time)
		local a = tonumber(hit.area)

		if t and a then
			if t >= 0 and t <= clientDuration + 0.25 then table.insert(timeline, {
				time = t,
				area = math.clamp(a, 0, 3),
			}) end
		end
	end

	local rodData = self:GetPlayerRod()
	if not rodData then
		-- Player somehow lost their rod mid-session; fail-safe
		return false, "No rod equipped", false
	end

	-- Run authoritative simulation
	local didCatch, simStats = self:SimulateFishingMinigame(session, rodData, timeline, clientDuration)

	-- Debug info
	self:DebugSummary(player, session, rodData, {
		Duration = elapsed,
	}, simStats)

	local fishData = session.Fish
	local difficultyFactor = session.DifficultyFactor
	local tier = session.Tier

	-- Clean up session
	self.FishingSessions[sessionId] = nil

	-- Pack stats for XP + logging
	local stats = {
		FishData = fishData,
		TotalHits = simStats.TotalHits or 0,
		PerfectHits = simStats.PerfectHits or 0,
		Duration = elapsed, -- real-world time
		Difficulty = difficultyFactor,
		Tier = tier,
		Reason = simStats.Reason,
		EscapeAttempts = simStats.EscapeAttempts or 0,
	}

	return true, "Validation complete", didCatch, stats
end

-- //SECTION - Fish Generation / Saving

function FishingManager.GetRandomFish(self: FishingManager, fishingLocTier: number, fishingLocId: number)
	local fish = Fish.New({}, self.Player, self.TeamId, fishingLocTier, fishingLocId, self.RealmId)
	if fish then self.GeneratedFish[fish.Id] = fish end
	return fish
end

function FishingManager.SaveCaughtFish(self: FishingManager, caughtFish: Fish.Fish)
	if not self.GeneratedFish[caughtFish.Id] then return end

	local fish = self.GeneratedFish[caughtFish.Id]
	fish:Save()

	local updateCaughtFishEvent = Events.GetBindableEvent(Events.BindableNames.UpdateCaughtFish)
	if updateCaughtFishEvent then updateCaughtFishEvent:Fire({
		Player = self.Player,
		Fish = self.GeneratedFish[caughtFish.Id]:Serialize(),
	}) end

	local grantFishToolEvent = Events.GetBindableEvent(Events.BindableNames.FishCaught)
	if grantFishToolEvent then grantFishToolEvent:Fire({
		Player = self.Player,
		Fish = self.GeneratedFish[caughtFish.Id]:Serialize(),
	}) end

	Notification.SendSuccess(self.Player, `You caught a {fish.Name}`)
end

function FishingManager.GetPlayerRod(self: FishingManager)
	return self.CurrentlyEquippedRod
end

-- //SECTION - Proximity Prompts

function FishingManager.SetupProximityPrompts(self: FishingManager)
	for _, location in pairs(self.FishingLocations) do
		local taggedLocationTeamId = location:GetAttribute(FFGEnum.ATTRIBUTES.TeamId)
		if taggedLocationTeamId ~= self.TeamId then continue end

		local taggedLocationTier = location:GetAttribute(FFGEnum.ATTRIBUTES.Tier)
		local taggedLocationId = location:GetAttribute(FFGEnum.ATTRIBUTES.LocationId)

		local proximityPrompt = Instance.new("ProximityPrompt")
		proximityPrompt.ObjectText = `Tier {taggedLocationTier}`
		proximityPrompt.ActionText = "Begin Fishing"
		proximityPrompt:SetAttribute(FFGEnum.ATTRIBUTES.Tier, taggedLocationTier)
		proximityPrompt.Parent = location

		self._cleaner:Add(proximityPrompt.Triggered:Connect(function(player: Player)
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			if not self.CurrentlyEquippedRod then
				Notification.SendAlert(player, "Equip a Fishing Rod first!")
				return
			end

			self.CurrentFishingLocTier = taggedLocationTier
			self.CurrentFishingLocId = taggedLocationId

			local playerRod = self.CurrentlyEquippedRod :: RodType.FishingRodType

			if playerRod.QualityId < self.CurrentFishingLocTier then
				Notification.SendAlert(player, "Your Fishing Rod quality is too low for this spot!")
				return
			end

			local fishConfig = self:GetRandomFish(taggedLocationTier, taggedLocationId)
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

-- //SECTION - Animations

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
	end
end

-- //SECTION - XP Calculation

function FishingManager.ApplyFishingXP(self: FishingManager, stats)
	local pdata = DataService.GetSkillData(self.Player, "Fishing")

	local fishData = stats.FishData
	if not fishData then
		warn("No fish data in stats for XP calculation")
		return
	end

	local xpReward = self:CalculateFishingXPReward(fishData, stats, pdata.FishingLevel)

	local oldLevel = pdata.FishingLevel
	local oldXP = pdata.FishingXP

	local newLevel, newXP = FishingXP.AddXP(oldLevel, oldXP, xpReward)

	local dataToSave = {
		FishingLevel = newLevel,
		FishingXP = newXP,
		TotalForNextLevel = FishingXP.GetTotalForLevel(newLevel + 1),
		TotalForCurrentLevel = FishingXP.GetTotalForLevel(newLevel),
	}

	DataService.UpdateSkillData(self.Player, "Fishing", dataToSave)

	Events.FireEvent(Events.RemoteNames.LootNotification, self.Player, {
		ItemImage = "Fishing",
		Text = string.format("+%d Fishing XP", xpReward),
	})

	if newLevel > oldLevel then
		Events.FireEvent(Events.RemoteNames.LootNotification, self.Player, {
			ItemImage = "Fishing",
			Text = string.format("🎣 Fishing Level Up! Level %d → %d", oldLevel, newLevel),
		})

		print(string.format("%s reached Fishing Level %d! (+%d XP)", self.Player.Name, newLevel, xpReward))
	else
		local xpToNext = FishingXP.GetXPToNextLevel(newLevel, newXP)
		print(string.format("%s gained %d Fishing XP (%d more needed for level %d)", self.Player.Name, xpReward, xpToNext, newLevel + 1))
	end
end

function FishingManager.CalculateFishingXPReward(self: FishingManager, fishData, stats, playerLevel: number): number
	-- Base XP from fish quality and tier
	local baseXP = 5 + (fishData.QualityId * 8) + ((fishData.Tier or 1) * 4)

	-- Performance bonus: perfect hits give significant bonus
	local perfectRatio = (stats.PerfectHits or 0) / math.max(stats.TotalHits or 0, 1)
	local performanceBonus = 1.0 + (perfectRatio * 0.5) -- Up to +50% for all perfect hits

	-- Difficulty bonus: harder fish give more XP
	local difficulty = stats.Difficulty or 1.0
	local difficultyBonus = 1.0 + (difficulty - 1.0) * 0.3 -- +30% per difficulty point above 1

	-- Duration bonus: faster catches get small bonus (encourages skill)
	local durationBonus = 1.0
	local duration = stats.Duration or 0
	if duration < 10 then
		durationBonus = 1.2
	elseif duration < 20 then
		durationBonus = 1.1
	end

	local finalXP = baseXP * performanceBonus * difficultyBonus * durationBonus

	finalXP = math.floor(finalXP + 0.5)
	finalXP = math.max(finalXP, 3)

	return finalXP
end

-- //SECTION - Event Listeners

function FishingManager.AttachAttListeners(self: FishingManager)
	local fishingResultEvent = Events.GetRemote(Events.RemoteNames.FishingResult)
	if fishingResultEvent then
		self._cleaner:Add(fishingResultEvent.OnServerEvent:Connect(function(player: Player, sessionId: string, result: {})
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			local isValid, message, fishCaught, stats = self:ValidateAndScoreFishing(player, sessionId, result)
			if not isValid then
				print("Invalid fishing attempt by:", player.Name, "Reason:", message)
				return
			end

			if fishCaught then
				local fishData = stats.FishData
				if fishData then
					self:SaveCaughtFish(fishData)
					self:ApplyFishingXP(stats)
					self:PlayerAnim(player)
					print(string.format("Fish caught by %s! Hits: %d (perfect %d), Reason=%s", player.Name, stats.TotalHits or 0, stats.PerfectHits or 0, stats.Reason or "Unknown"))
				else
					print("Missing fish data for successful catch by:", player.Name)
				end
			else
				local reason = stats.Reason or "Failed"
				print(string.format("Fish escaped from %s. Reason=%s, Hits=%d (perfect %d)", player.Name, reason, stats.TotalHits or 0, stats.PerfectHits or 0))

				if Notification and Notification.SendAlert then
					local msg = "The fish got away!"
					if reason == "OutOfTime" then
						msg = "The fish got away – you took too long!"
					elseif reason == "Escape" then
						msg = "The fish got away after too many struggles!"
					end
					Notification.SendAlert(player, msg)
				end
			end
		end))
	end

	local equippedRodEvent = Events.GetBindableEvent(Events.BindableNames.EquippedRod)
	if equippedRodEvent then
		self._cleaner:Add(equippedRodEvent.Event:Connect(function(data: { Player: Player, RodId: number })
			local player = data.Player
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			local rodId = data.RodId
			if not rodId then
				self.CurrentlyEquippedRod = nil
				return
			end

			local playerRods = DataService.GetRods(player)
			local existing = TableUtil.Find(playerRods, function(rod)
				return rod.Id == rodId
			end)

			if existing then self.CurrentlyEquippedRod = existing end
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
	self.TeamId = nil
	self.RealmId = nil
end

return FishingManager
