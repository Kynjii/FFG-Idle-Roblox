local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Helper = require(ServerScriptService.Server.Classes.Helper)
local Pathfinding = require(ServerScriptService.Server.Classes.Modules.Pathfinding)
local Jobs = require(ServerScriptService.Server.Modules.Jobs.Jobs)
local DataService = require(ServerScriptService.Server.Services.DataService)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local HelperType = require(ReplicatedStorage.Shared.Types.Classes.HelperType)

local JobManager = {}
JobManager.__index = JobManager

type JobManager = typeof(setmetatable({}, JobManager))

function JobManager.New(helperState, player: Player, teamId: number): JobManager
	local self = setmetatable({} :: JobManager, JobManager)

	self.Player = player
	self.Owner = self.Owner or player.UserId
	self.TeamId = teamId

	self.Helpers = {}

	self._cleaner = Trove.new()

	self:AttachEventListeners()

	for _, helper in pairs(helperState) do
		local helperClass = Helper.New(helper, player, teamId)
		self.Helpers[helperClass.Id] = helperClass

		if helperClass.CurrentAssignment ~= "" then helperClass:AssignJob(helperClass.CurrentAssignment, false) end
	end

	return self
end

function JobManager.AssignHelper(self: JobManager, helperId: number, jobId: number): ()
	if not helperId or not jobId then return end

	local helper = self.Helpers and self.Helpers[helperId] or nil
	if not helper then
		local inventory = DataService.GetPlayerInventory(self.Player)
		local savedHelperState = inventory[helperId]
		local newHelperClass = Helper.New(savedHelperState, self.Player, self.TeamId)
		self.Helpers[newHelperClass.Id] = newHelperClass
		helper = newHelperClass
	end

	if helper and helper.AssignJob then
		local assigned = helper:AssignJob(jobId, true)
		if assigned then self:StartJob(helper, jobId) end
	end
end

function JobManager.StartJob(self: JobManager, helper: HelperType.HelperInstance, jobId: number)
	print(helper.Model)
	if not helper or not helper.Model then return end

	local startPos: Vector3 = Jobs.Data[jobId].Location

	if startPos then helper.Model:MoveTo(startPos) end

	if helper.ResourceInStorage > 0 then
		-- begin unload
	else
		Pathfinding.GoGatherSpot(jobId, helper.Model, self.Player)
	end
end

-- //SECTION - Event Listeners
function JobManager.AttachEventListeners(self: JobManager): ()
	-- Remote events for assigning helper to a job
	local assignJobEvent = Events.GetRemote(Events.RemoteNames.AssignJob)
	if assignJobEvent then assignJobEvent.OnServerEvent:Connect(function(player: Player, helperId: string, jobId: number)
		if self.Player ~= player or self.Owner ~= player.UserId then return end
		if not helperId or not jobId then return end

		self:AssignHelper(helperId, jobId)
	end) end

	-- Remote Events for handling job cycle
	local helperAtGatheringLoc = Events.GetRemote(Events.RemoteNames.HelperAtGatheringLoc)
	if helperAtGatheringLoc then helperAtGatheringLoc.OnServerEvent:Connect(function()
		print("I'm Here!")
	end) end

	local helperAtUnloadingLoc = Events.GetRemote(Events.RemoteNames.HelperAtUnloadingLoc)
	if helperAtUnloadingLoc then helperAtUnloadingLoc.OnServerEvent:Connect(function(helperId, helperJobId)
		local helper = self.Helpers[helperId]
		print(helper)
		self:StartJob(helper, helperJobId)
	end) end

	local helperStuck = Events.GetRemote(Events.RemoteNames.HelperStuck)
	if helperStuck then
		helperStuck.OnServerEvent:Connect(function()
			-- helperStuck | send after ~30 seconds of it not reaching it's destination and reset
		end)
	end
end
-- //!SECTION

-- //SECTION - Cleanup
function JobManager.Destroy(self: JobManager): ()
	for _, helper in pairs(self.Helpers) do
		helper:Destroy()
	end

	if self._cleaner then
		self._cleaner:Clean()
		self._cleaner = nil
	end

	self.Save()

	self.Player = nil :: any
end
-- //!SECTION

return JobManager
