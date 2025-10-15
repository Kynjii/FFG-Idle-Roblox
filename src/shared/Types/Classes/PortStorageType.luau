local PortStorageType = {}

export type PortStorageData = {
	Id: string,
	TeamId: number,
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
	NextLvlMaxStorage: number?,
	FishInStorage: number,
	StorageFull: boolean,
	GrowthRate: number?,
	CostGrowthRate: number?,
	VisualRoot: any,
	VisualModels: { [number]: Model }?,
	CurrentVisualModel: Model?,
	TakeFishPrompt: ProximityPrompt?,
	PurchaseBoard: Model,
	PBDetails: { [string]: any }?,
	ClonedBillboard: Instance?,
	_cleaner: any?,
	Buffs: { [string]: any },
	ProgressTween: any?,
	FishModel: UnionOperation?,
}

export type StorageInstance = {
	-- Essential Properties (accessed by other modules)
	Entity: string,
	Owner: string,
	Level: number,
	UpgradeStage: number,
	isPurchased: boolean,
	FishInStorage: number?,
	CurrentMaxStorage: number?,
	StorageFull: boolean?,
	Buffs: { [string]: any }?,
	PBDetails: { [string]: any }?,

	-- Essential Methods (called by other modules)
	GetName: (self: StorageInstance) -> string,
	Initialize: (self: StorageInstance) -> (),
	Destroy: (self: StorageInstance) -> (),

	-- Allow any other properties/methods for internal use
	[string]: any,
}

export type PortStorageModule = {
	New: (state: { [string]: any }?, player: Player, model: Model) -> StorageInstance,
}

return PortStorageType
