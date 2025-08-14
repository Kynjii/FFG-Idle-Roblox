local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataManager = require(ServerScriptService.Server.Data.DataManager)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local FFGDefaults = require(ServerScriptService.Server.FFGDefaults)
local FFGHelpers = require(ReplicatedStorage.Shared.Utils.FFGHelpers)

local taggedBoats = CollectionService:GetTagged("Boat")

local BOAT = {}

BOAT.SetupProximityPrompt = function(boat: Model, primaryPart: Part, purchaseBoard: Part)
	local proximityPrompt = Instance.new("ProximityPrompt", purchaseBoard)
	proximityPrompt.HoldDuration = 1
	proximityPrompt.ObjectText = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) and "Upgrade Boat" or "Purchase"
	proximityPrompt.ActionText = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) and "Level: " .. tostring(primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level) + 1) or "Boat"

	proximityPrompt.TriggerEnded:Connect(function(player)
		-- //TODO - replace amount with the upgrade cost
		if not DataManager.CanAfford(player, FFGEnum.CURRENCY_TYPES.Gold, 500) then
			return
		end

		if primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) then
			local newValue = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level) + 1
			primaryPart:SetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level, newValue)

			-- //TODO think about replica too
			DataManager.UpdateBoatState(player, FFGEnum.ATTRIBUTES.BOAT.Level, newValue, player.UserId)
		else
			primaryPart:SetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased, true)
			primaryPart:SetAttribute(FFGEnum.ATTRIBUTES.BOAT.isActive, true)

			proximityPrompt.ObjectText = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) and "Upgrade" or "Unlock"
			proximityPrompt.ActionText = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) and "Level: " .. tostring(primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level) + 1) or "Boat"

			local boatParts = boat:GetChildren()
			for _, part in pairs(boatParts) do
				if part.Transparency and part.Transparency == 1 then
					part.Transparency = 0
				end
			end
		end
	end)

	return proximityPrompt
end

BOAT.UpdateProximityPromptUI = function(proximityPrompt: ProximityPrompt, primaryPart: Part)
	if proximityPrompt then
		proximityPrompt.ActionText = "Level: " .. tostring(primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level) + 1)
	end
end

BOAT.SetupUpgradeStore = function(boat: Model, primaryPart: Part)
	local purchaseBoard = boat:WaitForChild("Purchase_Board")
	local pbDetails = {}
	pbDetails.NameLabel = FFGHelpers.deepWait(purchaseBoard, "SurfaceGui", "Main", "Header", "Name", "TextLabel")
	pbDetails.LevelLabel = FFGHelpers.deepWait(purchaseBoard, "SurfaceGui", "Main", "Header", "Level", "TextLabel")

	if pbDetails then
		local upgradeStage = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.UpgradeStage)
		local level = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level)
		local qualityInfo = FFGEnum.QUALITY[upgradeStage]
		local color = qualityInfo.color
		pbDetails.NameLabel.TextColor3 = color
		pbDetails.NameLabel.Text = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) and FFGEnum.BOAT.NAME[upgradeStage] or FFGEnum.ATTRIBUTES.BOAT.Name
		pbDetails.LevelLabel.Text = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.isPurchased) and "Level: " .. level or "Purchase Boat"
	end

	return purchaseBoard
end

BOAT.UpdateBoardUI = function(primaryPart: Part, purchaseBoard: Part, attributeName)
	if not attributeName or not purchaseBoard then
		FFGHelpers.PrintLog("No attributeName or purchaseBoard found")
		return
	end

	local pbDetails = {}
	pbDetails.NameLabel = FFGHelpers.deepWait(purchaseBoard, "SurfaceGui", "Main", "Header", "Name", "TextLabel")
	pbDetails.LevelLabel = FFGHelpers.deepWait(purchaseBoard, "SurfaceGui", "Main", "Header", "Level", "TextLabel")

	if attributeName == FFGEnum.ATTRIBUTES.BOAT.Level then
		local level = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.Level)
		pbDetails.LevelLabel.Text = "Level: " .. level

		local currentUpgradeStage = primaryPart:GetAttribute(FFGEnum.ATTRIBUTES.BOAT.UpgradeStage)

		for i, threshold in ipairs(FFGEnum.QUALITY_PROMOTION_LEVELS) do
			if level == threshold + 1 then
				FFGHelpers.PrintLog("Level matches UpgradeStage + 1, updating")
				primaryPart:SetAttribute(FFGEnum.ATTRIBUTES.BOAT.UpgradeStage, currentUpgradeStage + 1)
				break
			end
		end
	end
end

BOAT.SetupAttributeListeners = function(primaryPart: Part, purchaseBoard: Part, proximityPrompt: ProximityPrompt)
	if not primaryPart and not purchaseBoard then
		return
	end

	-- When the level is changed, update the board to reflect
	primaryPart:GetAttributeChangedSignal(FFGEnum.ATTRIBUTES.BOAT.Level):Connect(function()
		BOAT.UpdateBoardUI(primaryPart, purchaseBoard, FFGEnum.ATTRIBUTES.BOAT.Level)
	end)

	-- When the level is changed, update the prox prompt labels
	if proximityPrompt then
		primaryPart:GetAttributeChangedSignal(FFGEnum.ATTRIBUTES.BOAT.Level):Connect(function()
			BOAT.UpdateProximityPromptUI(proximityPrompt, primaryPart)
		end)
	end
end

BOAT.SetupBoat = function(boat: Model)
	local primaryPart = boat.PrimaryPart

	-- //TODO - get boat state or FFGDefaults.BOAT_STARTING_ATT
	local attributes = FFGDefaults.BOAT_STARTING_ATT

	-- apply attributes to boat Primary Part
	for key, value in pairs(attributes) do
		primaryPart:SetAttribute(key, value)
	end

	-- Setup the purchase board info and attribute listeners
	local purchaseBoard = BOAT.SetupUpgradeStore(boat, primaryPart)
	if purchaseBoard then
		local proximityPrompt = BOAT.SetupProximityPrompt(boat, primaryPart, purchaseBoard)
		BOAT.SetupAttributeListeners(primaryPart, purchaseBoard, proximityPrompt)
	end
end

for _, taggedBoat in ipairs(taggedBoats) do
	BOAT.SetupBoat(taggedBoat)
end

CollectionService:GetInstanceAddedSignal("Boat"):Connect(BOAT.SetupBoat)
