local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = require(ReplicatedStorage.Shared.Events.Events)
local BoatType = require(ReplicatedStorage.Shared.Types.Classes.BoatType)
local BuildingType = require(ReplicatedStorage.Shared.Types.Classes.BuildingType)
local PortStorageType = require(ReplicatedStorage.Shared.Types.Classes.PortStorageType)
local TenderType = require(ReplicatedStorage.Shared.Types.Classes.TenderType)

local PP = {}

function PP.CreatePP(proximityPrompt: ProximityPrompt, class: BoatType.BoatInstance | TenderType.TenderInstance | PortStorageType.StorageInstance | BuildingType.BuildingInstance)
	proximityPrompt.HoldDuration = 0
	proximityPrompt.MaxActivationDistance = 5
	proximityPrompt.ObjectText = "Open"
	proximityPrompt.ActionText = class.Entity .. " Details"

	class._cleaner:add(proximityPrompt.Triggered:Connect(function(player)
		if player.UserId ~= class.Owner then return end
		if class.Level == class.MaxLevel then return end

		Events.FireEvent(Events.RemoteNames.OpenEntityDetails, class.Player, class)

		-- if not DataService.CanAfford(player, FFGEnum.CURRENCY_TYPES.Gold, not class.isPurchased and class.BaseCost or class.UpgradeCost) then
		-- 	Events.FireEvent(Events.RemoteNames.WarningMsg, class.Player, "Not enough gold!")
		-- 	class:UpdateProximityPromptUI(proximityPrompt)
		-- 	return
		-- end

		-- DataService.Spend(player, FFGEnum.CURRENCY_TYPES.Gold, not class.isPurchased and class.BaseCost or class.UpgradeCost)

		-- if class.isPurchased then
		-- 	class:Upgrade()
		-- else
		-- 	class:Purchase()
		-- 	class:Show()
		-- 	class:CanCollide()

		-- 	if class.Entity == FFGEnum.CLASS.ENTITY_NAME.Boat then class:StartFishing() end
		-- end

		-- -- Update UIs
		-- class:UpdateProximityPromptUI(proximityPrompt)
		-- class:UpdatePurchaseBoardUI()

		-- class:Save()
	end))

	return proximityPrompt
end

return PP
