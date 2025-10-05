local BoatType = {}

export type BoatData = {
	Id: string,
	Owner: number,
	RealmId: number,
	Tier: number,
	Name: string,
	Level: number,
	MaxLevel: number,
	BaseCost: number,
	UpgradeCost: number,
	isPurchased: boolean,
	UpgradeStage: number,
	Entity: string,
	Description: string,
	Model: Model,
	Player: Player,
	BaseStorage: number,
	CurrentMaxStorage: number,
	NextLvlMaxStorage: number,
	FishInStorage: number,
	StorageFull: boolean,
	BaseFPS: number,
	CurrentFPS: number,
	NextFPS: number,
	GrowthRate: number?,
	CostGrowthRate: number?,
	VisualRoot: Part,
	FishingInterval: any?,
	Animations: { [string]: any }?,
	VisualModels: { [number]: Model }?,
	CurrentVisualModel: Model?,
	PurchaseBoard: Model,
	PBDetails: { [string]: any }?,
	_cleaner: any?,
	Buffs: { [string]: any },
}

export type BoatInstance = {
	-- Essential Properties (accessed by other modules)
	Entity: string,
	Owner: string,
	Level: number,
	UpgradeStage: number,
	isPurchased: boolean,
	FishInStorage: number?,
	CurrentMaxStorage: number?,
	CurrentFPS: number?,
	StorageFull: boolean?,
	Buffs: { [string]: any }?,
	PBDetails: { [string]: any }?,

	-- Essential Methods (called by other modules)
	GetName: (self: BoatInstance) -> string,
	Initialize: (self: BoatInstance) -> (),
	Destroy: (self: BoatInstance) -> (),

	-- Allow any other properties/methods for internal use
	[string]: any,
}

export type BoatModule = {
	New: (state: { [string]: any }?, player: Player, model: Model) -> BoatInstance,
}

return BoatType
