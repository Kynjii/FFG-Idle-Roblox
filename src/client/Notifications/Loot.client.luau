local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = require(ReplicatedStorage.Shared.Events.Events)
local LootNotification = require(ReplicatedStorage.Shared.UI.Components.HUD.LootNotification)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = playerGui:WaitForChild("LootNotifications")
local notificationContainer = screenGui:WaitForChild("LootNotificationContainer")

local elementCount = 0

if notificationContainer then
	local lootNotificationEvent = Events.GetRemote(Events.RemoteNames.LootNotification)
	if lootNotificationEvent then
		lootNotificationEvent.OnClientEvent:Connect(function(encodedData: LootNotification.Props)
			local data = HttpService:JSONDecode(encodedData)
			if data then
				local notificationFrame, notification = LootNotification.Create({ ItemType = data.ItemType or nil, Text = data.Text or nil })
				if notification and notificationFrame then
					elementCount += 1
					notificationFrame.LayoutOrder = elementCount
					notificationFrame.Parent = notificationContainer
					LootNotification.Animate(notification)

					local sound = workspace.UISounds.FishDexAlert
					if sound then sound:Play() end

					task.spawn(function()
						task.delay(3.4, function()
							elementCount -= 1
						end)
					end)
				end
			end
		end)
	end
end
