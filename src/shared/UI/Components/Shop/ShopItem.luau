local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local GetValue = require(ReplicatedStorage.Shared.Utils.GetValue)

-- //SECTION -  Vide functions
local create = vide.create
local effect = vide.effect
local source = vide.source
local spring = vide.spring
-- //!SECTION

local alignment = {
	position = {
		center = UDim2.fromScale(0.5, 0.5),
	},
	anchor = {
		center = Vector2.new(0.5, 0.5),
	},
}

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
	}
)
	-- //SECTION - Shop Item State
	local isOwned = source(false)
	-- //!SECTION

	-- //SECTION - Shop Item Container
	-- Handles outline hover
	local strokeThicknessSource = source(0)
	local strokeThickness = spring(strokeThicknessSource, 0.2)
	local springDebounce = false

	local shopItemContainer = create("Frame")({
		BackgroundTransparency = props.BackgroundTransparency or 1,
		Size = props.Size,
		BackgroundColor3 = props.BackgroundColor3 or FFGEnum.THEME.color.white,
		AnchorPoint = props.AnchorPoint or alignment.anchor.center,
		Position = props.Position or alignment.position.center,
		Visible = props.Visible or true,

		MouseEnter = function()
			if not GetValue(props.HoverEffect) then return end
			if springDebounce then return end
			springDebounce = true
			strokeThicknessSource(FFGEnum.THEME.shopItem.outlineThickness)
		end,
		MouseLeave = function()
			if not GetValue(props.HoverEffect) then return end
			strokeThicknessSource(0)
			springDebounce = false
		end,
	})

	-- //SECTION - Shop Item Outline
	local containerStroke = create("UIStroke")({
		Color = props.HoverEffect and FFGEnum.THEME.shopItem.outline or Color3.new(0, 0, 0),
		StrokeSizingMode = Enum.StrokeSizingMode.FixedSize,
		Thickness = strokeThickness,
	})
	containerStroke.Parent = shopItemContainer
	-- //!SECTION

	-- //SECTION -  Shop Item Corner
	local corner = create("UICorner")({})
	corner.Parent = shopItemContainer

	if GetValue(props.Rounded) then
		corner.CornerRadius = props.Rounded
	else
		corner.CornerRadius = UDim.new(0)
	end
	-- //!SECTION

	-- //SECTION Holds all the main elements
	local mainContainer = create("Frame")({
		Size = UDim2.fromScale(0.9, 0.9),
		Position = alignment.position.center,
		AnchorPoint = alignment.anchor.center,
		BackgroundTransparency = 1,
	})
	mainContainer.Parent = shopItemContainer
	-- //!SECTION

	-- //SECTION -  Item Image
	local item = create("ImageLabel")({
		Image = props.ItemImage,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.8, 0.75),
	})
	item.Parent = mainContainer
	-- //!SECTION

	-- //SECTION -  Buy Button
	local buttonSize = UDim2.fromScale(1, 0.2)
	local sizeSource = source(buttonSize)
	local buttonColor = source(FFGEnum.THEME.shopItem.buttonColor)
	local buttonText = source("Purchase")
	local size = spring(sizeSource, 0.2)
	local sizeSpringDebounce = false

	local buyButton = create("ImageButton")({
		BackgroundTransparency = 1,
		PressedImage = FFGEnum.THEME.button.white,
		Image = FFGEnum.THEME.button.white,
		HoverImage = FFGEnum.THEME.button.white,
		ImageColor3 = buttonColor,
		ScaleType = props.ScaleType,
		SliceCenter = props.SliceCenter,
		Size = size,
		Activated = function(input)
			isOwned(true)
		end,
		MouseEnter = function()
			if sizeSpringDebounce then return end
			sizeSpringDebounce = true
			local size = buttonSize + UDim2.fromScale(0.01, 0.01)
			sizeSource(size)
		end,
		MouseLeave = function()
			sizeSource(buttonSize)
			sizeSpringDebounce = false
		end,
	})
	buyButton.LayoutOrder = 2
	buyButton.Parent = mainContainer

	local buttonTxt = create("TextLabel")({
		Position = UDim2.fromScale(0.5, 0.45),
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = FFGEnum.THEME.color.white,
		BackgroundTransparency = 1,
		TextScaled = true,
		Text = buttonText,
		Font = FFGEnum.THEME.font,
		Size = buyButton.Size + UDim2.fromScale(0, 0.5),
	})
	buttonTxt.Parent = buyButton
	-- //!SECTION

	-- //SECTION - UI List Layout
	local uiList = create("UIListLayout")({
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		FillDirection = Enum.FillDirection.Vertical,
		VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
	})
	uiList.Parent = mainContainer
	-- //!SECTION

	-- //SECTION - Effects
	effect(function()
		if isOwned() then
			buttonColor(FFGEnum.THEME.button.disabledColor)
			buttonText("Owned")

			buyButton.Active = false
			buyButton.Interactable = false
		end
	end)
	-- //!SECTION

	return shopItemContainer
end

return ShopItem
