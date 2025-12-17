local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRipple = require(ReplicatedStorage.Packages.ReactRipple)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)

local useTween = ReactRipple.useTween
local R = React
local e = React.createElement

type Props = {
    state: number?,
    forY: boolean?,
}

local KinProgressBar = {}

function KinProgressBar.component(props: Props)
    local progressBinding, progressTween = useTween(0, { easing = "linear", duration = 1 })

    R.useEffect(function()
        progressTween:setGoal(props.state)
        progressTween:start()
    end, { props.state })

    return e("Frame", {
        AnchorPoint = FFGEnum.THEME.alignment.anchor.center,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        LayoutOrder = 2,
        Position = FFGEnum.THEME.alignment.position.center,
        Size = UDim2.fromScale(0.8, 1),
    }, {
        progressBG = e("ImageLabel", {
            AnchorPoint = FFGEnum.THEME.alignment.anchor.center,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Image = FFGEnum.UI.ProgressBar.BackgroundWhite.Asset,
            ImageColor3 = FFGEnum.UI.ProgressBar.BackgroundColor,
            Position = FFGEnum.THEME.alignment.position.center,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.fromScale(1, 1),
            SliceCenter = FFGEnum.UI.ProgressBar.BackgroundWhite.SliceCenter,
        }, {
            progressBar = e("ImageLabel", {
                AnchorPoint = FFGEnum.THEME.alignment.anchor.left,
                BackgroundTransparency = 1,
                Image = FFGEnum.UI.ProgressBar.BackgroundWhite.Asset,
                ImageColor3 = Color3.fromRGB(62, 255, 62),
                Position = FFGEnum.THEME.alignment.position.left,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = FFGEnum.UI.ProgressBar.BackgroundWhite.SliceCenter,
                ZIndex = 2,
                Size = progressBinding:map(function(p)
                    if props.forY then
                        return UDim2.fromScale(1, p)
                    else
                        return UDim2.fromScale(p, 1)
                    end
                end),
            }),
        }),
    })
end

function KinProgressBar.CalculateProgress(currentValue: number, maxValue: number): number
    local max = maxValue or 0
    local current = currentValue or 0
    local progress = (max > 0) and math.clamp(current / max, 0, 1) or 0

    return progress
end

return KinProgressBar
