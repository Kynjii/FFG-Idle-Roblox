local PFS = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local Jobs = require(ServerScriptService.Server.Modules.Jobs.Jobs)

local PathFinding = {}

function PathFinding.GetRoute(jobId: number)
	return Jobs.Data[jobId].Route
end

function PathFinding.GoGatherSpot(jobId: number, npcModel: Model, player: Player)
	local npc = npcModel
	local humanoid: Humanoid = npc:WaitForChild("Humanoid")

	local route = PathFinding.GetRoute(jobId)
	local reversed = TableUtil.Reverse(route)
	if reversed then
		local hasReachedGoal = false

		for i, pathPart in ipairs(reversed) do
			if i == 1 then continue end
			local path = PFS:CreatePath({
				AgentCanJump = true,
				AgentCanClimb = true,
				AgentRadius = 3,
			})

			local success, errorMessage = pcall(function()
				path:ComputeAsync(npc.PrimaryPart.Position, pathPart)
			end)

			if success and path.Status == Enum.PathStatus.Success then
				for _, waypoint in ipairs(path:GetWaypoints()) do
					if waypoint.Action == Enum.PathWaypointAction.Jump then humanoid.Jump = true end

					humanoid:MoveTo(waypoint.Position)
					humanoid.MoveToFinished:Wait()
				end
			else
				warn(errorMessage)
			end

			if i == #reversed then hasReachedGoal = true end
		end
		print(hasReachedGoal)

		if hasReachedGoal then
			local helperAtGatheringLocationEvent = Events.GetBindableEvent(Events.BindableNames.HelperAtGatheringLoc)
			if helperAtGatheringLocationEvent then
				print("firing!")
				Events.FireBindableEvent(Events.BindableNames.HelperAtGatheringLoc, hasReachedGoal)
			end
		end
	end
end

return PathFinding
