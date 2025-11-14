local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFGEnum = require(ReplicatedStorage.Shared.Enums.FFGEnum)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local ShopGUI = require(ReplicatedStorage.Shared.UI.Components.Shop.ShopGUI)
local ShopItem = require(ReplicatedStorage.Shared.UI.Components.Shop.ShopItem)
local Tooltip = require(ReplicatedStorage.Shared.UI.Components.Tooltips.Tooltip)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local main: Instance
local inventoryItemsContainer: Instance
local screenGui: ScreenGui
local fishDexButtonScreenGui = playerGui:WaitForChild("FishDexButton")
local hudFishDexButton = fishDexButtonScreenGui:FindFirstChild("OpenButton", true) :: ImageButton

task.spawn(function()
	screenGui = ShopGUI.Create({ screenGuiName = "PlayerFishDex", shopName = "FISHDEX" })
	screenGui.Parent = playerGui

	main = screenGui:FindFirstChild("Main", true) :: Frame
	if main then inventoryItemsContainer = main:FindFirstChild("ItemContainer", true) :: ScrollingFrame end
end)

function clearExistingTooltip()
	Tooltip.ClearExisting(player.UserId)
end

function createitemComponent(fish)
	return ShopItem({
		ItemData = fish,
		BackgroundColor3 = FFGEnum.QUALITIES[2].Color,
		Size = UDim2.fromScale(1, 1),
		Rounded = FFGEnum.THEME.button.cornerRadius,
		HoverEffect = true,
		Visible = true,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(77, 77, 100, 111),
		Parent = inventoryItemsContainer,
		ShopInstance = main,
	})
end

local playerFishDex: { [string]: any } = {}
local itemComponents = {}

function updateUI(keepTooltip: boolean)
	if not keepTooltip then clearExistingTooltip() end

	for _, component: Instance in pairs(itemComponents) do
		component:Destroy()
	end

	itemComponents = {}

	if inventoryItemsContainer then
		for k, item in pairs(playerFishDex) do
			local itemComponent = createitemComponent(item)
			itemComponents[`{item.SpeciesKey}_{item.Variant}`] = itemComponent
		end
	end
end

function populateDetailsUI(keepTooltip: boolean?)
	if not playerFishDex then return end
	local blur = Instance.new("BlurEffect")
	blur.Parent = Lighting

	updateUI(keepTooltip)
end

local getFishDexFn = Events.GetRemoteFn(Events.RemoteFunctionNames.GetFishDex)
hudFishDexButton.Activated:Connect(function()
	if screenGui.Enabled then
		screenGui.Enabled = false
		if Lighting then
			local blur = Lighting:FindFirstChild("Blur")
			if blur then blur:Destroy() end
		end
		return
	end

	local data = getFishDexFn:InvokeServer()
	if data then
		playerFishDex = data

		populateDetailsUI()
		screenGui.Enabled = true
	end
end)
