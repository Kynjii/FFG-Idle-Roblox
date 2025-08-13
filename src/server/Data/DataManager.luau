local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataManager = {}
DataManager.Profiles = {}

function DataManager.Earn(player: Player, currencyType: string, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile.Data[currencyType] += amount
	player.leaderstats[currencyType].Value = profile.Data[currencyType]
	ReplicatedStorage["Update" .. currencyType]:FireClient(player, profile.Data[currencyType])
end

function DataManager.CanAfford(player: Player, currencyType: string, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end
	return profile.Data[currencyType] >= amount
end

function DataManager.Spend(player: Player, currencyType: string, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile.Data[currencyType] -= amount
	player.leaderstats[currencyType].Value = profile.Data[currencyType]
	ReplicatedStorage["Update" .. currencyType]:FireClient(player, profile.Data[currencyType])
end

return DataManager
