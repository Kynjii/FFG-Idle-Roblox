local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.vide)
local UILabs = require(ReplicatedStorage.Packages.uilabs)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local CreateVideStory = UILabs.CreateVideStory

local Datatype = UILabs.Datatype

local shopItem = require(ReplicatedStorage.Shared.UI.Components.Shop.ShopItem)

-- UILab controls
local controls = {
	BackgroundColor3 = Datatype.Color3(FFGEnum.THEME.shopItem.bgColor), -- Color3 is inside "Datatype", this is to avoid name collisions
	BackgroundTransparency = UILabs.Number(0),
	HoverEffect = UILabs.Boolean(false),
	Visible = UILabs.Boolean(true),
}

local story = CreateVideStory({
	vide = Vide,
	controls = controls,
}, function(props)
	Vide.cleanup(function()
		print("Story is getting unmounted")
	end)

	return shopItem({
		ItemImage = "rbxassetid://135112095865386",
		BackgroundColor3 = props.controls.BackgroundColor3,
		BackgroundTransparency = props.controls.BackgroundTransparency,
		Size = UDim2.fromOffset(100, 100),
		Rounded = FFGEnum.THEME.button.cornerRadius,
		HoverEffect = props.controls.HoverEffect,
		Visible = props.controls.Visible,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(32, 83, 32, 83),
	})
end)

return story
