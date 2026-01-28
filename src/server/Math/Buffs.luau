--[[
	Buffs.luau
	
	Calculates buff values based on stage and level progression.
	Buffs are percentage modifiers that enhance entity performance
	(e.g., +20% FPS, +15% storage capacity).
	
	## Buff Types:
	- **Multiplier**: General stat multipliers (aggressive early, tapers off)
	- **Production**: FPS and resource generation (strong early scaling)
	- **QoL**: Quality of life stats like storage (steady growth)
	- **Loop**: Automation efficiency (balanced curve)
	- **TimeReduction**: Travel/load time improvements (front-loaded)
	
	@module Buffs
	@server
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BuffType = require(ReplicatedStorage.Shared.Types.BuffType)
local DataService = require(ServerScriptService.Server.Services.DataService)
local Buffs = {}

--- Stage-based growth rates for each buff type.
--- Higher stage = different multiplier applied to base value.
--- Indexed by stage (1-11).
local GROWTH_RATES = {
    Multiplier = { 1.15, 1.12, 1.10, 1.08, 1.07, 1.06, 1.05, 1.04, 1.03, 1.02, 1.01 },
    Production = { 3.0, 2.5, 2.0, 1.8, 1.6, 1.4, 1.3, 1.2, 1.15, 1.10, 1.05 },
    QoL = { 2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6, 3.8, 4.0 },
    Loop = { 1.20, 1.18, 1.15, 1.12, 1.10, 1.08, 1.06, 1.05, 1.04, 1.03, 1.02 },
    TimeReduction = { 1.5, 1.4, 1.3, 1.25, 1.2, 1.18, 1.15, 1.12, 1.10, 1.08, 1.05 },
}

--- Per-level exponential growth rate for each buff type.
--- Applied as: stageValue × (levelGrowthRate ^ (level - 1))
local LEVEL_GROWTH_RATES = {
    Multiplier = 1.08,
    Production = 1.12,
    QoL = 1.06,
    Loop = 1.10,
    TimeReduction = 1.015,
}

--- Calculates buff value at a specific stage (ignoring level).
--- Formula: BaseValue × StageGrowthRate[stage]
--- @param stage number -- The current stage (1-11)
--- @param buffState BuffType.BuffState -- The buff definition
--- @return number -- The calculated buff value
function Buffs.CalculateStageBuffValue(stage: number, buffState: BuffType.BuffState): number
    local growthRate = GROWTH_RATES[buffState.Type][stage]
    return buffState.BaseValue * growthRate
end

--- Calculates buff value at a specific stage and level.
--- Formula: BaseValue × StageGrowthRate × (LevelGrowthRate ^ (level-1))
--- @param stage number -- The current stage (1-11)
--- @param level number -- The current level within the stage
--- @param buffState BuffType.BuffState -- The buff definition
--- @return number -- The calculated buff value
function Buffs.CalculateLevelBuffValue(stage: number, level: number, buffState: BuffType.BuffState): number
    local stageGrowthRate = GROWTH_RATES[buffState.Type][stage] or 1
    local levelGrowthRate = LEVEL_GROWTH_RATES[buffState.Type] or 1.1

    local stageValue = buffState.BaseValue * stageGrowthRate
    local levelMultiplier = math.pow(levelGrowthRate, level - 1)

    return stageValue * levelMultiplier
end

--- Retrieves current buff states for specified buff names from player data.
--- @param player Player -- The player to get buffs for
--- @param buffNames table -- Array of buff name keys to retrieve
--- @return table -- Map of buff names to their current BuffState
function Buffs.GetBuffs(player: Player, buffNames: { string })
    return DataService.GetBuffState(player, buffNames)
end

return Buffs
