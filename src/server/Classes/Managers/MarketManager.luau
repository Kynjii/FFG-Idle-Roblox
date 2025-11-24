local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Trove = require(ReplicatedStorage.Packages.Trove)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)

local taggedMarkets = CollectionService:GetTagged("Market")

local MarketManager = {}
MarketManager.__index = MarketManager

type MarketManager = typeof(setmetatable({}, MarketManager))

function MarketManager.New(player: Player, teamId: number, currentRealm: number): MarketManager
	local self = setmetatable({} :: MarketManager, MarketManager)

	self.Entity = FFGEnum.CLASS.ENTITY_NAME.Market
	self.Player = player
	self.Owner = self.Owner or player.UserId
	self.TeamId = teamId
	self.RealmId = currentRealm
	self.MarketModel = self:FindModel(teamId)

	self._cleaner = Trove.new()

	self:Initialize()

	return self
end

function MarketManager.Initialize(self: MarketManager): ()
	if self.MarketModel then self:SetupProximityPrompt(self.MarketModel) end

	self:AttachAttListeners()
end

function MarketManager.FindModel(self: MarketManager, teamId: number): Model?
	for _, taggedMarket: Instance in ipairs(taggedMarkets) do
		local taggedMarketTeamId = taggedMarket:GetAttribute(FFGEnum.ATTRIBUTES.TeamId)
		if taggedMarketTeamId == teamId then return taggedMarket end
	end

	return nil
end

function MarketManager.SetupProximityPrompt(self: MarketManager, model: Model): ()
	local proximityPrompt: ProximityPrompt = self._cleaner and self._cleaner:Add(Instance.new("ProximityPrompt"))
	proximityPrompt.Parent = model

	proximityPrompt.HoldDuration = 0
	proximityPrompt.MaxActivationDistance = self.Entity ~= FFGEnum.CLASS.ENTITY_NAME.Market and 5 or 15
	proximityPrompt.MaxIndicatorDistance = proximityPrompt.MaxActivationDistance * 5
	proximityPrompt.ObjectText = "Open"
	proximityPrompt.ActionText = `{self.Entity}`

	self._cleaner:Add(proximityPrompt.Triggered:Connect(function(player)
		if player.UserId ~= self.Owner then return end

		Events.FireEvent(Events.RemoteNames.OpenMarketShop, self.Player)
	end))

	return proximityPrompt
end

function MarketManager.AttachAttListeners(self: MarketManager)
	--
end

-- //SECTION - Cleanup
function MarketManager.Destroy(self: MarketManager)
	if self._cleaner then
		self._cleaner:Clean()
		self._cleaner = nil
	end

	self.Player = nil
	self.Owner = nil
	self.TeamId = nil
	self.RealmId = nil
end
-- //!SECTION

return MarketManager
