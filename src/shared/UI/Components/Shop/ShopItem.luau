local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)

local function ShopItem(
	props: {
		BackgroundColor3: Color3?,
		BackgroundTransparency: number?,
		Size: UDim2,
		AnchorPoint: Vector2?,
		Position: UDim2?, -- default to {.5 .5}
		Rounded: UDim?,
		ScaleType: Enum?,
		SliceCenter: Rect?,
		Visible: boolean?,
		HoverEffect: boolean?,
		ItemImage: string,
		ItemPrice: string,
		ItemName: string,
		ItemId: string,
	}
)
	local shopItemContainer = Instance.new("CanvasGroup")
	shopItemContainer.Name = props.ItemId
	shopItemContainer.BackgroundTransparency = props.BackgroundTransparency or 1
	shopItemContainer.Size = props.Size
	shopItemContainer.BackgroundColor3 = props.BackgroundColor3 or FFGEnum.THEME.color.white
	shopItemContainer.AnchorPoint = props.AnchorPoint or FFGEnum.THEME.alignment.anchor.center
	shopItemContainer.Position = props.Position or FFGEnum.THEME.alignment.position.center
	shopItemContainer.Visible = props.Visible or true
	shopItemContainer.ClipsDescendants = true

	local strokeThickness = 0
	shopItemContainer.MouseEnter:Connect(function()
		if not props.HoverEffect then return end
	end)
	shopItemContainer.MouseLeave:Connect(function()
		if props.HoverEffect then return end
	end)

	-- //SECTION - Shop Item Outline
	local containerStroke = Instance.new("UIStroke")
	containerStroke.Color = props.HoverEffect and FFGEnum.THEME.shop.shopItem.outline or Color3.new(0, 0, 0)
	containerStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
	containerStroke.Thickness = strokeThickness

	containerStroke.Parent = shopItemContainer

	shopItemContainer.MouseEnter:Connect(function()
		strokeThickness = FFGEnum.THEME.shop.shopItem.outlineThickness
		containerStroke.Thickness = strokeThickness
	end)

	shopItemContainer.MouseLeave:Connect(function()
		strokeThickness = 0
		containerStroke.Thickness = strokeThickness
	end)
	-- //!SECTION

	-- //SECTION -  Shop Item Corner
	local corner = Instance.new("UICorner")
	corner.CornerRadius = props.Rounded
	corner.Parent = shopItemContainer
	-- //!SECTION

	-- //SECTION Holds all the main elements
	local mainContainer = Instance.new("Frame")
	mainContainer.Name = "ShopItemMainContainer"
	mainContainer.Size = UDim2.fromScale(0.9, 0.9)
	mainContainer.Position = FFGEnum.THEME.alignment.position.center
	mainContainer.AnchorPoint = FFGEnum.THEME.alignment.anchor.center
	mainContainer.BackgroundTransparency = 1
	mainContainer.Parent = shopItemContainer
	-- //!SECTION

	-- //SECTION -  Item Image
	local item = Instance.new("ImageLabel")
	item.Image = props.ItemImage
	item.BackgroundTransparency = 1
	item.Size = UDim2.fromScale(0.8, 0.75)
	item.Parent = mainContainer
	-- //!SECTION

	-- //SECTION -  Item Price
	local itemPriceColor = FFGEnum.THEME.shop.shopItem.buttonColor

	local itemPriceTxt = Instance.new("TextLabel")
	itemPriceTxt.BorderSizePixel = 0
	itemPriceTxt.Position = FFGEnum.THEME.alignment.position.bottom
	itemPriceTxt.AnchorPoint = FFGEnum.THEME.alignment.anchor.bottom
	itemPriceTxt.TextColor3 = FFGEnum.THEME.color.white
	itemPriceTxt.BackgroundColor3 = itemPriceColor
	itemPriceTxt.TextScaled = true
	itemPriceTxt.Text = props.ItemPrice
	itemPriceTxt.Font = FFGEnum.THEME.font
	itemPriceTxt.Size = UDim2.fromScale(1, 0.2)
	itemPriceTxt.Parent = shopItemContainer
	-- //!SECTION

	-- //SECTION - UI List Layout
	local uiList = Instance.new("UIListLayout")
	uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uiList.FillDirection = Enum.FillDirection.Vertical
	uiList.SortOrder = Enum.SortOrder.LayoutOrder
	uiList.VerticalFlex = Enum.UIFlexAlignment.SpaceBetween
	uiList.Parent = mainContainer
	-- //!SECTION

	return shopItemContainer
end

return ShopItem
