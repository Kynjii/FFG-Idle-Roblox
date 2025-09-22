local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local DeepWait = require(ReplicatedStorage.Shared.Utils.DeepWait)
local TextPopUp = {}

local DEFAULTS = {
	Duration = 1,
}

local labels = {
	RedWarning = "RedWarning",
}

local function showMessage(textLabel: TextLabel)
	local tweenGoal: TextLabel = {
		TextTransparency = 0,
	}

	local tweenInfo = TweenInfo.new(0.3)
	local tween = TweenService:Create(textLabel, tweenInfo, tweenGoal)

	tween.Completed:Once(function()
		tween:Destroy()
	end)

	tween:Play()
end

local function animateMessage(textLabel: TextLabel)
	if not textLabel then return end

	local biggerSize = UDim2.fromScale(1, 1)

	local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
	local tween = TweenService:Create(textLabel, tweenInfo, { Size = biggerSize })
	tween:Play()

	tween.Completed:Connect(function()
		textLabel:Destroy()
		tween:Destroy()
	end)
end

function TextPopUp.ShowRedTextPopUp(player: Player, msg: string)
	local textLabelTemplate = DeepWait(player.PlayerGui, "HUD", "Warnings", labels.RedWarning)

	local textLabel: TextLabel
	if textLabelTemplate then
		textLabel = textLabelTemplate:Clone()
		textLabel.Parent = textLabelTemplate.Parent
		textLabel.Name = "WarningMsg_Clone"
		textLabel.Text = msg
		textLabel.Visible = true
	end

	showMessage(textLabel)
	animateMessage(textLabel)
end

return TextPopUp
