export type FishingRodType = {
	Entity: string,
	Name: string,
	Id: number,
	QualityId: number,
	BaseDmg: number,
	Cost: number,
	CurrencyType: string,
	LevelRequirement: number,
	ItemImage: string,
	Stats: {
		ReelPower: number,
		LineControl: number,
		Stability: number,
	},
	Description: string,
}

local FishingRodType: FishingRodType = {}

return FishingRodType
