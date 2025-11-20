local DifficultyModule = {}

local SPECIES_MODIFIERS = {
	-- Basic/Common species (0.8-1.0)
	Goldfish = 0.8,
	Guppy = 0.8,
	Bitterling = 0.8,
	PaleChub = 0.9,
	Killifish = 0.9,
	Dace = 0.9,

	-- Moderate species (1.0-1.2)
	Bass = 1.0,
	SmallBass = 0.9,
	Bluegill = 1.0,
	Carp = 1.0,
	Salmon = 1.0,
	CrucianCarp = 1.0,
	BrookTrout = 1.0,
	FreshwaterGoby = 1.0,
	Sweetfish = 1.1,
	CherrySalmon = 1.1,
	Catfish = 1.1,
	RainbowTrout = 1.1,
	PondSmelt = 1.1,
	Loach = 1.1,
	PopeyedGoldfish = 1.2,

	-- Challenging species (1.2-1.5)
	SeaBass = 1.2,
	LargeBass = 1.3,
	Frog = 1.2,
	Crawfish = 1.2,
	Eel = 1.3,
	Piranha = 1.4,
	RedSnapper = 1.4,
	Koi = 1.4,
	LargeChar = 1.4,

	-- Rare/Difficult species (1.5+)
	Angelfish = 1.5,
	BarredKnifejaw = 1.6,
	GiantCatfish = 1.7,
	Jellyfish = 1.6,
	Arowana = 1.8,
	BarbelSteed = 1.8,
	GiantSnakehead = 1.9,
	Arapaima = 2.0,
	Stringfish = 2.2,
	Coelacanth = 2.5,
}

local VARIANT_MODIFIERS = {
	Normal = 1.0,
	Elemental = 1.3,
	Elder = 1.6,
}

function DifficultyModule.GetFishPower(fish)
	if not fish then return 1 end

	local qualityId = fish.QualityId or 1
	local tier = fish.Tier or 1
	local species = fish.Species or "Salmon"
	local variant = fish.Variant or "Normal"
	local baseWeight = fish.BaseWeight or 1

	local speciesMod = SPECIES_MODIFIERS[species] or 1.0
	local variantMod = VARIANT_MODIFIERS[variant] or 1.0

	local qualityComponent = 1 + qualityId * 0.4
	local tierComponent = 1 + tier * 0.6

	local power = 10 * qualityComponent * tierComponent * speciesMod * variantMod * baseWeight

	return power
end

function DifficultyModule.GetPlayerPower(playerData, rodData)
	playerData = playerData or {}
	rodData = rodData or {}

	local level = playerData.FishingLevel or 1
	local rodQuality = rodData.QualityId or 1

	local stats = rodData.Stats or {}
	local reelPower = stats.ReelPower or 0

	local levelComponent = 5 + level * 1.5
	local rodComponent = 5 + rodQuality * 3
	local reelComponent = reelPower * 1.2

	local power = levelComponent + rodComponent + reelComponent

	return power
end

function DifficultyModule.GetDifficultyFactor(playerData, rodData, fish)
	local playerPower = DifficultyModule.GetPlayerPower(playerData, rodData)
	local fishPower = DifficultyModule.GetFishPower(fish)

	local safePlayerPower = math.max(playerPower, 1)

	local factor = fishPower / safePlayerPower

	return factor, playerPower, fishPower
end

return DifficultyModule
