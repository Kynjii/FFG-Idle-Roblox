local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.vide)
local UILabs = require(ReplicatedStorage.Packages.uilabs)
local Theme = require(ReplicatedStorage.Shared.Theme.Theme)
local CreateVideStory = UILabs.CreateVideStory

local button = require(ReplicatedStorage.Shared.UI.Components.Button.Button)

local controls = {
	Visible = true,
	Text = UILabs.String("Purchase"),
}

local story = CreateVideStory({
	vide = Vide,
	controls = controls,
}, function(props)
	Vide.cleanup(function()
		print("Story is getting unmounted")
	end)

	return button({
		isImageBtn = true,
		ImageAsset = Theme.button.shopBuy,
		HoverAsset = Theme.button.shopBuyHover,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(32, 83, 32, 83),
		Position = UDim2.fromScale(0.5, 0.5),
		Text = props.controls.Text,
		Visible = props.controls.Visible,
		Activated = function()
			print("yellow")
		end,
	})
end)

return story
