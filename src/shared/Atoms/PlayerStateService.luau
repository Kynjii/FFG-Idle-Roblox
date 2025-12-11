local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)
local PlayerStateType = require(ReplicatedStorage.Shared.Types.State.PlayerStateType)

local PlayerStateService = {}

export type PlayerStateService = typeof(PlayerStateService)

PlayerStateService.State = {
    Gold = Charm.atom(0),
    SelectedRod = Charm.atom(nil),
    SelectedMenuTab = Charm.atom(""),
    FishingSkillState = Charm.atom({}),
}

function PlayerStateService:Get(): PlayerStateType.Type
    return self.State
end

return PlayerStateService
