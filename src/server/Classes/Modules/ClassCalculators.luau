local ServerScriptService = game:GetService("ServerScriptService")
local Formulas = require(ServerScriptService.Server.Math.Formulas)

local ClassCalculator = {}

--=============================
-- Helpers / clamps
--=============================

local function clampLevel(level: number): number
    level = tonumber(level) or 1
    return math.clamp(level, 1, Formulas.MAX_LEVEL or 100)
end

local function clampStage(stage: number): number
    stage = tonumber(stage) or 1
    return math.clamp(stage, 1, Formulas.STAGE_COUNT or 1)
end

-- Get Stage index from a level (uses your existing function)
local function getStageForLevel(level: number): number
    return Formulas.StageForLevel(level)
end

-- Stage multiplier (normalized so Stage 1 == 1.0)
local function getStageMult(stageIndex: number): number
    local s = clampStage(stageIndex)
    local base = Formulas.STAGE_EARN_MULT[1] or 1
    local raw = Formulas.STAGE_EARN_MULT[s] or base
    return (base ~= 0) and (raw / base) or 1
end

-- Convert Stage power into a time-reduction fraction (0..cap)
local function getStageTimeReductionFraction(stageIndex: number): number
    local stageMult = getStageMult(stageIndex) -- e.g., 1.00 .. ~1.9 normalized
    local coeff = Formulas.STAGE_TIME_REDUCTION_COEFF or 0.20
    local cap = Formulas.MAX_STAGE_TIME_REDUCTION or 0.50
    local reduction = (stageMult - 1) * coeff
    if reduction > cap then
        reduction = cap
    end
    if reduction < 0 then
        reduction = 0
    end
    return reduction
end

--=============================
-- Base / cost
--=============================

function ClassCalculator.CalculateBaseValue(baseValue: number, tier: number, realmNum: number)
    local tierMultiplier = (Formulas.TIER_MULTIPLIER and Formulas.TIER_MULTIPLIER[tier]) or 1
    local realmMultiplier = (realmNum and math.pow(realmNum, 2.25)) or 1
    return baseValue * tierMultiplier * realmMultiplier
end

function ClassCalculator.CalculateUpgradeCost(baseValue: number, level: number, tier: number?, realmId: number?)
    level = clampLevel(level)
    local costMult = (Formulas.GetCostMultiplier and Formulas.GetCostMultiplier(level)) or (Formulas.COST_MULT and Formulas.COST_MULT[level]) or 1
    return baseValue * costMult
end

--=============================
-- “Up” stats: Level adds, then Stage multiplies
--=============================

-- Storage: (base + perLevel*(level-1)) × stageMult × (1 + %buff)
-- Returns: current, nextLevel (nextLevel uses its own stage if it crosses a promo)
function ClassCalculator.CalculateMaxStorage(
    baseStorage: number,
    level: number,
    percentBuffValue: number? -- optional multiplicative bonus, e.g. 0.12 = +12%
)
    local lvl = clampLevel(level)
    local nextLvl = clampLevel(level + 1)

    local perLevelAdd = Formulas.PER_LEVEL_STORAGE_ADD or 0

    local leveledNow = baseStorage + perLevelAdd * (lvl - 1)
    local leveledNxt = baseStorage + perLevelAdd * (nextLvl - 1)

    -- Stage is derived from level; next level may enter a new stage
    local stageNow = getStageForLevel(lvl)
    local stageNxt = getStageForLevel(nextLvl)

    local stageMultNow = getStageMult(stageNow)
    local stageMultNxt = getStageMult(stageNxt)

    local storageNow = leveledNow * stageMultNow
    local storageNxt = leveledNxt * stageMultNxt

    if percentBuffValue and percentBuffValue ~= 0 then
        local mult = 1 + percentBuffValue
        storageNow = storageNow * mult
        storageNxt = storageNxt * mult
    end

    return math.floor(storageNow + 0.5), math.floor(storageNxt + 0.5)
end

-- FPS (rate): (base + perLevel*(level-1)) × stageMult × (1 + %buff)
function ClassCalculator.CalculateFPS(baseFPS: number, level: number, percentBuffValue: number?)
    local lvl = clampLevel(level)
    local nextLvl = clampLevel(level + 1)

    local perLevelAdd = Formulas.PER_LEVEL_FPS_ADD or 0

    local leveledNow = baseFPS + perLevelAdd * (lvl - 1)
    local leveledNxt = baseFPS + perLevelAdd * (nextLvl - 1)

    local stageNow = getStageForLevel(lvl)
    local stageNxt = getStageForLevel(nextLvl)

    local stageMultNow = getStageMult(stageNow)
    local stageMultNxt = getStageMult(stageNxt)

    local fpsNow = leveledNow * stageMultNow
    local fpsNxt = leveledNxt * stageMultNxt

    if percentBuffValue and percentBuffValue ~= 0 then
        local mult = 1 + percentBuffValue
        fpsNow = fpsNow * mult
        fpsNxt = fpsNxt * mult
    end

    return math.floor(fpsNow + 0.5), math.floor(fpsNxt + 0.5)
end

--=============================
-- Time stats: multiplicative reductions + floor
--=============================

-- Lower is better:
-- final = base × (1 - stageReduction) × (1 - buff)  clamped to TIME_MIN_FRACTION of base
function ClassCalculator.CalculateTravelTime(baseTimeSeconds: number, level: number, percentBuffValue: number?)
    local lvl = clampLevel(level)
    local stageIndex = getStageForLevel(lvl)

    local finalTime = math.max(1, baseTimeSeconds)

    local stageReduction = getStageTimeReductionFraction(stageIndex) -- 0..cap
    local combinedFactor = (1 - stageReduction)

    if percentBuffValue and percentBuffValue ~= 0 then
        local r = math.min(percentBuffValue, 0.95)
        combinedFactor = combinedFactor * (1 - r)
    end

    finalTime = finalTime * combinedFactor

    local minFrac = Formulas.TIME_MIN_FRACTION or 0.05
    local minTime = baseTimeSeconds * minFrac
    if finalTime < minTime then
        finalTime = minTime
    end

    return math.floor(finalTime + 0.5)
end

function ClassCalculator.CalculateLoadTime(baseTimeSeconds: number, level: number, percentBuffValue: number?)
    local lvl = clampLevel(level)
    local stageIndex = getStageForLevel(lvl)

    local timeValue = math.max(1, baseTimeSeconds)

    local stageReduction = getStageTimeReductionFraction(stageIndex)
    local combinedFactor = (1 - stageReduction)

    if percentBuffValue and percentBuffValue ~= 0 then
        local r = math.min(percentBuffValue, 0.95)
        combinedFactor = combinedFactor * (1 - r)
    end

    timeValue = timeValue * combinedFactor

    local minFrac = Formulas.TIME_MIN_FRACTION or 0.05
    local minTime = baseTimeSeconds * minFrac
    if timeValue < minTime then
        timeValue = minTime
    end

    return math.floor(timeValue + 0.5)
end

return ClassCalculator
