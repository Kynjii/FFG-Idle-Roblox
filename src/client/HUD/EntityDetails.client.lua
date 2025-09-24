local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoatType = require(ReplicatedStorage.Shared.Types.Classes.BoatType)
local BuildingType = require(ReplicatedStorage.Shared.Types.Classes.BuildingType)
local PortStorageType = require(ReplicatedStorage.Shared.Types.Classes.PortStorageType)
local TenderType = require(ReplicatedStorage.Shared.Types.Classes.TenderType)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local CalculateProgress = require(ReplicatedStorage.Shared.Utils.CalculateProgress)
local DeepWait = require(ReplicatedStorage.Shared.Utils.DeepWait)
local FormatNumber = require(ReplicatedStorage.Shared.Utils.FormatNumber)
local player = Players.LocalPlayer
local entityDetailsUI: Frame = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer")

local details = {}
-- Defaults
details.NameLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "Name") :: TextLabel
details.LevelLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "Level") :: TextLabel
details.Description = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "Description") :: TextLabel

-- Boat
details.CurrentFPSLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "CurrentFPS") :: TextLabel
details.NextFPSLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "NextFPS") :: TextLabel

-- Tender
details.CurrentTravelTimeLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "CurrentTT") :: TextLabel
details.CurrentLoadTimeLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "CurrentLT") :: TextLabel

-- Non-Building
details.StorageProgress = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "StorageBar", "StorageProgress") :: Frame
details.CurrentMaxStorageLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "CurrentMaxStorage") :: TextLabel
details.NextMaxStorageLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "NextMaxStorage") :: TextLabel

-- Building
details.BuffLabel = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "Buff") :: TextLabel

-- Buttons
details.upgradeButton = DeepWait(player.PlayerGui, "EntityDetails", "DetailsContainer", "UpgradeButton") :: ImageButton

-- Open/Close EntityDetails
-- Default close
entityDetailsUI.Visible = false

local entityData = nil

local entityDetails = Events.GetRemote(Events.RemoteNames.OpenEntityDetails)
if entityDetails then entityDetails.OnClientEvent:Connect(function(data)
	if data then
		entityDetailsUI.Visible = true
		entityData = data
		populateDetailsUI()
		handleClosingEntityDetailsUI()
	end
end) end

function handleClosingEntityDetailsUI()
	local character = player.Character.PrimaryPart
	local originalPosition = character.CFrame.Position

	while true do
		local distance = player:DistanceFromCharacter(originalPosition)
		if distance >= 8 then
			entityDetailsUI.Visible = false
			break
		end

		task.wait(0.5)
	end
end

-- Populate the Details Page
function populateDetailsUI()
	local class: BoatType.BoatProps | TenderType.TenderProps | PortStorageType.StorageProps | BuildingType.BuildingProps = entityData

	-- Hide all elements by defaults except for progress bars
	for k, element in pairs(details) do
		if k ~= "ProgressBar" then element.Visible = false end
	end

	-- Name
	local qualityInfo = FFGEnum.QUALITY[class.UpgradeStage]
	local color = qualityInfo.Color
	details.NameLabel.TextColor3 = color
	details.NameLabel.TextXAlignment = "Center"
	details.NameLabel.Text = class.Name
	details.NameLabel.Visible = true

	-- Level
	details.LevelLabel.Text = class.isPurchased and "Lvl: " .. class.Level or ""
	details.LevelLabel.Visible = true

	-- Description
	details.Description.Text = class.Description or ""
	details.Description.Visible = true

	-- Upgrade Button
	details.upgradeButton.TextLabel.Text = class.isPurchased and "Upgrade" or "Purchase"
	details.upgradeButton.Visible = true

	-- Boat
	if class.Entity == FFGEnum.CLASS.ENTITY_NAME.Boat then
		details.CurrentFPSLabel.Text = class.isPurchased and "FPS: " .. FormatNumber(class.CurrentFPS) or ""
		details.NextFPSLabel.Text = class.isPurchased and "Next Lvl FPS: " .. FormatNumber(class.NextFPS) or ""

		details.CurrentFPSLabel.Visible = true
		details.NextFPSLabel.Visible = true
	end

	-- Tender
	if class.Entity == FFGEnum.CLASS.ENTITY_NAME.Tender then
		details.CurrentTravelTimeLabel.Text = class.isPurchased and "Travel Time: " .. FormatNumber(class.CurrentTravelTime) .. " secs" or ""
		details.CurrentLoadTimeLabel.Text = class.isPurchased and "Load Time: " .. FormatNumber(class.LoadTime) .. " secs" or ""

		details.CurrentTravelTimeLabel.Visible = true
		details.CurrentLoadTimeLabel.Visible = true
	end

	-- Non-Building
	if class.Entity ~= FFGEnum.CLASS.ENTITY_NAME.Building then
		-- Progress Bar
		local storageProgress = CalculateProgress(class.FishInStorage, class.CurrentMaxStorage)
		details.StorageProgress.Size = UDim2.fromScale(1, storageProgress)
		details.StorageProgress.Visible = class.isPurchased and true or false

		-- STORAGE Stats
		details.CurrentMaxStorageLabel.Text = class.isPurchased and "Storage: " .. FormatNumber(class.CurrentMaxStorage) or ""
		details.NextMaxStorageLabel.Text = class.isPurchased and "Next Lvl Storage: " .. FormatNumber(class.NextLvlMaxStorage) or ""

		details.CurrentMaxStorageLabel.Visible = true
		details.NextMaxStorageLabel.Visible = true
	end

	-- Building
	if class.Entity == FFGEnum.CLASS.ENTITY_NAME.Building then
		if class.isPurchased and class.BuildingBuff then
			local isPlus = class.BuildingBuff.IsPlus
			if isPlus then
				details.BuffLabel.Text = "+" .. (FormatNumber(class.BuildingBuff.CurrentValue * 100)) .. "%" .. " " .. class.BuildingBuff.Label
			else
				details.BuffLabel.Text = "-" .. FormatNumber(class.BuildingBuff.CurrentValue * 100) .. "%" .. " " .. class.BuildingBuff.Label
			end

			details.BuffLabel.TextColor3 = Color3.fromHex("#55ff00")
			details.BuffLabel.Visible = true
		end
	end
end

-- Upgrade Button
if details.upgradeButton then details.upgradeButton.Activated:Connect(function()
	handleUpgradeClick()
end) end

function handleUpgradeClick()
	-- Send event with class to say it has been upgraded
	-- write another listener for the server and client that handle upgrading
	-- client sends update event
	-- Server listens (teammanager i think) and upgrades correct class
	-- Server sends the latest class data for the UI to update

	-- Note: RemoteFunction might be best for this
end
