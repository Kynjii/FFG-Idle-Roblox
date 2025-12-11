local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Charm = require(ReplicatedStorage.Packages.Charm)
local React = require(ReplicatedStorage.Packages.React)
local RC = require(ReplicatedStorage.Packages["React-charm"])
local PlayerStateService = require(ReplicatedStorage.Shared.Atoms.PlayerStateService)
local e = React.createElement

type FishingLevelState = {
    FishingLevel: number?,
    FishingXP: number?,
    TotalForNextLevel: number?,
    TotalForCurrentLevel: number?,
}

local FishingSkillBar = {}

function FishingSkillBar.component()
    local fishingLevelState: FishingLevelState, setFishingLevelState = RC.useAtom(PlayerStateService.State.FishingSkillState)

    local progress = Charm.computed(function()
        local newState = table.clone(fishingLevelState) :: FishingLevelState
        local newXpAmount = newState.FishingXP or 0
        local totalForCurrentLevel = newState.TotalForCurrentLevel or 0
        local totalForNextLevel = newState.TotalForNextLevel or 0

        local currentLevelProgress = newXpAmount - totalForCurrentLevel
        local xpNeededForThisLevel = totalForNextLevel - totalForCurrentLevel

        local progress = (xpNeededForThisLevel > 0) and math.clamp(currentLevelProgress / xpNeededForThisLevel, 0, 1) or 0

        return progress
    end)

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.99),
        Size = UDim2.fromScale(0.4, 0.04),
    }, {
        uIListLayout = e("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
        }),

        currentLevel = e("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            FontFace = Font.new("rbxasset://fonts/families/Bangers.json"),
            LayoutOrder = 1,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.1, 1),
            Text = `{fishingLevelState.FishingLevel}`,
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
        }, {
            uIStroke = e("UIStroke", {
                Thickness = 2,
            }),
        }),

        nextLevel = e("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            FontFace = Font.new("rbxasset://fonts/families/Bangers.json"),
            LayoutOrder = 3,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.1, 1),
            Text = `{fishingLevelState.FishingLevel + 1}`,
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
        }, {
            uIStroke = e("UIStroke", {
                Thickness = 2,
            }),
        }),

        progressContainer = e("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = 2,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.8, 1),
        }, {
            progressBG = e("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Image = "rbxassetid://79661382966531",
                ImageColor3 = Color3.fromRGB(6, 38, 65),
                Position = UDim2.fromScale(0.5, 0.5),
                ScaleType = Enum.ScaleType.Slice,
                Size = UDim2.fromScale(1, 1),
                SliceCenter = Rect.new(62, 72, 72, 77),
            }, {
                progressBar = e("ImageLabel", {
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://79661382966531",
                    ImageColor3 = Color3.fromRGB(62, 255, 62),
                    Position = UDim2.fromScale(0, 0.5),
                    ScaleType = Enum.ScaleType.Slice,
                    Size = UDim2.fromScale(progress(), 1),
                    SliceCenter = Rect.new(62, 72, 72, 77),
                    ZIndex = 2,
                }),
            }),
        }),
    })
end

return FishingSkillBar
