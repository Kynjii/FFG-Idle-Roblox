--[[
	app.luau
	
	Root React component for the client UI.
	Composes all major UI systems including HUD, fishing minigame,
	and skill displays into a single component tree.
	
	This component is rendered by root.client.luau after the player
	has been assigned to a team.
	
	@component App
	@client
]]

local RunService = game:GetService("RunService")
_G.__DEV__ = RunService:IsStudio() -- Enable dev mode in Studio

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement

-- UI system managers
local HUD = require(StarterPlayer.StarterPlayerScripts.Client.UI.HUD)
local FishingSkill = require(StarterPlayer.StarterPlayerScripts.Client.UI.FishingSkill)
local FishingGame = require(StarterPlayer.StarterPlayerScripts.Client.UI.FishingGame)

--- Root application component.
--- Creates a full-screen transparent container and renders all UI systems.
--- @return React.Element
local function App()
    return e("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
    }, {
        -- Heads-Up Display (currency, buttons, notifications)
        HUD = HUD.manager(),
        -- Fishing skill progress and level display
        FishingSkill = FishingSkill.manager(),
        -- Active fishing minigame UI
        FishingGame = FishingGame.manager(),
    })
end

return App
