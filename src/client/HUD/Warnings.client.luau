local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local TextPopUp = require(StarterPlayer.StarterPlayerScripts.Client.HUD.Utils.TextPopUp)
local Events = require(ReplicatedStorage.Shared.Events.Events)

local player = Players.LocalPlayer

local Warning = Events.GetRemote(Events.RemoteNames.WarningMsg)
if Warning then Warning.OnClientEvent:Connect(function(msg)
	if msg then TextPopUp.ShowRedTextPopUp(player, msg) end
end) end
