--[[
	root.client.luau
	
	Client entry point script that initializes the React UI system.
	Creates the root ScreenGui and mounts the main App component once
	the player has been assigned to a team by the server.
	
	This script runs in StarterPlayerScripts and waits for the
	PlayerAssigned remote event before rendering, ensuring the player
	has valid data before UI loads.
	
	@client
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local app = require(script.Parent.app)
local React = require(ReplicatedStorage.Packages.React)
local RR = require(ReplicatedStorage.Packages["React-roblox"])
local Events = require(ReplicatedStorage.Shared.Events.Events)

local e = React.createElement

-- Create the root ScreenGui that hosts all React UI
local handle = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui)
handle.Name = "Root"
handle.IgnoreGuiInset = true -- Ignore the top bar inset
handle.ResetOnSpawn = false -- Persist across respawns
handle.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
handle.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Create the React root for rendering
local root = RR.createRoot(handle)

-- Wait for server to assign the player to a team before rendering
-- This ensures player data is ready before UI attempts to display it
local playerAssigned = Events.GetRemote(Events.RemoteNames.PlayerAssigned)
if playerAssigned then
    playerAssigned.OnClientEvent:Connect(function()
        root:render(e(app))
    end)
end
