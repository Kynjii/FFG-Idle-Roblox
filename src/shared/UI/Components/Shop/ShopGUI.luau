local Lighting = game:GetService("Lighting")
local StarterPlayer = game:GetService("StarterPlayer")
local AnimateButtonHover = require(StarterPlayer.StarterPlayerScripts.Client.HUD.Utils.AnimateButtonHover)

local ShopGUI = {}

function ShopGUI.Create(props: {
	ShopName: string,
	ScreenGuiName: string,
})
	local shopScreenGui = Instance.new("ScreenGui")
	shopScreenGui.Name = props.ScreenGuiName
	shopScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	shopScreenGui.Enabled = true

	local detailsContainer = Instance.new("Frame")
	detailsContainer.Name = "DetailsContainer"
	detailsContainer.AnchorPoint = Vector2.new(0.5, 0.5)
	detailsContainer.BackgroundTransparency = 1
	detailsContainer.Position = UDim2.fromScale(0.5, 0.5)
	detailsContainer.Size = UDim2.fromScale(1, 1)

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.BackgroundColor3 = Color3.fromRGB(246, 250, 252)
	main.Position = UDim2.fromScale(0.490615, 0.518226)
	main.Size = UDim2.fromScale(0.499, 0.611)

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.CornerRadius = UDim.new(0.07, 0)
	uICorner.Parent = main

	local uIStroke = Instance.new("UIStroke")
	uIStroke.Name = "UIStroke"
	uIStroke.Thickness = 5
	uIStroke.Parent = main

	local title = Instance.new("Frame")
	title.Name = "Title"
	title.AnchorPoint = Vector2.new(0.5, 0.5)
	title.BackgroundColor3 = Color3.new(1, 1, 1)
	title.Position = UDim2.fromScale(0.176558, -0.03)
	title.Size = UDim2.fromScale(0.252294, 0.124159)
	title.ZIndex = 2

	local title1 = Instance.new("TextLabel")
	title1.Name = "Title"
	title1.AnchorPoint = Vector2.new(0.5, 0.5)
	title1.BackgroundTransparency = 1
	title1.Font = Enum.Font.FredokaOne
	title1.Position = UDim2.fromScale(0.490228, 0.5)
	title1.Size = UDim2.fromScale(0.895789, 1)
	title1.Text = props.ShopName
	title1.TextColor3 = Color3.new(1, 1, 1)
	title1.TextScaled = true
	title1.TextStrokeTransparency = 0.7
	title1.Parent = title

	local uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	uIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
	uIAspectRatioConstraint.AspectRatio = 3.14286
	uIAspectRatioConstraint.Parent = title

	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.CornerRadius = UDim.new(0.2, 0)
	uICorner1.Parent = title

	local uIStroke1 = Instance.new("UIStroke")
	uIStroke1.Name = "UIStroke"
	uIStroke1.Thickness = 4
	uIStroke1.Parent = title

	local uIGradient = Instance.new("UIGradient")
	uIGradient.Name = "UIGradient"
	uIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 234, 43)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 182, 12)),
	})
	uIGradient.Parent = title

	title.Parent = main

	local closeButton = Instance.new("ImageButton")
	closeButton.Name = "CloseButton"
	closeButton.AnchorPoint = Vector2.new(0.5, 0.5)
	closeButton.BackgroundColor3 = Color3.new(1, 1, 1)
	closeButton.Position = UDim2.fromScale(1.00485, -0.00189609)
	closeButton.Size = UDim2.fromScale(0.059633, 0.0922324)

	local baseSize = closeButton.Size
	closeButton.Activated:Connect(function()
		ShopGUI.CloseShop(shopScreenGui)
	end)

	closeButton.MouseEnter:Connect(function()
		AnimateButtonHover.Enter(closeButton, baseSize)
	end)

	closeButton.MouseLeave:Connect(function()
		AnimateButtonHover.Leave(closeButton, baseSize)
	end)

	local uICorner2 = Instance.new("UICorner")
	uICorner2.Name = "UICorner"
	uICorner2.CornerRadius = UDim.new(0.2, 0)
	uICorner2.Parent = closeButton

	local uIGradient1 = Instance.new("UIGradient")
	uIGradient1.Name = "UIGradient"
	uIGradient1.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 87, 152)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(249, 85, 107)),
	})
	uIGradient1.Parent = closeButton

	local uIStroke2 = Instance.new("UIStroke")
	uIStroke2.Name = "UIStroke"
	uIStroke2.Thickness = 3
	uIStroke2.Parent = closeButton

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "TextLabel"
	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.FredokaOne
	textLabel.Position = UDim2.fromScale(0.5, 0.5)
	textLabel.Size = UDim2.fromScale(0.480769, 0.634615)
	textLabel.Text = "X"
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextScaled = true
	textLabel.TextStrokeTransparency = 0

	local uIStroke3 = Instance.new("UIStroke")
	uIStroke3.Name = "UIStroke"
	uIStroke3.Thickness = 2
	uIStroke3.Parent = textLabel

	textLabel.Parent = closeButton

	local uIAspectRatioConstraint1 = Instance.new("UIAspectRatioConstraint")
	uIAspectRatioConstraint1.Name = "UIAspectRatioConstraint"
	uIAspectRatioConstraint1.Parent = closeButton

	closeButton.Parent = main

	local shopItemsContainer = Instance.new("ScrollingFrame")
	shopItemsContainer.Name = "ShopItemsContainer"
	shopItemsContainer.Active = true
	shopItemsContainer.AnchorPoint = Vector2.new(0.5, 0.5)
	shopItemsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
	shopItemsContainer.BackgroundTransparency = 1
	shopItemsContainer.CanvasSize = UDim2.fromScale(0, 4)
	shopItemsContainer.Position = UDim2.fromScale(0.5, 0.533006)
	shopItemsContainer.ScrollBarImageColor3 = Color3.new()
	shopItemsContainer.ScrollBarThickness = 0
	shopItemsContainer.ScrollingDirection = Enum.ScrollingDirection.Y
	shopItemsContainer.Size = UDim2.fromScale(1, 0.933988)

	local uiGridLayout = Instance.new("UIGridLayout")
	uiGridLayout.Name = "UIGridLayout"
	uiGridLayout.CellPadding = UDim2.fromScale(0.05, 0.05)
	uiGridLayout.FillDirection = Enum.FillDirection.Horizontal
	uiGridLayout.FillDirectionMaxCells = 5
	uiGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uiGridLayout.Parent = shopItemsContainer

	local gridPadding = Instance.new("UIPadding")
	gridPadding.Name = "GridPadding"
	gridPadding.PaddingBottom = UDim.new(0.01, 0)
	gridPadding.PaddingLeft = UDim.new(0.01, 0)
	gridPadding.PaddingRight = UDim.new(0.01, 0)
	gridPadding.PaddingTop = UDim.new(0.01, 0)

	shopItemsContainer.Parent = main

	main.Parent = detailsContainer

	detailsContainer.Parent = shopScreenGui

	return shopScreenGui
end

function ShopGUI.CloseShop(screenGui)
	screenGui.Enabled = false
	if Lighting then
		local blur = Lighting:FindFirstChild("Blur")
		if blur then blur:Destroy() end
	end
end

return ShopGUI
