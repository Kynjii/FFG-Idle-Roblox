local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Building = require(ServerScriptService.Server.Classes.Building)
local BuildingsManagerType = require(ServerScriptService.Server.Classes.Types.BuildingsManagerType)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local taggedBuildings = CollectionService:GetTagged("Building")

type BuildingsManger = BuildingsManagerType.BuildingsManager

local BuildingsManager = {} :: BuildingsManger
BuildingsManager.__index = BuildingsManager

function BuildingsManager.New(realmData, player: Player, teamId: number)
	local self: BuildingsManger = setmetatable({}, BuildingsManager)

	self.Player = player
	self.TeamId = teamId

	self.BuildingModels = self:FindBuildingModels()

	local buildingsArr = realmData.Buildings
	local realmBuffs = realmData.Buffs
	self.Buildings = self:CreateBuildings(buildingsArr, realmBuffs)

	return self
end

function BuildingsManager:FindBuildingModels()
	local buildings = {}
	for _, taggedBuilding in ipairs(taggedBuildings) do
		local taggedBuildingTeamId = taggedBuilding:GetAttribute(FFGEnum.ATTRIBUTES.TeamId)
		if taggedBuildingTeamId == self.TeamId then buildings[#buildings + 1] = taggedBuilding end
	end

	return buildings
end

function BuildingsManager:CreateBuildings(buildingsData, realmBuffs)
	local buildings = {}

	for i = 1, #self.BuildingModels do
		buildings[i] = Building.New(buildingsData[i] or nil, self.Player, self.BuildingModels[i], realmBuffs)
	end

	return buildings
end

function BuildingsManager:Initialize()
	for _, building in ipairs(self.Buildings) do
		building:Initialize()
	end
end

-- //SECTION - Cleanup
function BuildingsManager:Destroy()
	for _, building in ipairs(self.Buildings) do
		building:Destroy()
	end
end
-- //!SECTION

return BuildingsManager
