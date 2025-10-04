local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local BoatType = require(ReplicatedStorage.Shared.Types.Classes.BoatType)
local BuildingType = require(ReplicatedStorage.Shared.Types.Classes.BuildingType)
local PortStorageType = require(ReplicatedStorage.Shared.Types.Classes.PortStorageType)
local TenderType = require(ReplicatedStorage.Shared.Types.Classes.TenderType)
local DataService = require(ServerScriptService.Server.Services.DataService)

local EventListeners = {}

type Boat = BoatType.BoatInstance
type Tender = TenderType.TenderInstance
type PortStorage = PortStorageType.StorageInstance
type Building = BuildingType.BuildingInstance

function EventListeners.Attach(class: Boat | Tender | PortStorage | Building)
	local typedClass
	if class.Entity == FFGEnum.CLASS.ENTITY_NAME.Boat then
		typedClass = class :: Boat
	elseif class.Entity == FFGEnum.CLASS.ENTITY_NAME.Tender then
		typedClass = class :: Tender
	elseif class.Entity == FFGEnum.CLASS.ENTITY_NAME.PortStorage then
		typedClass = class :: PortStorage
	elseif class.Entity == FFGEnum.CLASS.ENTITY_NAME.Building then
		typedClass = class :: Building
	else
		error("Invalid entity passed to CreatePB")
	end

	local function handleStateUpdate(player)
		if not DataService.CanAfford(player, FFGEnum.CURRENCY_TYPES.Gold, not typedClass.isPurchased and typedClass.BaseCost or typedClass.UpgradeCost) then return end

		DataService.Spend(player, FFGEnum.CURRENCY_TYPES.Gold, not typedClass.isPurchased and typedClass.BaseCost or typedClass.UpgradeCost)

		if typedClass.isPurchased then
			typedClass:Upgrade()
		else
			typedClass:Purchase()
			typedClass:Show()
			typedClass:CanCollide()

			if typedClass.Entity == FFGEnum.CLASS.ENTITY_NAME.Boat then typedClass:StartFishing() end
		end

		-- Update UIs
		typedClass:UpdatePurchaseBoardUI()

		typedClass:Save()
	end

	-- Purchased Event
	local purchasedEvent = Events.GetRemote(Events.RemoteNames.EntityPurchased)
	if purchasedEvent then purchasedEvent.OnServerEvent:Connect(function(player, entityId)
		if typedClass.Player ~= player or typedClass.Owner ~= player.UserId then return end
		if typedClass.Id ~= entityId then return end

		handleStateUpdate(player)
	end) end

	-- Upgraded Event
	local upgradedEvent = Events.GetRemote(Events.RemoteNames.EntityUpgraded)
	if upgradedEvent then upgradedEvent.OnServerEvent:Connect(function(player, entityId)
		if typedClass.Player ~= player or typedClass.Owner ~= player.UserId then return end
		if typedClass.Id ~= entityId then return end

		handleStateUpdate(player)
	end) end
end

return EventListeners
