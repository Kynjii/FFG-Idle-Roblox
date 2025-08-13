local ServerScriptService = game:GetService("ServerScriptService")
local PlayerDataTemplate = require(script.Parent.PlayerDataTemplate)
local Replica = require(ServerScriptService.Server.ReplicaServer)
local PlayerStateToken = Replica.Token("PlayerState")

local DataManager = {}
DataManager.Profiles = {}
DataManager.Replicas = {}

function DataManager.AttachReplica(player: Player, profile)
	local replica = Replica.New({
		Token = PlayerStateToken,
		Data = {
			Currencies = {
				Gold = profile.Data.Gold or PlayerDataTemplate.Gold,
			},
			-- Add other HUD-safe pieces, e.g. Boat, Storage, etc.
			-- Boat = profile.Data.Boat or { Level = 1, Storage = 100 },
		},
	})
	replica:Subscribe(player) -- replicate only to this player
	DataManager.Replicas[player] = replica
	return replica
end

function DataManager.DetachReplica(player: Player)
	local replica = DataManager.Replicas[player]
	if replica then
		replica:Destroy()
		DataManager.Replicas[player] = nil
	end
end

local function setLeaderstat(player: Player, name: string, value: number)
	local stats = player:FindFirstChild("leaderstats")
	if not stats then
		return
	end
	local v = stats:FindFirstChild(name)
	if v and v:IsA("NumberValue") then
		v.Value = value
	end
end

function DataManager.Earn(player: Player, currencyType: string, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end
	if typeof(amount) ~= "number" or amount <= 0 then
		return
	end
	if typeof(currencyType) ~= "string" then
		return
	end

	local current = tonumber(profile.Data[currencyType]) or 0
	local newValue = current + amount
	profile.Data[currencyType] = newValue

	-- //TODO - Remove this and handle for when we have more than 1 currency/stat
	setLeaderstat(player, currencyType, newValue)

	local replica = DataManager.Replicas[player]
	if replica then
		replica:Set({ "Currencies", currencyType }, newValue)
	end
end

function DataManager.CanAfford(player: Player, currencyType: string, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end
	return (tonumber(profile.Data[currencyType]) or 0) >= amount
end

function DataManager.Spend(player: Player, currencyType: string, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end
	if typeof(amount) ~= "number" or amount <= 0 then
		return
	end
	if typeof(currencyType) ~= "string" then
		return
	end

	local current = tonumber(profile.Data[currencyType]) or 0
	if current < amount then
		return
	end

	local newValue = current - amount
	profile.Data[currencyType] = newValue

	-- //TODO - Remove this and handle for when we have more than 1 currency/stat
	setLeaderstat(player, currencyType, newValue)

	local replica = DataManager.Replicas[player]
	if replica then
		replica:Set({ "Currencies", currencyType }, newValue)
	end
end

return DataManager
