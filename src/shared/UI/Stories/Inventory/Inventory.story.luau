local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerInventory = require(ReplicatedStorage.Shared.UI.Components.Inventory.PlayerInventory)

local function story(target)
	local instance = PlayerInventory.Create({ Name = "Inventory", ScreenGuiName = "PlayerInventory" })
	local detailsContainer = instance:WaitForChild("DetailsContainer") :: Frame
	detailsContainer.Parent = target

	return function()
		detailsContainer:Destroy()
	end
end

return story
