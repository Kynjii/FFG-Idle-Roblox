-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerDataTemplate = require(ServerScriptService.Server.Data.PlayerDataTemplate)

-- ProfileStore
local ProfileStore = require(ServerScriptService.Server.Libs.ProfileStore)
local DataManager = require(ServerScriptService.Server.Data.DataManager)

local function GetStoreName()
	return RunService:IsStudio() and "Staging" or "Live"
end

-- Access Profile Store
local PlayerStore = ProfileStore.New(GetStoreName(), PlayerDataTemplate)

-- Add leaderstats and sync player data
local function Initialize(player: Player, profile: typeof(PlayerStore:StartSessionAsync()))
	-- Leaderstats
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local Gold = Instance.new("NumberValue", leaderstats)
	Gold.Name = "Gold"
	Gold.Value = profile.Data.Gold

	-- sync player data
	ReplicatedStorage.UpdateGold:FireClient(player, profile.Data.Gold)
end

-- Creates and stores a profile
local function PlayerAdded(player: Player)
	-- Start new profile session
	local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	-- Sanity check to ensure profile exist

	if profile ~= nil then
		profile:AddUserId(player.UserId) -- GDPR compliance
		profile:Reconcile() -- Fill in missing data variables from template

		-- Handles session locking
		profile.OnSessionEnd:Connect(function()
			DataManager.Profiles[player] = nil
			player:Kick("Data error occured, please rejoin.")
		end)

		-- Save profile for later use
		if player.Parent == Players then
			DataManager.Profiles[player] = profile
			Initialize(player, profile)
		else
			profile:EndSession()
		end
	else
		-- Server shuts down while player is joining
		player:Kick("Data error occured, please rejoin.")
	end
end

-- early joiners (studio users)
for _, player in Players:GetPlayers() do
	task.spawn(PlayerAdded, player)
end

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(function(player)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile:EndSession()
	DataManager.Profiles[player] = nil
end)
