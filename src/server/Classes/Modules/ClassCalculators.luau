local ServerScriptService = game:GetService("ServerScriptService")
local Formulas = require(ServerScriptService.Server.Math.Formulas)

local ClassCalculator = {}

local function clampLevel(level: number)
	level = tonumber(level) or 1
	return math.clamp(level, 1, Formulas.MAX_LEVEL or 100)
end

local function clampStage(s)
	s = tonumber(s) or 1
	return math.clamp(s, 1, Formulas.STAGE_COUNT or 1)
end

function ClassCalculator.CalculateBaseValue(baseValue: number, tier: number, realmNum: number)
	local tierMultiplier = Formulas.TIER_MULTIPLIER[tier] or 1
	local realmMultiplier = (realmNum and math.pow(realmNum, 2.25)) or 1
	return baseValue * tierMultiplier * realmMultiplier
end

function ClassCalculator.CalculateUpgradeCost(baseValue: number, level: number, tier: number?, realmId: number?)
	level = clampLevel(level)
	local costMult = (Formulas.COST_MULT and Formulas.COST_MULT[level]) or 1

	return baseValue * costMult
end

function ClassCalculator.CalculateMaxStorage(baseValue: number, level: number, percentBuffValue: number?)
	local lvl = clampLevel(level)
	local nextLvl = clampLevel(level + 1)

	local earnNow = (Formulas.EARN_MULT and Formulas.EARN_MULT[lvl]) or 1
	local earnNext = (Formulas.EARN_MULT and Formulas.EARN_MULT[nextLvl]) or earnNow

	local maxStorage = baseValue * earnNow
	local nextLvlStorage = baseValue * earnNext

	if percentBuffValue then
		local buffedValue = percentBuffValue * maxStorage
		local buffedNxtvalue = percentBuffValue * nextLvlStorage
		maxStorage += buffedValue
		nextLvlStorage += buffedNxtvalue
	end

	return maxStorage, nextLvlStorage
end

function ClassCalculator.CalculateFPS(baseFPS: number, level: number, percentBuffValue: number?)
	local lvl = clampLevel(level)
	local nextLvl = clampLevel(level + 1)

	local multNow = (Formulas.EARN_MULT and Formulas.EARN_MULT[lvl]) or 1
	local multNext = (Formulas.EARN_MULT and Formulas.EARN_MULT[nextLvl]) or multNow

	local fpsNow = baseFPS * multNow
	local fpsNext = baseFPS * multNext

	if percentBuffValue then
		local buffedValue = percentBuffValue * fpsNow
		local buffedNxtvalue = percentBuffValue * fpsNext
		fpsNow += buffedValue
		fpsNext += buffedNxtvalue
	end

	return fpsNow, fpsNext
end

function ClassCalculator.CalculateTravelTime(baseValue: number, percentBuffValue: number?)
	local travelTime = math.max(1, baseValue)

	if percentBuffValue then
		-- Clamp the buff to maximum 95% reduction
		local clampedBuffValue = math.min(percentBuffValue, 0.95)
		local buffedValue = clampedBuffValue * travelTime
		travelTime -= buffedValue
	end

	-- Ensure minimum travel time (5% of original)
	travelTime = math.max(travelTime, baseValue * 0.05)

	return travelTime
end

function ClassCalculator.CalculateLoadTime(baseValue: number, percentBuffValue: number?)
	local loadTime = baseValue

	if percentBuffValue then
		-- Clamp the buff to maximum 95% reduction
		local clampedBuffValue = math.min(percentBuffValue, 0.95)
		local buffedValue = clampedBuffValue * loadTime
		loadTime -= buffedValue
	end

	-- Ensure minimum load time (5% of original)
	loadTime = math.max(loadTime, baseValue * 0.05)

	return loadTime
end

return ClassCalculator
