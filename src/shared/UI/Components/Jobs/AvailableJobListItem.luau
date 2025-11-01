local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Jobs = require(ServerScriptService.Server.Modules.Jobs.Jobs)
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local UIConfig = require(ReplicatedStorage.Shared.UI.UIConfig)
local AvailableJobListItem = {}

function AvailableJobListItem.Create(props: {
	Slots: {
		MaxSlots: number,
		LockedSlots: number,
		AssignedHelpers: {
			[number]: { Name: string, Level: number, QualityId: number }?,
		},
	},
	JobId: number,
})
	local availableJobTemplate = Instance.new("Frame")
	availableJobTemplate.Name = "AvailableJobTemplate"
	availableJobTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
	availableJobTemplate.BackgroundTransparency = 1
	availableJobTemplate.Position = UDim2.fromScale(0.5, 0.5)
	availableJobTemplate.Size = UDim2.fromScale(1, 1)

	local bG = Instance.new("ImageLabel")
	bG.Name = "BG"
	bG.AnchorPoint = Vector2.new(0.5, 0.5)
	bG.BackgroundTransparency = 1
	bG.Image = "rbxassetid://82464405703579"
	bG.Position = UDim2.fromScale(0.5, 0.5)
	bG.ScaleType = Enum.ScaleType.Slice
	bG.Size = UDim2.fromScale(1, 1)
	bG.SliceCenter = Rect.new(45, 45, 45, 45)
	bG.Parent = availableJobTemplate

	local container = Instance.new("Frame")
	container.Name = "Container"
	container.AnchorPoint = Vector2.new(0.5, 0.5)
	container.BackgroundTransparency = 1
	container.Position = UDim2.fromScale(0.5, 0.5)
	container.Size = UDim2.fromScale(1, 1)

	local containerList = Instance.new("UIListLayout")
	containerList.FillDirection = Enum.FillDirection.Vertical
	containerList.SortOrder = Enum.SortOrder.LayoutOrder
	containerList.Parent = container

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0.03, 0)
	uIPadding.PaddingLeft = UDim.new(0.03, 0)
	uIPadding.PaddingRight = UDim.new(0.03, 0)
	uIPadding.PaddingTop = UDim.new(0.03, 0)
	uIPadding.Parent = container

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "TextLabel"
	textLabel.LayoutOrder = 1
	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.BackgroundTransparency = 1
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Font = FFGEnum.THEME.bigFont
	textLabel.Position = UDim2.fromScale(0.5, 0.5)
	textLabel.Size = UDim2.fromScale(0.49, 0.2)
	textLabel.Text = Jobs.Data[props.JobId].Label or ""
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextSize = 14
	UIConfig.ApplyTextConstraints(textLabel, "h1")
	textLabel.Parent = container

	local mainContainer = Instance.new("Frame")
	mainContainer.Size = UDim2.fromScale(1, 0.7)
	mainContainer.BackgroundTransparency = 1
	mainContainer.LayoutOrder = 2
	UIConfig.ApplyList(
		mainContainer,
		Enum.FillDirection.Horizontal,
		{ VAlign = Enum.VerticalAlignment.Center }
	)
	mainContainer.Parent = container

	local slotContainer = Instance.new("Frame")
	slotContainer.Size = UDim2.fromScale(0.7, 1)
	slotContainer.LayoutOrder = 1
	slotContainer.BackgroundTransparency = 1
	slotContainer.Parent = mainContainer
	local list = UIConfig.ApplyList(slotContainer, Enum.FillDirection.Vertical)
	UIConfig.SetGap(list, "S")

	for i = 1, props.Slots.MaxSlots do
		if not props.Slots.AssignedHelpers[i] then break end

		local slot = Instance.new("Frame")
		slot.Name = "SlotListItem"
		slot.BackgroundTransparency = 1
		slot.Size = UDim2.fromScale(0.8, 0.3)

		local slotMainContainer = Instance.new("Frame")
		slotMainContainer.ZIndex = 5
		slotMainContainer.Size = UDim2.fromScale(1, 1)
		slotMainContainer.BackgroundTransparency = 1
		slotMainContainer.Parent = slot
		UIConfig.ApplyList(
			slotMainContainer,
			Enum.FillDirection.Horizontal,
			{ HFlex = Enum.UIFlexAlignment.SpaceBetween }
		)

		local helperName = Instance.new("TextLabel")
		helperName.Size = UDim2.fromScale(0.3, 1)
		helperName.BackgroundTransparency = 1
		helperName.Font = FFGEnum.THEME.bigFont
		helperName.TextColor3 = FFGEnum.QUALITIES[props.Slots.AssignedHelpers[i].QualityId].Color
		helperName.Text = props.Slots.AssignedHelpers[i].Name or ""
		UIConfig.ApplyTextConstraints(helperName, "caption")
		helperName.Parent = slotMainContainer

		local helperLevel = Instance.new("TextLabel")
		helperLevel.Size = UDim2.fromScale(0.3, 1)
		helperLevel.BackgroundTransparency = 1
		helperLevel.Font = FFGEnum.THEME.bigFont
		helperLevel.TextColor3 = FFGEnum.THEME.color.white
		helperLevel.Text = `Level {props.Slots.AssignedHelpers[i].Level}` or ""
		UIConfig.ApplyTextConstraints(helperLevel, "caption")
		helperLevel.Parent = slotMainContainer

		local slotBg = Instance.new("ImageLabel")
		slotBg.Size = UDim2.fromScale(1, 1)
		slotBg.BackgroundTransparency = 1
		slotBg.Image = "rbxassetid://94314557664644"
		slotBg.ScaleType = Enum.ScaleType.Slice
		slotBg.SliceCenter = Rect.new(45, 45, 45, 45)
		slotBg.Parent = slot

		slot.Parent = slotContainer
	end

	local assignButton = Instance.new("ImageButton")
	assignButton.Name = "AssignButton"
	assignButton.LayoutOrder = 2
	assignButton.AnchorPoint = Vector2.new(0.5, 0.5)
	assignButton.BackgroundTransparency = 1
	assignButton.Image = "rbxassetid://119147831935362"
	assignButton.ScaleType = Enum.ScaleType.Fit
	assignButton.Size = UDim2.fromScale(0.3, 0.5)
	assignButton.Parent = mainContainer

	container.Parent = availableJobTemplate

	return availableJobTemplate
end

return AvailableJobListItem
