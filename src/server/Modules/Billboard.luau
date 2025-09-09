local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local FormatNumber = require(ReplicatedStorage.Shared.Utils.FormatNumber)
local Billboard = {}

local DEFAULTS = {
	Duration = 1,
}

function Billboard.Animate(billboard: BillboardGui, textValue: number)
	if billboard and textValue then
		local image = billboard:WaitForChild("ImageLabel")
		local text: TextLabel = billboard:WaitForChild("TextLabel")
		text.Text = "+" .. FormatNumber(textValue)

		Billboard.AnimateBillboard(billboard)
		if image then Billboard.AnimateImageLabel(image) end
		if text then Billboard.AnimateTextLabel(text) end
	end
end

function Billboard.AnimateImageLabel(imageLabel: ImageLabel)
	local tweenGoal: ImageLabel = {
		ImageTransparency = 0,
	}

	local tweenInfo = TweenInfo.new(DEFAULTS.Duration)
	local tween = TweenService:Create(imageLabel, tweenInfo, tweenGoal)

	tween:Play()
end

function Billboard.AnimateTextLabel(textLabel: ImageLabel)
	local tweenGoal: TextLabel = {
		TextTransparency = 0,
	}

	local tweenInfo = TweenInfo.new(DEFAULTS.Duration)
	local tween = TweenService:Create(textLabel, tweenInfo, tweenGoal)

	tween:Play()
end

function Billboard.AnimateBillboard(billboard: BillboardGui)
	local tweenGoal: BillboardGui = {
		StudsOffsetWorldSpace = billboard.StudsOffsetWorldSpace + Vector3.new(0, 0, 2),
	}

	local tweenInfo = TweenInfo.new(DEFAULTS.Duration)
	local tween = TweenService:Create(billboard, tweenInfo, tweenGoal)

	tween.Completed:Connect(function(playbackState)
		billboard:Destroy()
	end)

	tween:Play()
end

return Billboard
