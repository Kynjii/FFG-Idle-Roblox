local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Tooltip = require(ReplicatedStorage.Shared.UI.Components.Tooltips.Tooltip)

local props = {
	BackgroundColor3 = FFGEnum.THEME.shop.shopItem.bgColor,
	BackgroundTransparency = 0,
	HoverEffect = true,
	Visible = true,
}

local function story(target)
	local tooltip = Tooltip.Create({
		ItemLevel = 5,
		ItemImage = "rbxassetid://135112095865386",
		ItemQualityId = 1,
		BackgroundColor3 = props.BackgroundColor3,
		Size = UDim2.fromScale(0.5, 1),
		Rounded = FFGEnum.THEME.button.cornerRadius,
		Visible = props.Visible,
		ItemBaseCost = "1.2k",
		ItemName = "Flynn's Hammer",
		ItemDescription = "A crew member specialized in Transporting Fish from the Port to the Market.",
		ItemStats = { [1] = { Label = "Storage", Value = 50 }, [2] = { Label = "WalkSpeed", Value = 10 } },
		ItemId = "999",
		IsPurchased = true,
		Parent = target,
	})

	return function()
		tooltip:Destroy()
	end
end

return story
