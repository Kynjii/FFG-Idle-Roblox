local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Notification = require(ServerScriptService.Server.Classes.Modules.Notification)
local Tutorial = require(ServerScriptService.Server.Game.Tutorial.Tutorial)
local DataService = require(ServerScriptService.Server.Services.DataService)
local Trove = require(ReplicatedStorage.Packages.Trove)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local HelperType = require(ReplicatedStorage.Shared.Types.Classes.HelperType)

-- //SECTION - Tagged Entities within Workspace
local taggedShops = CollectionService:GetTagged("FishingRodShop")
-- //!SECTION

local FishingRodShopManager = {}
FishingRodShopManager.__index = FishingRodShopManager

type FishingRodShopManager = typeof(setmetatable({}, FishingRodShopManager))

type ShopState = {
	Inventory: { [string]: any },
	Entity: string,
	Id: string,
	Owner: number,
	CompletedTutorial: boolean,
	PeriodEnd: number,
}

function FishingRodShopManager.New(shopState: ShopState, player: Player, teamId: number): FishingRodShopManager
	local self = setmetatable({} :: FishingRodShopManager, FishingRodShopManager)

	self.Entity = FFGEnum.CLASS.ENTITY_NAME.FishingRodShop
	self.Id = shopState and shopState.Id or HttpService:GenerateGUID(false)
	self.Player = player
	self.Owner = self.Owner or player.UserId
	self.TeamId = teamId
	self.ShopModel = self:FindShopModel(teamId)

	self.Inventory = shopState and shopState.Inventory or nil

	self.CompletedTutorial = shopState and shopState.CompletedTutorial or DataService.CompletedTutorial(self.Player)

	self._cleaner = Trove.new()

	self:AttachEventListeners()

	return self
end

function FishingRodShopManager.FindShopModel(self: FishingRodShopManager, teamId: number): Model?
	for _, taggedShop: Instance in ipairs(taggedShops) do
		local taggedShopTeamId = taggedShop:GetAttribute(FFGEnum.ATTRIBUTES.TeamId)
		if taggedShopTeamId == teamId then return taggedShop end
	end

	return nil
end

function FishingRodShopManager.PurchaseRod(self: FishingRodShopManager, rodId: string): ()
	local rodInShop = TableUtil.Find(self.Inventory, function(rod)
		return rod.Id == rodId
	end) :: HelperType.HelperData

	if not rodInShop or rodInShop.IsPurchased then return end

	if not DataService.CanAfford(self.Player, rodInShop.CurrencyType, rodInShop.BaseCost or 0) then
		Notification.SendAlert(self.Player, "Not enough gold.")
		return
	end
	if not self.CompletedTutorial then
		Tutorial.Update(self.Player, self.TeamId)
		self.CompletedTutorial = DataService.CompletedTutorial(self.Player)
	end

	-- local helperClass = Helper.New(rodInShop, self.Player, self.TeamId)
	-- helperClass:Purchase()
	-- helperClass:Destroy()

	DataService.Spend(self.Player, rodInShop.CurrencyType, rodInShop.BaseCost)

	self.Inventory[rodId] = nil

	Events.FireEvent(Events.RemoteNames.UpdateFishingRodShopUI, self.Player, rodId)
	-- //TODO -
	-- Events.FireBindableEvent(Events.BindableNames.PurchasedHelper, { Player = self.Player })

	self:Save()
end

-- //SECTION - UI Setup
function FishingRodShopManager.Initialize(self: FishingRodShopManager): ()
	if self.ShopModel then self:SetupProximityPrompt(self.ShopModel) end
end

function FishingRodShopManager.SetupProximityPrompt(self: FishingRodShopManager, model: Model): ()
	local proximityPrompt: ProximityPrompt = self._cleaner and self._cleaner:Add(Instance.new("ProximityPrompt"))
	proximityPrompt.Parent = model

	proximityPrompt.HoldDuration = 0
	proximityPrompt.MaxActivationDistance = self.Entity ~= FFGEnum.CLASS.ENTITY_NAME.Shop and 5 or 15
	proximityPrompt.MaxIndicatorDistance = proximityPrompt.MaxActivationDistance * 5
	proximityPrompt.ObjectText = "Open"
	proximityPrompt.ActionText = `{self.Entity}`

	self._cleaner:Add(proximityPrompt.Triggered:Connect(function(player)
		if player.UserId ~= self.Owner then return end

		local shopInventory = self.Inventory or {}
		Events.FireEvent(Events.RemoteNames.OpenHelperShop, self.Player, shopInventory)
	end))

	return proximityPrompt
end
-- //!SECTION

-- //SECTION - Event Listeners
function FishingRodShopManager.AttachEventListeners(self: FishingRodShopManager): ()
	-- //TODO - events
	local itemPurchased = Events.GetRemote(Events.RemoteNames.HelperPurchased)
	if itemPurchased then
		self._cleaner:Add(itemPurchased.OnServerEvent:Connect(function(player: Player, helperId: string)
			if self.Player ~= player or self.Owner ~= player.UserId then return end

			local canProceed = Tutorial.CheckTutorialState(player, self)
			if not canProceed then
				Notification.SendAlert(player, "Follow the Tutorial to unlock this!")
				return
			end

			self:PurchaseRod(helperId)
		end))
	end

	local updateInfoPanel = Events.GetRemote(Events.RemoteNames.UpdateInfoPanel)
	if updateInfoPanel then
		updateInfoPanel.OnServerEvent:Connect(function(player: Player, data: { Item: HelperType.HelperData, isFishDex: boolean? })
			if self.Player ~= player or self.Owner ~= player.UserId then return end
			if data.isFishDex then return end
			if not data.Item and data.Item.Entity == FFGEnum.CLASS.ENTITY_NAME.Helper then return end

			local helperInShop = TableUtil.Find(self.Inventory, function(helper: HelperType.HelperData)
				return helper.Id == data.Item.Id
			end) :: HelperType.HelperData

			if not helperInShop then return end
			if helperInShop then Events.FireEvent(Events.RemoteNames.UpdateInfoPanel, player, { Item = helperInShop }) end
		end)
	end
end
-- //!SECTION

-- //SECTION - Saving and Loading
function FishingRodShopManager.Serialize(self: FishingRodShopManager): { [string]: any }
	return {
		Entity = self.Entity,
		Id = self.Id,
		Owner = self.Owner,
		Inventory = self.Inventory,
		CompletedTutorial = self.CompletedTutorial,
	}
end

function FishingRodShopManager.Save(self: FishingRodShopManager)
	-- //TODO -
	DataService.SaveFishingRodShop(self.Player, self:Serialize())
end

-- //!SECTION

-- //SECTION - Cleanup
function FishingRodShopManager.Destroy(self: FishingRodShopManager): ()
	pcall(function()
		self:Save()
	end)

	if self._cleaner then
		self._cleaner:Clean()
		self._cleaner = nil
	end

	self.Player = nil
	self.Owner = nil
	self.TeamId = nil
	self.ShopModel = nil
end
-- //!SECTION

return FishingRodShopManager
