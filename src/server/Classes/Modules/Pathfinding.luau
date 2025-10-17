-- local PFS = game:GetService("PathfindingService")

-- local npc = script.Parent
-- local humanoid = npc:WaitForChild("Humanoid")

-- local pathParts = {
-- 	[1] = game.Workspace:WaitForChild("GoalPart_1"),
-- 	[2] = game.Workspace:WaitForChild("GoalPart_2"),
-- 	[3] = game.Workspace:WaitForChild("GoalPart_3"),
-- 	[4] = game.Workspace:WaitForChild("GoalPart_4"),
-- 	[5] = game.Workspace:WaitForChild("GoalPart_5"),
-- }

-- //TODO -
-- 1. Add waypoints to the Island
-- 2. Assign them to particular lanes
-- 3. Ensure that when returning, to reverse path

-- if pathParts then
-- 	for _, pathPart in ipairs(pathParts) do
-- 		local path = PFS:CreatePath({
-- 			AgentRadius = 3,
-- 			Costs = {
-- 				FencePost = 100,
-- 			},
-- 		})

-- 		local success, errorMessage = pcall(function()
-- 			path:ComputeAsync(npc.PrimaryPart.Position, pathPart.Position)
-- 		end)

-- 		if success then
-- 			for _, waypoint in pairs(path:GetWaypoints()) do
-- 				local part = Instance.new("Part")
-- 				part.Material = "Neon"
-- 				part.Anchored = true
-- 				part.CanCollide = false
-- 				part.Shape = "Ball"
-- 				part.Position = waypoint.Position
-- 				part.Parent = game.Workspace

-- 				humanoid:MoveTo(waypoint.Position)
-- 				humanoid.MoveToFinished:Wait()
-- 			end
-- 		else
-- 			warn(errorMessage)
-- 		end
-- 	end
-- end
