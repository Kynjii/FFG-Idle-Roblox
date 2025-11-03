local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenService = game:GetService("TweenService")

local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local UIConfig = require(ReplicatedStorage.Shared.UI.UIConfig)
local ProgressBar = {}

function ProgressBar.Create(props: {
	Color: "White" | "WhiteShiny" | "Blue" | "Yellow" | "Green" | "GreenShiny",
	HasText: boolean?,
	HasBillboard: boolean?,
	Adornee: Instance?,
}): BillboardGui | Frame
	local billBoard
	if props.HasBillboard then
		billBoard = Instance.new("BillboardGui")
		billBoard.Name = "ProgressBarContainer"
		billBoard.AlwaysOnTop = true
		if props.Adornee then billBoard.Adornee = props.Adornee end
		billBoard.Enabled = false
		billBoard.LightInfluence = 1
		billBoard.MaxDistance = 100
		billBoard.ResetOnSpawn = false
		billBoard.Size = UDim2.fromScale(1.5, 0.35)
		billBoard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		UIConfig.ApplyList(billBoard, Enum.FillDirection.Vertical, { HAlign = Enum.HorizontalAlignment.Center })
	end

	local progressContainer = Instance.new("Frame")
	progressContainer.Name = "ProgressContainer"
	progressContainer.AnchorPoint = Vector2.new(0.5, 0.5)
	progressContainer.BackgroundTransparency = 1
	progressContainer.LayoutOrder = 3
	progressContainer.Size = UDim2.fromScale(1, 0.33)

	local progressBG = Instance.new("ImageLabel")
	progressBG.Name = "ProgressBG"
	progressBG.AnchorPoint = Vector2.new(0.5, 0.5)
	progressBG.BackgroundTransparency = 1
	progressBG.ClipsDescendants = true
	progressBG.Image = FFGEnum.UI.ProgressBar.InnerBar.White
	progressBG.ImageColor3 = FFGEnum.UI.ProgressBar.BackgroundColor
	progressBG.Position = UDim2.fromScale(0.5, 0.5)
	progressBG.ScaleType = Enum.ScaleType.Slice
	progressBG.Size = UDim2.fromScale(0.9, 0.8)
	progressBG.SliceCenter = Rect.new(20, 37, 21, 37)

	local progressBar = Instance.new("ImageLabel")
	progressBar.Name = "ProgressBar"
	progressBar.AnchorPoint = Vector2.new(0, 0.5)
	progressBar.BackgroundTransparency = 1
	progressBar.Image = FFGEnum.UI.ProgressBar.InnerBar[props.Color] or FFGEnum.UI.ProgressBar.InnerBar.GreenShiny
	progressBar.Position = UDim2.fromScale(0, 0.5)
	progressBar.ScaleType = Enum.ScaleType.Slice
	progressBar.Size = UDim2.fromScale(0, 1)
	progressBar.SliceCenter = Rect.new(20, 37, 21, 37)
	progressBar.ZIndex = 2
	progressBar.Parent = progressBG

	if props.HasText then
		local progressBarText = Instance.new("TextLabel")
		progressBarText.Name = "ProgressBarText"
		progressBarText.AnchorPoint = Vector2.new(0.5, 0.5)
		progressBarText.BackgroundTransparency = 1
		progressBarText.Font = FFGEnum.THEME.bigFont
		progressBarText.Position = UDim2.fromScale(0.5, 0.5)
		progressBarText.Size = UDim2.fromScale(1, 0.8)
		progressBarText.Text = "0 / 100"
		progressBarText.TextColor3 = Color3.new()
		progressBarText.TextScaled = true
		progressBarText.ZIndex = 5
		UIConfig.ApplyTextConstraints(progressBarText, "body")
		progressBarText.Parent = progressBG
	end

	progressBG.Parent = progressContainer

	local container = props.HasBillboard and billBoard or progressContainer
	return container
end

function ProgressBar.Show(parent)
	if not parent then return end

	for _, decendant in pairs(parent:GetDescendants()) do
		if decendant:IsA("Frame") then decendant.Visible = true end
	end
end

function ProgressBar.Hide(parent)
	if not parent then return end

	for _, decendant in pairs(parent:GetDescendants()) do
		if decendant:IsA("Frame") then decendant.Visible = false end
	end
end

function ProgressBar.Update(progressBarFrame: Frame, currentValue: number, maxValue: number)
	local max = maxValue or 0
	local current = currentValue or 0
	local progress = (max > 0) and math.clamp(current / max, 0, 1) or 0

	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local goal = { Size = UDim2.fromScale(progress, 1) }

	local tween = TweenService:Create(progressBarFrame, tweenInfo, goal)
	tween:Play()
	return tween
end

return ProgressBar
