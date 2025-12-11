local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RodType = require(ReplicatedStorage.Shared.Types.RodType)
export type Type = {
    Gold: () -> number,
    SelectedRod: () -> RodType.FishingRodType | nil,
    SelectedMenuTab: () -> "Crew" | "Jobs" | "Fishing",
    FishingSkillState: (
    ) -> {
        FishingLevel: number,
        FishingXP: number,
        TotalForNextLevel: number,
        TotalForCurrentLevel: number,
    },
}

local State = {} :: Type

return State
