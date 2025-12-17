local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Charm = require(ReplicatedStorage.Packages.Charm)
local RCharm = require(ReplicatedStorage.Packages.RCharm)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

local FishingTimingBar = {}

function FishingTimingBar.component(props: {
    ButtonPressedAtom: Charm.Atom<boolean>,
    HitMarkerPosition: Charm.Atom<UDim2>,
    Refs: {
        Hitmarker: Charm.Atom<Instance?>,
        Area1: Charm.Atom<Instance?>,
        Area2: Charm.Atom<Instance?>,
        Area3: Charm.Atom<Instance?>,
    },
})
    local buttonPressed = props.ButtonPressedAtom
    local hitMarkerPosition = RCharm.useAtom(props.HitMarkerPosition)

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Position = UDim2.fromScale(0.275132, 0.523094),
        Size = UDim2.fromScale(0.056363, 0.616813),
    }, {
        hitMarker = e("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://122480152315849",
            ImageColor3 = Color3.fromRGB(0, 255, 17),
            Position = hitMarkerPosition,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.fromScale(1.1, 0.01),
            SliceCenter = Rect.new(4, 29, 5, 31),
            ZIndex = 10,
            ref = props.Refs.Hitmarker,
        }, {
            uIStroke = e("UIStroke", {
                LineJoinMode = Enum.LineJoinMode.Bevel,
                Thickness = 2.1,
            }),
        }),

        uIStroke = e("UIStroke", {
            Thickness = 1.6,
        }),

        uICorner = e("UICorner", {
            CornerRadius = UDim.new(0, 3),
        }),

        inner = e("CanvasGroup", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1),
        }, {
            hitBoxContainer = e("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.new(1, 1, 1),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(1, 0.317),
                ref = props.Refs.Area3,
            }, {
                uICorner = e("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                }),

                innerHit = e("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderColor3 = Color3.new(),
                    BorderSizePixel = 0,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromScale(1, 0.537),
                    ZIndex = 2,
                    ref = props.Refs.Area2,
                }, {
                    uIGradient = e("UIGradient", {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 169, 21)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 161, 21)),
                        }),
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(0.935518, 0.18125),
                            NumberSequenceKeypoint.new(1, 0),
                        }),
                    }),
                }),

                bullseye = e("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderColor3 = Color3.new(),
                    BorderSizePixel = 0,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromScale(1, 0.236),
                    ZIndex = 5,
                    ref = props.Refs.Area1,
                }, {
                    uIGradient = e("UIGradient", {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 255, 16)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 255, 0)),
                        }),
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(0.935518, 0.18125),
                            NumberSequenceKeypoint.new(1, 0),
                        }),
                    }),
                }),

                uIGradient = e("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 239, 15)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)),
                    }),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.935518, 0.18125),
                        NumberSequenceKeypoint.new(1, 0),
                    }),
                }),
            }),

            uICorner = e("UICorner", {
                CornerRadius = UDim.new(0, 3),
            }),
        }),

        catchButton = e("ImageButton", {
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            Position = UDim2.fromScale(0.5, 1.02),
            Size = UDim2.fromScale(2.11351, 0.172228),
        }, {
            uICorner = e("UICorner", {
                CornerRadius = UDim.new(1, 0),
            }),

            uIStroke = e("UIStroke", {
                Thickness = 2,
            }),

            uIAspectRatioConstraint = e("UIAspectRatioConstraint"),

            textLabel = e("TextLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                FontFace = Font.new("rbxasset://fonts/families/Bangers.json"),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(0.6, 0.6),
                Text = "Hold",
                TextColor3 = Color3.new(1, 1, 1),
                TextScaled = true,
            }),

            uIGradient = e("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)),
                }),
                Rotation = 19,
            }),

            [React.Event.InputBegan] = function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    buttonPressed(true)
                end
            end,

            [React.Event.InputEnded] = function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    buttonPressed(false)
                end
            end,
        }),

        uIGradient = e("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(49, 49, 49)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 79, 175)),
            }),
            Rotation = -90,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.498943, 0.9875),
                NumberSequenceKeypoint.new(1, 0),
            }),
        }),
    })
end

return FishingTimingBar
