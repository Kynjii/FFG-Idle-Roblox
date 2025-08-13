local RunService = game:GetService("RunService")
local FFGHelpers = {}

FFGHelpers.deepWait = function(parent, ...)
	local result = parent
	for _, name in ipairs({ ... }) do
		result = result:WaitForChild(name)
	end
	return result
end

FFGHelpers.GetStoreName = function()
	return RunService:IsStudio() and "Staging" or "Live"
end

return FFGHelpers
