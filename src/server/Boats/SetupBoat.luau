local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BoatInstance = require(script.Parent.BoatInstance)
local DataManager = require(ServerScriptService.Server.Data.DataManager)
local FFGTypes = require(ReplicatedStorage.Shared.Types.FFGTypes)
local FFGHelpers = require(ReplicatedStorage.Shared.Utils.FFGHelpers)

local taggedBoats = CollectionService:GetTagged("Boat")

local Boat = {}

-- //SECTION - BOAT SETUP (Boat, Purchase Board and Proximity Prompt)
function SetupTaggedBoats(player)
	if player then task.delay(1, function()
		for _, taggedBoat in ipairs(taggedBoats) do
			Boat.SetupBoat(taggedBoat, player)
		end
	end) end
end

function ResetTaggedBoats(player)
	if player then
		for _, taggedBoat in ipairs(taggedBoats) do
			Boat.ResetBoat(taggedBoat, player)
		end
	end
end

Boat.SetupBoat = function(boatModel: Model, player: Player)
	if not player then
		FFGHelpers.PrintLog("No local player found, unable to setup boat")
		return
	end

	local state = Boat.GetBoatState(player)
	local Boat: FFGTypes.BoatInstance = BoatInstance:New(state, player.UserId, boatModel)

	Boat:Initialize()
end

Boat.GetBoosts = function(player: Player)
	-- //TODO - handle boosts
end

Boat.GetBoatState = function(player: Player)
	return DataManager.LoadBoatState(player)
end

return {
	SetupTaggedBoats = SetupTaggedBoats,
	ResetTaggedBoats = ResetTaggedBoats,
	SetupBoat = Boat.SetupBoat,
	GetBoatState = Boat.GetBoatState,
	GetBoosts = Boat.GetBoosts,
}
