local ServerScriptService = game:GetService("ServerScriptService")
local Formulas = require(ServerScriptService.Server.Math.Formulas)

local FishCalculator = {}

-- //SECTION -  Utility: clamps & lookups
local function addDeviance(value, range)
	local randomFactor = 1 + (math.random() - 0.5) * 2 * range
	return value * randomFactor
end

local function getQualityMult(qualityId: number?): number
	if not qualityId then return 1 end
	return (Formulas.QUALITY_MULT and Formulas.QUALITY_MULT[qualityId]) or 1
end
-- //!SECTION

function FishCalculator.GenerateStats(qualityId: number): (number, number)
	local qualityMult = getQualityMult(qualityId)

	-- Base values for fish stats
	local baseMaxHP = 100
	local baseWeight = 1.0

	-- Apply quality multiplier
	local maxHP = baseMaxHP * qualityMult
	local weight = baseWeight * qualityMult

	-- Add variance to make each fish unique (±10% variance)
	maxHP = addDeviance(maxHP, 0.10)
	weight = addDeviance(weight, 0.10)

	-- Round/clamp to reasonable values
	maxHP = math.max(1, math.floor(maxHP + 0.5))
	weight = math.max(0.1, math.floor(weight * 100 + 0.5) / 100) -- Round to 2 decimal places

	return maxHP, weight
end

return FishCalculator
