local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)
local Theme = require(ReplicatedStorage.Shared.Theme.Theme)

local create = vide.create

local fontTheme = Theme.font

local hoverStyles = {
	Grow = "Grow",
	Shrink = "Shrink",
	Wiggle = "Wiggle",
}

local function Button(
	props: {
		isImageBtn: boolean,
		ImageAsset: string?,
		HoverAsset: string?,
		TextColor: Color3?,
		BGColor: Color3?,
		Size: UDim2?,
		Position: UDim2?, -- default to {.5 .5}
		Text: string,
		Activated: () -> (),
		Visible: boolean?, -- defaulted to show if not passed
		Rounded: boolean?, -- only adds a corner if passed
		CornerRadius: number?,
		SliceCenter: Rect?,
		ScaleType: Enum?,
		AnchorPoint: Vector2?,
		BackgroundTransparency: number?,
		HoverStyle: string?,
	}
)
	local textButton
	local imageButton

	if not props.isImageBtn then
		textButton = create("TextButton")({
			BackgroundColor3 = props.BGColor or Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = props.BackgroundTransparency or props.BGColor and 0 or 1,
			AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
			Position = props.Position or UDim2.fromScale(0.5, 0.5),
			TextColor3 = props.TextColor or Color3.fromRGB(0, 0, 0),
			Size = props.Size or UDim2.fromOffset(100, 75),
			Visible = props.Visible or true,
			Text = props.Text,
			Font = fontTheme,
			TextScaled = true,
			Activated = props.Activated,
		})
	else
		imageButton = create("ImageButton")({
			Image = props.ImageAsset or "",
			HoverImage = props.HoverAsset or "",
			BackgroundColor3 = not props.ImageAsset and props.BGColor or Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = props.BackgroundTransparency or props.BGColor and 0 or 1,
			AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
			ScaleType = props.ScaleType,
			SliceCenter = props.SliceCenter or Rect.new(50, 50, 37, 37),
			SliceScale = props.ImageAsset and 1,
			Size = props.Size or UDim2.fromOffset(100, 75),
			Visible = props.Visible,
			Position = props.Position,

			Activated = props.Activated,
		})
	end

	if props.Rounded then
		local corner = create("UICorner")({
			CornerRadius = props.CornerRadius,
		})
		corner.Parent = props.isImageBtn and imageButton or textButton
	end

	if props.HoverStyle then
		local button = imageButton or textButton
		if button then button.MouseEnter:Connect(function() end) end
	end

	if props.isImageBtn and props.Text then create("TextLabel")({
		TextColor3 = props.TextColor or Color3.fromRGB(255, 255, 255),
		Font = fontTheme,
		Text = props.Text,
		BackgroundTransparency = props.BackgroundTransparency or 1,
		AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.45),
		Parent = imageButton,
		Size = UDim2.fromScale(0.8, 0.9),
		TextScaled = true,
	}) end

	return imageButton or textButton
end

return Button
