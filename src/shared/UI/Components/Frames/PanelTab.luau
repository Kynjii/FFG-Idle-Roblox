local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local PanelTab = {}

function PanelTab.Create(props: {
	Name: string,
	Parent: Instance,
	LayoutOrder: number?,
	Icon: string?,
})
	local tab = Instance.new("ImageButton")
	tab.Name = props.Name or "Tab"
	tab.AnchorPoint = Vector2.new(0.5, 0.5)
	tab.BackgroundTransparency = 1
	tab.HoverImage = FFGEnum.UI.Tabs.LeftHoverTab
	tab.Image = FFGEnum.UI.Tabs.LeftTab
	tab.ImageColor3 = Color3.fromRGB(152, 0, 5)
	tab.Position = UDim2.fromScale(0.5, 0.5)
	tab.ScaleType = Enum.ScaleType.Slice
	tab.Size = UDim2.fromScale(1, 0.136934)
	tab.SliceCenter = Rect.new(44, 65, 47, 65)
	tab.LayoutOrder = props.LayoutOrder or 0

	local bG = Instance.new("ImageLabel")
	bG.Name = "TabBackground"
	bG.AnchorPoint = Vector2.new(0.5, 0.5)
	bG.BackgroundTransparency = 1
	bG.Image = props.Icon
	bG.Position = UDim2.fromScale(0.606425, 0.490344)
	bG.ScaleType = Enum.ScaleType.Fit
	bG.Size = UDim2.fromScale(0.771813, 0.679712)

	local uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	uIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
	uIAspectRatioConstraint.Parent = bG

	bG.Parent = tab
	tab.Parent = props.Parent

	return tab
end

return PanelTab
