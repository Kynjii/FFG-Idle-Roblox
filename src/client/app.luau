local RunService = game:GetService("RunService")
_G.__DEV__ = RunService:IsStudio()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement

local HUD = require(StarterPlayer.StarterPlayerScripts.Client.UI.HUD)
local FishingSkill = require(StarterPlayer.StarterPlayerScripts.Client.UI.FishingSkill)
local FishingGame = require(StarterPlayer.StarterPlayerScripts.Client.UI.FishingGame)

local function App()
    return e("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
    }, {
        HUD = HUD.manager(),
        FishingSkill = FishingSkill.manager(),
        FishingGame = FishingGame.manager(),
    })
end

return App
