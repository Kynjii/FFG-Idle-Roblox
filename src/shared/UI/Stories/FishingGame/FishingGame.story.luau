local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages["React-roblox"])
local FishingMiniGame = require(ReplicatedStorage.Shared.UI.Components.FishingGame.FishingMiniGame)

local story = {
    react = React,
    reactRoblox = ReactRoblox,
    story = function(props)
        local container = React.createElement("Frame", {
            Name = "Container",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.7, 0.7),
        }, {
            component = FishingMiniGame.component(props),
        })

        return container
    end,
}

return story
