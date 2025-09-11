local ServerScriptService = game:GetService("ServerScriptService")
local Formulas = require(ServerScriptService.Server.Math.Formulas)

local ClassCalculator = {}

function ClassCalculator.CalculateBaseCost(baseValue: number, tier: number, realmNum: number)
	local baseCost = baseValue
	local tierMultiplier = Formulas.TIER_MULTIPLIER[tier]
	local realmMultiplier = math.pow(realmNum, 2.25) -- scaling curve
	local base = baseCost * tierMultiplier * realmMultiplier

	return base
end

return ClassCalculator
