local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Trove = require(ReplicatedStorage.Packages.Trove)
local FishCalculators = require(ServerScriptService.Server.Classes.Modules.FishCalculators)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)

local DEFAULTS = {
	Entity = FFGEnum.CLASS.ENTITY_NAME.Fish,
	RealmId = 1,
	Name = "Unnamed Fish",
	Weight = 1,
	QualityId = 1,
}

local Fish = {}
Fish.__index = Fish

type Fish = typeof(setmetatable({}, Fish))

-- //SECTION - Helpers

local TIER_QUALITY_DROPS = {
	[1] = {
		[1] = 0.75,
		[2] = 0.25,
		[3] = 0.00,
		[4] = 0.00,
		[5] = 0.00,
		[6] = 0.00,
	},
	[2] = {
		[1] = 0.65,
		[2] = 0.25,
		[3] = 0.10,
		[4] = 0.00,
		[5] = 0.00,
		[6] = 0.00,
	},
	[3] = {
		[1] = 0.58,
		[2] = 0.25,
		[3] = 0.13,
		[4] = 0.04,
		[5] = 0.00,
		[6] = 0.00,
	},
	[4] = {
		[1] = 0.55,
		[2] = 0.25,
		[3] = 0.14,
		[4] = 0.05,
		[5] = 0.01,
		[6] = 0.00,
	},
	[5] = {
		[1] = 0.50,
		[2] = 0.26,
		[3] = 0.16,
		[4] = 0.06,
		[5] = 0.015,
		[6] = 0.005,
	},
	[6] = {
		[1] = 0.45,
		[2] = 0.27,
		[3] = 0.18,
		[4] = 0.07,
		[5] = 0.025,
		[6] = 0.005,
	},
}

-- //TODO - Take the tier of the fishing location into consideration
local function chooseQuality(fishingLocTier: number?)
	local tier = math.clamp(fishingLocTier or 1, 1, 6)

	local function getRandomQuality(): number?
		local tierDrops = TIER_QUALITY_DROPS[tier]
		if not tierDrops then
			local totalWeight: number = 0
			for _, data in pairs(FFGEnum.QUALITIES) do
				totalWeight += data.DropChance
			end

			local randomValue: number = math.random() * totalWeight
			local cumulative: number = 0

			for qualityId, data in pairs(FFGEnum.QUALITIES) do
				cumulative += data.DropChance
				if randomValue <= cumulative then return qualityId end
			end
			return 1
		end

		-- Use tier-specific drop chances
		local totalWeight: number = 0
		for _, dropChance in pairs(tierDrops) do
			totalWeight += dropChance
		end

		local randomValue: number = math.random() * totalWeight
		local cumulative: number = 0

		for qualityId, dropChance in pairs(tierDrops) do
			cumulative += dropChance
			if randomValue <= cumulative then return qualityId end
		end

		return 1
	end

	local qualityId: number? = getRandomQuality()
	return qualityId
end
-- //!SECTION

-- //SECTION - Constructor
function Fish.New(state, player: Player, teamId: number, fishingLocTier: number?): Fish
	local self = setmetatable({}, Fish)

	-- Start with default stats as base
	for key, value in pairs(DEFAULTS) do
		self[key] = value
	end

	-- Override with provided state values
	if state then
		for key, value in pairs(state) do
			self[key] = value
		end
	end

	-- Calculate derived properties
	self.Entity = state.Entity or DEFAULTS.Entity
	self.Id = state.Id or HttpService:GenerateGUID(false)
	self.Player = player
	self.RealmId = state.RealmId
	self.Owner = state.Owner or self.Owner or player.UserId
	self.Model = nil
	self.TeamId = teamId

	self.ItemImage = state.ItemImage or self:GetImage()
	self.Name = state.Name or self:GetName()

	-- Define quality first
	self.QualityId = state.QualityId or self:DefineQuality(fishingLocTier)
	self.Quality = FFGEnum.QUALITIES[self.QualityId]
	self.MaxHP, self.Weight = self:CalculateStats()

	self._cleaner = Trove.new()

	return self
end
-- //!SECTION

-- //SECTION - Model
function Fish.CreateModel(self: Fish)
	--
end
-- //!SECTION

-- //SECTION - Calculations
function Fish.CalculateStats(self: Fish)
	return FishCalculators.GenerateStats(self.QualityId)
end

function Fish.DefineQuality(self: Fish, fishingLocTier: number?): number?
	return chooseQuality(fishingLocTier)
end

function Fish.GetImage(self: Fish)
	-- //TODO - replace
	return FFGEnum.UI.Icons.Fishing
end
-- //!SECTION

-- //SECTION -  Fish Utilities
function Fish.GetName(self: Fish): string
	-- //TODO - replace
	return "Flynn Bob"
	-- return NAME[self.JobCategory]
end
-- //!SECTION

-- //SECTION - Loading and Saving
function Fish.Serialize(self: Fish): { [string]: any }
	return {
		Entity = self.Entity,
		Id = self.Id,
		RealmId = self.RealmId,
		TeamId = self.TeamId,
		Owner = self.Owner,
		Name = self.Name,
		QualityId = self.QualityId,
		MaxHP = self.MaxHP,
		Weight = self.Weight,
		ItemImage = self.ItemImage,
	}
end

function Fish.Save(self: Fish): ()
	print(`Saving Fish!`)
	-- //TODO - create proper save func
	-- DataService.SaveFish(self.Player, self:Serialize())
end
-- //!SECTION

-- //SECTION - Cleanup
function Fish.Destroy(self: Fish)
	pcall(function()
		self:Save()
	end)

	if self._cleaner then
		self._cleaner:Clean()
		self._cleaner = nil
	end

	self.Player = nil :: any
end
-- //!SECTION

return Fish
