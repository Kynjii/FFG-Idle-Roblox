local TweenService = game:GetService("TweenService")
local Fade = {}

local DEFAULTS = {
	Duration = 1,
}

function Fade.In(part: Part)
	local tweenGoal: Part = {
		Transparency = 0,
	}

	local _progressTween = nil
	if _progressTween then
		_progressTween:Cancel()
		_progressTween = nil
	end

	local tweenInfo = TweenInfo.new(DEFAULTS.Duration)
	local tween = TweenService:Create(part, tweenInfo, tweenGoal)

	tween.Completed:Once(function()
		if _progressTween == tween then _progressTween = nil end
	end)

	tween:Play()
end

function Fade.Out(part: Part)
	local tweenGoal: Part = {
		Transparency = 1,
	}

	local _progressTween = nil
	if _progressTween then
		_progressTween:Cancel()
		_progressTween = nil
	end

	local tweenInfo = TweenInfo.new(DEFAULTS.Duration)
	local tween = TweenService:Create(part, tweenInfo, tweenGoal)

	tween.Completed:Once(function()
		if _progressTween == tween then _progressTween = nil end
	end)

	tween:Play()
end

return Fade
