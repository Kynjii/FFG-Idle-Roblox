local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Button = require(ReplicatedStorage.Shared.UI.Components.Buttons.Button)

local function story(target)
	local item = Button.Create({
		text = "Buy",
		color = "Green",
	})
	item.Parent = target

	return function()
		item:Destroy()
	end
end

return story
