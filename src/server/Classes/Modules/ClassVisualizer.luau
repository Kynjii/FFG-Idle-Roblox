local ServerScriptService = game:GetService("ServerScriptService")
local FadeEffect = require(ServerScriptService.Server.Modules.Tweens.FadeEffect)
local ClassVisualizer = {}

function ClassVisualizer.Show(root: Model)
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

function ClassVisualizer.Hide(root: Model | Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then FadeEffect.Out(part) end
	end
end

function ClassVisualizer.CanCollide(root: Model | Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then
			if not part.CanCollide then part.CanCollide = true end
		end
	end
end

function ClassVisualizer.CannotCollide(root: Model | Part)
	local modelParts = root:GetChildren()
	for _, part in pairs(modelParts) do
		if part:IsA("Part") or part:IsA("UnionOperation") then
			if part.CanCollide then part.CanCollide = false end
		end
	end
end

return ClassVisualizer
