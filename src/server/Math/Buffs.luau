local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local FormatNumber = require(ReplicatedStorage.Shared.Utils.FormatNumber)
local DataService = require(ServerScriptService.Server.Services.DataService)
local Buffs = {}

export type BuffState = {
	Name: string,
	BaseValue: number,
	CurrentValue: number,
	Type: string,
}

local GROWTH_RATES = {
	Multiplier = { 1.08, 1.07, 1.06, 1.05, 1.04, 1.03, 1.03, 1.02, 1.02, 1.02, 1.02 },
	Production = { 2.2, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.08, 1.02 },
	QoL = { 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.1, 2.2, 2.3, 2.4, 2.5 },
	Loop = { 1.14, 1.12, 1.10, 1.08, 1.07, 1.06, 1.05, 1.04, 1.03, 1.03, 1.02 },
}

function Buffs.CalculateBuffValue(stage: number, buffState: BuffState): number
	local growthRate = GROWTH_RATES[buffState.Type][stage]
	local value = buffState.BaseValue * growthRate
	return FormatNumber(value)
end

function Buffs.GetBuffs(player: Player, buffNames: { string })
	return DataService.GetBuffState(player, buffNames)
end

return Buffs
