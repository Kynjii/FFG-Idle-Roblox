local BoatType = require(script.Parent.BoatType)
local TenderType = require(script.Parent.TenderType)
local BoatManagerType = {}

export type BoatManagerInstance = {
	-- Props
	Owner: number,
	Tier: number,
	BoatModel: Model,
	LaneBoat: BoatType.BoatInstance,
	TenderModel: Model,
	LaneTender: TenderType.TenderInstance,

	-- Methods
	FindBoatModel: (self: BoatManagerInstance, player: Player, tier: number) -> Model | nil,
	FindTenderModel: (self: BoatManagerInstance, player: Player, tier: number) -> Model | nil,
	Initialize: (self: BoatManagerInstance) -> (),
}

export type BoatManager = {
	New: (boatProps: BoatType.BoatProps, tenderProps: TenderType.TenderProps, player: Player, model: Model) -> BoatManagerInstance,
}

return BoatManagerType
