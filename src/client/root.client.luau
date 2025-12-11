local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local app = require(script.Parent.app)
local React = require(ReplicatedStorage.Packages.React)
local RR = require(ReplicatedStorage.Packages["React-roblox"])
local Events = require(ReplicatedStorage.Shared.Events.Events)

local e = React.createElement

local handle = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui)
handle.Name = "Root"
handle.IgnoreGuiInset = true
handle.ResetOnSpawn = false
handle.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
handle.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local root = RR.createRoot(handle)

local playerAssigned = Events.GetRemote(Events.RemoteNames.PlayerAssigned)
if playerAssigned then
    playerAssigned.OnClientEvent:Connect(function()
        root:render(e(app))
    end)
end
