local islandShopGUI = Instance.new("ScreenGui")
islandShopGUI.Name = "IslandShopGUI"
islandShopGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
islandShopGUI.Enabled = true

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
title1.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
title1.Position = UDim2.fromScale(0.490228, 0.5)
title1.Size = UDim2.fromScale(0.895789, 1)
title1.Text = "SHOP"
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
textLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
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
shopItemsContainer.AutomaticCanvasSize = Enum.AutomaticSize.XY
shopItemsContainer.BackgroundTransparency = 1
shopItemsContainer.CanvasSize = UDim2.fromScale(0, 4)
shopItemsContainer.Position = UDim2.fromScale(0.5, 0.533006)
shopItemsContainer.ScrollBarImageColor3 = Color3.new()
shopItemsContainer.ScrollBarThickness = 0
shopItemsContainer.ScrollingDirection = Enum.ScrollingDirection.Y
shopItemsContainer.Size = UDim2.fromScale(1, 0.933988)

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "UIListLayout"
uIListLayout.Padding = UDim.new(0.05, 0)
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.Parent = shopItemsContainer

shopItemsContainer.Parent = main

main.Parent = detailsContainer

detailsContainer.Parent = islandShopGUI

return islandShopGUI
