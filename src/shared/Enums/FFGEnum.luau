local FFGEnum = {}

FFGEnum.FONT = Enum.Font.FredokaOne

FFGEnum.QUALITY_PROMOTION_LEVELS = {
	[1] = 9,
	[2] = 24,
	[3] = 49,
	[4] = 99,
	[5] = 149,
	[6] = 199,
	[7] = 249,
	[8] = 349,
	[9] = 449,
	[10] = 549,
	[11] = 700,
}

FFGEnum.BOAT = {
	NAME = {
		[1] = "Driftwood Skiff",
		[2] = "Netting Dory",
		[3] = "Herring Lugger",
		[4] = "Tidecaller Canoe",
		[5] = "Seablessed Punt",
		[6] = "Knight's Hull",
		[7] = "Crimson Cutter",
		[8] = "Ironhook Galley",
		[9] = "Mariner’s Galleon",
		[10] = "Wyrmcatcher",
		[11] = "The Flynnrunner",
	},
}

FFGEnum.TENDER = {
	NAME = {
		[1] = "Wooden Cart-Barge",
		[2] = "Barrel Barge",
		[3] = "Oarsman’s Ferry",
		[4] = "Courier Skiff",
		[5] = "Windcloak Sloop",
		[6] = "Seawarden’s Tender",
		[7] = "Crate Hauler",
		[8] = "Knight’s Courier",
		[9] = "Harbormaster’s Crest",
		[10] = "Starlit Barge",
		[11] = "Little Lucy",
	},
}

FFGEnum.QUALITY = {
	[1] = {
		label = "Common",
		color = Color3.fromHex("#BFBFBF"),
	},
	[2] = {
		label = "Uncommon",
		color = Color3.fromHex("#3EFF3E"),
	},
	[3] = {
		label = "Rare",
		color = Color3.fromHex("#0070DD"),
	},
	[4] = {
		label = "Epic",
		color = Color3.fromHex("#A335EE"),
	},
	[5] = {
		label = "Legendary",
		color = Color3.fromHex("#FF9A00"),
	},
	[6] = {
		label = "Exotic",
		color = Color3.fromHex("#E6C266"),
	},
	[7] = {
		label = "Ascended",
		color = Color3.fromHex("#FF66CC"),
	},
	[8] = {
		label = "Mythic",
		color = Color3.fromHex("#00FFFF"),
	},
	[9] = {
		label = "Divine",
		color = Color3.fromHex("#FFD700"),
	},
	[10] = {
		label = "Eternal",
		color = Color3.fromHex("#C0C0FF"),
	},
	[11] = {
		label = "Transcendent",
		color = Color3.fromHex("#F5E663"),
	},
}

FFGEnum.ATTRIBUTES = {
	["Level"] = "Level",
	["UpgradeLevel"] = "UpgradeLevel",
	["Name"] = "Name",
	["isUnlocked"] = "isUnlocked",
	["isActive"] = "isActive",
}

FFGEnum.CURRENCY_TYPES = {
	["Gold"] = "Gold",
}

FFGEnum.SUFFIXES = {
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

return FFGEnum
