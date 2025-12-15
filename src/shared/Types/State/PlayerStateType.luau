export type Type = {
    Gold: () -> number,
    FishingSkillState: () -> {
        FishingLevel: number,
        FishingXP: number,
        TotalForNextLevel: number,
        TotalForCurrentLevel: number,
    },
}

local State = {} :: Type

return State
