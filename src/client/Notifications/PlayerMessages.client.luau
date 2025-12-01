local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = require(ReplicatedStorage.Shared.Events.Events)
local PlayerNotification = require(ReplicatedStorage.Shared.UI.Components.HUD.PlayerNotification)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = playerGui:WaitForChild("PlayerMessages")
local notificationContainer = screenGui:WaitForChild("MessageContainer")

if notificationContainer then
	local playerNotificationEvent = Events.GetRemote(Events.RemoteNames.PlayerNotification)
	if playerNotificationEvent then
		playerNotificationEvent.OnClientEvent:Connect(function(data: PlayerNotification.Props)
			if data then
				local notification = PlayerNotification.Create(data)
				if notification then
					notification.Parent = notificationContainer
					PlayerNotification.Animate(notification)
				end
			end
		end)
	end
end
