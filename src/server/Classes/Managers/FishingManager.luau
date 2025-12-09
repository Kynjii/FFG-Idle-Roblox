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

-- //SECTION - Constructor

function FishingManager.New(player: Player, teamId: number, currentRealm: number): FishingManager
	local self = setmetatable({}, FishingManager)

	self.Player = player
	self.Owner = self.Owner or player.UserId
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

function FishingManager.SimulateFishingMinigame(self, session, rodData, hitTimeline, duration)
	local fish = session.Fish
	local config = session.MinigameConfig

	local maxHP = fish.MaxHP or 100
	local hp = 0

	local healMultiplier = config.HealMultiplier
	local decayPerTick = (maxHP / 40) * config.DecayRate

	local totalHits = 0
	local perfectHits = 0

	local escapeAttempts = 0
	local maxEscapeAttempts = config.EscapeAttempts
	local minHitsBeforeEscape = config.MinHitsBeforeEscape

	local hitIndex = 1
	table.sort(hitTimeline, function(a, b)
		return a.time < b.time
	end)

	local intDuration = math.floor(duration)

	for t = 0, intDuration do
		-- DECAY (not at t=0)
		if t > 0 then
			hp -= decayPerTick
			if hp <= 0 then
				if totalHits < minHitsBeforeEscape then
					hp = 1
				else
					escapeAttempts += 1
					if escapeAttempts >= maxEscapeAttempts then
						return false, {
							Reason = "Escape",
							EscapeAttempts = escapeAttempts,
							TotalHits = totalHits,
							PerfectHits = perfectHits,
							FinalHP = hp,
						}
					end
					hp = 1
				end
			end
		end

		-- APPLY HITS THIS SECOND
		while hitIndex <= #hitTimeline and hitTimeline[hitIndex].time <= t + 0.05 do
			local area = hitTimeline[hitIndex].area

			if area > 0 then
				totalHits += 1
				if area == 3 then
					perfectHits += 1
				end

				local heal = rodData.BaseDmg * area * healMultiplier
				hp += heal

				if hp >= maxHP then return true, {
					Reason = "HPFilled",
					TotalHits = totalHits,
					PerfectHits = perfectHits,
					FinalHP = hp,
				} end
			else
				-- miss penalty
				local missPenalty = rodData.BaseDmg * config.DecayRate
				hp -= missPenalty
				if hp < 0 then hp = 0 end
			end

			hitIndex += 1
		end
	end

	-- OUT OF TIME
	return false, {
		Reason = "OutOfTime",
		TotalHits = totalHits,
		PerfectHits = perfectHits,
		FinalHP = hp,
		EscapeAttempts = escapeAttempts,
	}
end

function FishingManager.ValidateAndScoreFishing(self, player, sessionId, result)
	local session = self.FishingSessions[sessionId]
	if not session then return false, "Invalid session", false end
	if session.Player ~= player then return false, "Wrong player", false end

	local now = os.clock()
	local elapsed = now - session.StartedAt

	-- Basic anti-cheat on duration
	if elapsed < 1.0 then return false, "Too fast", false end
	if elapsed > 300 then return false, "Too slow", false end

	-- SANITIZE CLIENT INPUT
	local clientDuration = math.clamp(result.Duration or elapsed, 1, 300)
	local rawHits = result.Hits or {}

	local maxHits = math.floor(clientDuration * 3) -- 3 hits/sec max
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
		-- Player somehow lost their rod mid-session; treat as invalid / fail-safe
		return false, "No rod equipped", false
	end

	-- SIMULATE
	local didCatch, simStats = self:SimulateFishingMinigame(session, rodData, timeline, clientDuration)

	local fishData = session.Fish
	local difficultyFactor = session.DifficultyFactor
	local tier = session.Tier

	self.FishingSessions[sessionId] = nil

	return true,
		"Validation complete",
		didCatch,
		{
			FishData = fishData,
			TotalHits = simStats.TotalHits,
			PerfectHits = simStats.PerfectHits,
			Duration = elapsed, -- real session time
			Difficulty = difficultyFactor, -- for XP formula
			Tier = tier, -- handy if you want it
			Reason = simStats.Reason,
			EscapeAttempts = simStats.EscapeAttempts,
		}
end
