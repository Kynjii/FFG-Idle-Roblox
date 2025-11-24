local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Fish = require(ServerScriptService.Server.Classes.Fish)
local DataService = require(ServerScriptService.Server.Services.DataService)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Events = require(ReplicatedStorage.Shared.Events.Events)

local MarketManager = {}
MarketManager.__index = MarketManager

type MarketManager = typeof(setmetatable({}, MarketManager))

function MarketManager.New(player: Player, teamId: number, currentRealm: number): MarketManager
	local self = setmetatable({} :: MarketManager, MarketManager)

	self.Player = player
	self.Owner = self.Owner or player.UserId
	self.TeamId = teamId
	self.RealmId = currentRealm

	self._cleaner = Trove.new()

	self:AttachAttListeners()

	return self
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
