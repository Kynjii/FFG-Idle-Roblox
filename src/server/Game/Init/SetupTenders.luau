local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")
local DataService = require(ServerScriptService.Server.Services.DataService)
local FFGHelpers = require(ServerScriptService.Server.Modules.FFGHelpers)
local TenderClass = require(ServerScriptService.Server.Classes.Tender)
local taggedTenders = CollectionService:GetTagged("Tender")

function SetuptaggedTenders(player)
	if player then task.delay(1, function()
		for _, taggedTender in ipairs(taggedTenders) do
			SetupTender(taggedTender, player)
		end
	end) end
end

function SetupTender(tenderModel: Model, player: Player)
	if not player then
		FFGHelpers.PrintLog("No local player found, unable to setup boat")
		return
	end

	local state = GetTenderState(player)
	-- //TODO Remove hardcoded index
	local Tender = TenderClass:New(state[1], player, tenderModel)

	Tender:Initialize()
end

function GetBoosts(player: Player)
	-- //TODO - handle boosts
end

function GetTenderState(player: Player)
	return DataService.LoadTenderState(player)
end

return {
	SetuptaggedTenders = SetuptaggedTenders,
	SetupTender = SetupTender,
	GetTenderState = GetTenderState,
	GetBoosts = GetBoosts,
}
