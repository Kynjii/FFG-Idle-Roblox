local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Replica = require(ReplicatedStorage.Shared.ReplicaClient)
local DeepWait = require(ReplicatedStorage.Shared.Utils.DeepWait)
local FormatNumber = require(ReplicatedStorage.Shared.Utils.FormatNumber)
Replica.RequestData()

local player = Players.LocalPlayer
local hud = DeepWait(player, "PlayerGui", "HUD")

local labels = {
	Gold = DeepWait(hud, "Currencies", "Gold", "TextLabel"),
}

local current = {
	Gold = 0,
}

local function setCurrency(name: string, v: number)
	local label = labels[name]
	if not label then return end
	current[name] = v

	label.Font = FFGEnum.FONT
	label.Text = FormatNumber(v)
end

Replica.OnNew("PlayerState", function(replica)
	local data = replica.Data

	-- Initial snapshot
	if data.Currencies then
		for k, n in pairs(data.Currencies) do
			if typeof(n) == "number" then setCurrency(k, n) end
		end
	end

	-- Subscribe to currency patches
	local subscribed: { [string]: boolean } = {}

	local function subscribeCurrency(key: string)
		if subscribed[key] then return end
		subscribed[key] = true
		replica:OnSet({ "Currencies", key }, function(v)
			if typeof(v) == "number" then setCurrency(key, v) end
		end)
	end

	-- Subscribe for all labels in the HUD
	for key in pairs(labels) do
		subscribeCurrency(key)
	end
	-- Also subscribe for any currencies that arrived in the initial snapshot
	if data.Currencies then
		for key in pairs(data.Currencies) do
			subscribeCurrency(key)
		end
	end
end)
