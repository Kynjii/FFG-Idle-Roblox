local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Ripple = require(ReplicatedStorage.Packages.Ripple)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)

local rTween = Ripple.createTween
local R = React
local e = React.createElement

type Props = {
    state: number?,
}

local KinProgressBar = {}

function KinProgressBar.component(props: Props)
    local progressRef = R.useRef(nil)

    print(props)

    R.useEffect(function()
        local progressBar: ImageLabel = progressRef.current
        if not progressBar then
            return
        end

        print(progressRef.current)

        local tween = rTween(progressBar, {
            easing = "linear",
            duration = 1,
        })

        tween:setGoal(progressBar, {
            Size = UDim2.fromScale(props.state or 0, 1),
        })

        tween:start()
    end, { props.state })

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        LayoutOrder = 2,
        Position = FFGEnum.THEME.alignment.position.center,
        Size = UDim2.fromScale(0.8, 1),
    }, {
        progressBG = e("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Image = "rbxassetid://79661382966531",
            ImageColor3 = FFGEnum.UI.ProgressBar.BackgroundColor,
            Position = FFGEnum.THEME.alignment.position.center,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.fromScale(1, 1),
            SliceCenter = FFGEnum.UI.ProgressBar.BackgroundWhite.SliceCenter,
        }, {
            progressBar = e("ImageLabel", {
                key = "Progressbar",
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = "rbxassetid://79661382966531",
                ImageColor3 = Color3.fromRGB(62, 255, 62),
                Position = UDim2.fromScale(0, 0.5),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = FFGEnum.UI.ProgressBar.BackgroundWhite.SliceCenter,
                ZIndex = 2,
                ref = progressRef,
            }),
        }),
    })
end

return KinProgressBar
