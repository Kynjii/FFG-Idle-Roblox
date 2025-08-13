local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)

local FFGDefaults = {}

FFGDefaults.DebounceCD = 3

FFGDefaults.SUFFIXES = {
	{ value = 1e54, symbol = "Et" }, -- Eternium
	{ value = 1e51, symbol = "St" }, -- Starwoven
	{ value = 1e48, symbol = "Vs" }, -- Voidshard
	{ value = 1e45, symbol = "Tg" }, -- Thronesteel
	{ value = 1e42, symbol = "Sk" }, -- Skyglass
	{ value = 1e39, symbol = "Nf" }, -- Nightfur
	{ value = 1e36, symbol = "Op" }, -- Opalflame
	{ value = 1e33, symbol = "Ar" }, -- Arcanite
	{ value = 1e30, symbol = "Lp" }, -- Lumipaw
	{ value = 1e27, symbol = "Al" }, -- Astralite
	{ value = 1e24, symbol = "Dr" }, -- Dragonite
	{ value = 1e21, symbol = "Ct" }, -- Celestite
	{ value = 1e18, symbol = "My" }, -- Mythril
	{ value = 1e15, symbol = "Qa" }, -- Quadrillion
	{ value = 1e12, symbol = "T" }, -- Trillion
	{ value = 1e9, symbol = "B" }, -- Billion
	{ value = 1e6, symbol = "M" }, -- Million
	{ value = 1e3, symbol = "K" }, -- Thousand
}

FFGDefaults.BOAT_STARTING_ATT = {
	[FFGEnum.ATTRIBUTES.Name] = FFGEnum.BOAT.NAME[1],
	[FFGEnum.ATTRIBUTES.isUnlocked] = false,
	[FFGEnum.ATTRIBUTES.isActive] = false,
	[FFGEnum.ATTRIBUTES.Level] = 1,
	[FFGEnum.ATTRIBUTES.UpgradeStage] = 1,
}

return FFGDefaults
