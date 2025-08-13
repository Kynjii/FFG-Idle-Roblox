local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGDefaults = require(ReplicatedStorage.Shared.Utils.FFGDefaults)
return {
	Realms = {
		[1] = {
			isUnlocked = true,
			Lanes = {
				Tier_1 = {
					isPurchased = true,
					Boat = FFGDefaults.BOAT_STARTING_ATT,
				},
			},
		},
		[2] = {
			isUnlocked = false,
		},
		[3] = {
			isUnlocked = false,
		},
		[4] = {
			isUnlocked = false,
		},
	},
	Currencies = {
		Gold = 250,
	},
}
