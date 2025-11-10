local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = require(ReplicatedStorage.Shared.Events.Events)
local PlayerNotification = require(ReplicatedStorage.Shared.UI.Components.HUD.PlayerNotification)
local Notification = {}

function Notification.SendAlert(player: Player, msg: string)
	local data: PlayerNotification.Props = {
		Text = msg,
		Type = "Red",
	}

	Events.FireEvent(Events.RemoteNames.PlayerNotification, player, data)
end

function Notification.SendSuccess(player: Player, msg: string)
	local data: PlayerNotification.Props = {
		Text = msg,
		Type = "Green",
	}

	Events.FireEvent(Events.RemoteNames.PlayerNotification, player, data)
end

return Notification
