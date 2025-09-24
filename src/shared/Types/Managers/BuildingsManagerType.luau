local BuildingsManagerType = {}

export type BuildingsManagerInstance = {
	-- Props
	Player: Player,
	TeamId: number,

	-- Main Actions
	Initialize: (self: BuildingsManagerInstance) -> (),

	-- Cleanup
	Destroy: (self: BuildingsManagerInstance) -> (),
}

export type BuildingsManager = {
	New: (realmData: { [string]: any }, player: Player, teamId: number) -> BuildingsManagerInstance,
}

return BuildingsManagerType
