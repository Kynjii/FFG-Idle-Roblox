local RunService = game:GetService("RunService")
local FFGHelpers = {}

FFGHelpers.GetStoreName = function()
	return RunService:IsStudio() and "Staging" or "Live"
end

FFGHelpers.PrintLog = function(msg: string, v: any)
	if RunService:IsStudio() then
		if not v then
			print(msg)
		else
			print(msg, v)
		end
	end
end

return FFGHelpers
