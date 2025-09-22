local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Replica = require(ReplicatedStorage.Shared.ReplicaClient)
local DeepWait = require(ReplicatedStorage.Shared.Utils.DeepWait)
local FormatNumber = require(ReplicatedStorage.Shared.Utils.FormatNumber)
Replica.RequestData()

local player = Players.LocalPlayer
local hud = DeepWait(player, "PlayerGui", "HUD")

local current = {
	Gold = 0,
}

local currencyTemplate = DeepWait(hud, "Currencies", "Currency", "CurrencyContainer", "CurrencyTextLabelTemplate")
local realmBuffsTemplate = DeepWait(hud, "RealmBuffs", "Buffs", "BuffContainer", "BuffTextLabelTemplate")

local currencyLabels = {}

local function setCurrency(name: string, v: number)
	if not v then return end
	local currencyLabel: TextLabel

	if currencyLabels[name] then
		currencyLabel = currencyLabels[name]
	else
		currencyLabel = currencyTemplate:Clone() :: TextLabel
		currencyLabel.Name = name .. "_LabelClone"
		currencyLabel.Parent = currencyTemplate.Parent
		currencyLabel.Visible = true
		currencyLabels[name] = currencyLabel
	end

	current[name] = v or 0
	currencyLabel.Font = FFGEnum.FONT
	currencyLabel.Text = FormatNumber(v)
	currencyLabel.TextSize = currencyLabel.AbsoluteSize.Y / 2
end

local realmBuffLabels = {}

local function setRealmBuff(name: string, buff)
	if not buff.CurrentValue then return end
	local buffLabel: TextLabel

	if realmBuffLabels[name] then
		buffLabel = realmBuffLabels[name]
	else
		buffLabel = realmBuffsTemplate:Clone() :: TextLabel
		buffLabel.Name = name .. "_LabelClone"
		buffLabel.Parent = realmBuffsTemplate.Parent
		buffLabel.Visible = true
		realmBuffLabels[name] = buffLabel
	end

	current[name] = buff and buff.CurrentValue or ""
	buffLabel.Font = FFGEnum.FONT
	local value = buff.CurrentValue * 100
	buffLabel.Text = FormatNumber(value) .. "%" .. " " .. buff.Label
	buffLabel.TextSize = buffLabel.AbsoluteSize.Y / 2
end

Replica.OnNew("PlayerState", function(replica)
	local data = replica.Data

	-- Initial snapshot
	if data.Currencies then
		for k, n in pairs(data.Currencies) do
			if typeof(n) == "number" then setCurrency(k, n) end
		end
	end

	if data.RealmBuffs then
		for k, buff in pairs(data.RealmBuffs) do
			if buff.CurrentValue then setRealmBuff(k, buff) end
		end
	end

	-- Subscribe to patches
	local subscribed: { [string]: boolean } = {}

	local function subscribeCurrency(key: string)
		if subscribed[key] then return end
		subscribed[key] = true
		replica:OnSet({ "Currencies", key }, function(v)
			if typeof(v) == "number" then setCurrency(key, v) end
		end)
	end

	local function subscribeRealmBuffs(key: string)
		if subscribed[key] then return end
		subscribed[key] = true
		replica:OnSet({ "RealmBuffs", key }, function(v)
			setRealmBuff(key, v)
		end)
	end

	-- Subscribe realm buffs
	if data.RealmBuffs then
		for key in pairs(data.RealmBuffs) do
			subscribeRealmBuffs(key)
		end
	end

	-- Subscribe currencies
	if data.Currencies then
		for key in pairs(data.Currencies) do
			subscribeCurrency(key)
		end
	end
end)
