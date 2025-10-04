local ServerScriptService = game:GetService("ServerScriptService")
local FadeEffect = require(ServerScriptService.Server.Modules.Tweens.FadeEffect)
local ClassVisualizer = {}

function ClassVisualizer.Show(root: Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then
			if part.Name == "Window" then
				part.Transparency = 0.9
			else
				FadeEffect.In(part)
			end
		end
	end
end

function ClassVisualizer.Hide(root: Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then FadeEffect.Out(part) end
	end
end

function ClassVisualizer.CanCollide(root: Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then
			if not part.CanCollide then part.CanCollide = true end
		end
	end
end

function ClassVisualizer.CannotCollide(root: Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then
			if part.CanCollide then part.CanCollide = false end
		end
	end
end

return ClassVisualizer
