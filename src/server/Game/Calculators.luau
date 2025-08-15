local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Formulas = require(script.Parent.Formulas)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local FFGHelpers = require(ReplicatedStorage.Shared.Utils.FFGHelpers)
local CALCULATOR = {}

CALCULATOR.MaxStorage = function(type: string, entityState: Object)
	if not type or not entityState then
		FFGHelpers("No type or entityState passed to MaxStorage fn")
		return
	end

	local baseStorage = 0

	if type == FFGEnum.ENTITIES.Boat then
		baseStorage = Formulas.BOAT.BaseStorage
	else
		baseStorage = Formulas.TENDER.BaseStorage
	end

	FFGHelpers.PrintLog("Base Store: ", baseStorage)

	local tier = entityState[FFGEnum.ATTRIBUTES.BOAT.Tier] :: number
	local growthRate = 0
	if type == FFGEnum.ENTITIES.Boat then
		growthRate = Formulas.BOAT.GrowthRate + tier * 0.02
	else
		growthRate = Formulas.TENDER.GrowthRate + tier * 0.02
	end

	FFGHelpers.PrintLog("Growth Rate: ", growthRate)

	local tierMultiplier = Formulas.TIER_MULTIPLIER[tier]
	FFGHelpers.PrintLog("Tier Multiplier: ", tierMultiplier)

	local level = entityState[FFGEnum.ATTRIBUTES.BOAT.Level] :: number
	local maxStorage = baseStorage * math.pow(growthRate, level) * tierMultiplier

	local nextLvlMaxStorage = baseStorage * math.pow(growthRate, level + 1) * tierMultiplier

	-- //TODO - handle boosts

	return { CurrentValue = maxStorage, NextLvlValue = nextLvlMaxStorage }
end

return CALCULATOR
