local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = require(ReplicatedStorage.Shared.Events.Events)
local DeepWait = require(ReplicatedStorage.Shared.Utils.DeepWait)

local player = Players.LocalPlayer

local entityDetails = Events.GetRemote(Events.RemoteNames.OpenEntityDetails)
if entityDetails then entityDetails.OnClientEvent:Connect(function(data)
	if data then
		local entityDetailsUI: Frame = DeepWait(player.PlayerGui.EntityDetails.DetailsContainer)
		entityDetailsUI.Visible = true
	end
end) end
