local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)
local RodType = require(ReplicatedStorage.Shared.Types.RodType)

local PlayerStateService = {}

export type PlayerStateService = typeof(PlayerStateService)

export type state = {
    Gold: () -> number,
    SelectedRod: () -> RodType.FishingRodType | nil,
    SelectedMenuTab: () -> "Crew" | "Jobs" | "Fishing",
}

PlayerStateService.State = {
    Gold = Charm.atom(0),
    SelectedRod = Charm.atom(nil),
    SelectedMenuTab = Charm.atom("Fishing"),
}

function PlayerStateService:Get(): state
    return self.State
end

return PlayerStateService
