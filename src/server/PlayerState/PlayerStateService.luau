local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Charm = require(ReplicatedStorage.Packages.Charm)
local PlayerStateType = require(ReplicatedStorage.Shared.Types.State.PlayerStateType)

local PlayerStateService = {}
export type PlayerStateService = typeof(PlayerStateService)

PlayerStateService.State = {} :: { [Player]: { PlayerStateType.Type } }

local function createState(profile): PlayerStateType.Type
    return {
        Gold = Charm.atom(profile.Data.Currencies.Gold or 0),
        SelectedRod = Charm.atom(nil),
        SelectedMenuTab = Charm.atom(""),
        FishingSkillState = Charm.atom(profile.Data.Skills.Fishing),
    }
end

function PlayerStateService:InitPlayer(player, profile)
    local state = createState(profile)
    self.State[player] = state
    return state
end

function PlayerStateService:Get(player): PlayerStateType.Type
    return self.State[player]
end

function PlayerStateService:RemovePlayer(player)
    self.State[player] = nil
end

return PlayerStateService
