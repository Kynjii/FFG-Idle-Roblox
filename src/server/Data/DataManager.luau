local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = {}

-- Stores profiles from ProfileStore
DataManager.Profiles = {}

function DataManager.AddGold(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile.Data.Gold += amount
	player.leaderstats.Gold.Value = profile.Data.Gold -- created within DataInit, ignore warning
	ReplicatedStorage.UpdateGold:FireClient(player, profile.Data.Gold)
end

return DataManager
