local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Charm = require(ReplicatedStorage.Packages.Charm)
local RodType = require(ReplicatedStorage.Shared.Types.RodType)

export type state = {
    Gold: () -> number,
    SelectedRod: () -> RodType.FishingRodType | nil,
    SelectedMenuTab: () -> "Crew" | "Jobs" | "Fishing",
}

local PlayerStateService = {}
export type PlayerStateService = typeof(PlayerStateService)

PlayerStateService.State = {} :: state

local function createState(profile): state
    return {
        Gold = Charm.atom(profile.Data.Currencies.Gold or 0),
        SelectedRod = Charm.atom(nil),
        SelectedMenuTab = Charm.atom("Fishing"),
    }
end

function PlayerStateService:InitPlayer(player, profile)
    local state = createState(profile)
    self.State[player] = state
    return state
end

function PlayerStateService:Get(player): { [any]: any }
    return self.State[player]
end

function PlayerStateService:RemovePlayer(player)
    self.State[player] = nil
end

return PlayerStateService
