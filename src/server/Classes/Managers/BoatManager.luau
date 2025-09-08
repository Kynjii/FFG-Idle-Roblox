local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")
local Boat: Boat = require(ServerScriptService.Server.Classes.Boat)
local Tender: Tender = require(ServerScriptService.Server.Classes.Tender)
local BoatType = require(ServerScriptService.Server.Classes.Types.BoatType)
local TenderType = require(ServerScriptService.Server.Classes.Types.TenderType)
local BoatManagerType = require(ServerScriptService.Server.Classes.Types.BoatManagerType)

local taggedBoats = CollectionService:GetTagged("Boat")
local taggedTenders = CollectionService:GetTagged("Tender")

type Boat = BoatType.Boat
type Tender = TenderType.Tender
type BoatManager = BoatManagerType.BoatManagerInstance

local BoatManager = {} :: BoatManager
BoatManager.__index = BoatManager

function BoatManager.New(boatsArr: BoatType.BoatProps, TendersArr: TenderType.TenderProps, tier: number, player: Player)
	local self = setmetatable({}, BoatManager)

	self.Tier = tier
	self.BoatModel = self:FindBoatModel(player, tier) :: Model
	if not self.BoatModel then return end
	self.LaneBoat = Boat.New(boatsArr[tier], player, self.BoatModel)

	self.TenderModel = self:FindTenderModel(player, tier)
	self.LaneTender = Tender.New(TendersArr[tier], player, self.TenderModel)

	return self
end

function BoatManager:FindBoatModel(player, tier)
	for _, taggedBoat in ipairs(taggedBoats) do
		local taggedBoatTier = taggedBoat:GetAttribute("Tier")
		if taggedBoatTier == tier then return taggedBoat end
	end

	return nil
end

function BoatManager:FindTenderModel(player, tier)
	for _, taggedTender in ipairs(taggedTenders) do
		local taggedTenderTier = taggedTender:GetAttribute("Tier")
		if taggedTenderTier == tier then return taggedTender end
	end

	return nil
end

function BoatManager:Initialize()
	self.LaneBoat:Initialize()
	self.LaneTender:Initialize()
end

return BoatManager
