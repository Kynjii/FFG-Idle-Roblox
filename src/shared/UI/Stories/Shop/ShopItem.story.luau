local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local ShopItem = require(ReplicatedStorage.Shared.UI.Components.Shop.ShopItem)

local props = {
	BackgroundColor3 = FFGEnum.THEME.shop.shopItem.bgColor,
	BackgroundTransparency = 0,
	HoverEffect = true,
	Visible = true,
}

local function story(target)
	local item = ShopItem({
		ItemImage = "rbxassetid://115795857064062",
		Size = UDim2.fromOffset(150, 200),
		Rounded = FFGEnum.THEME.button.cornerRadius,
		HoverEffect = props.HoverEffect,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(83, 83, 94, 105),
		ItemBaseCost = "1.1k",
		ItemName = "hammer_01",
		ItemId = "Hammer",
		ItemQualityId = 2,
		ItemDescription = "",
		Parent = target,
		ShopInstance = target,
	})

	return function()
		item:Destroy()
	end
end

return story
