--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CrewManagementPanel =
	require(ReplicatedStorage.Shared.UI.Components.Frames.CrewManagementPanel)

local function story(target)
	local panel = CrewManagementPanel.Create({
		JobId = 1,
		Slots = {
			MaxSlots = 3,
			LockedSlots = 1,
			AssignedHelpers = {
				[1] = {
					Name = "Transporter",
					Level = 5,
					QualityId = 2,
				},
			},
		},
	})
	panel.Parent = target

	return function()
		panel:Destroy()
	end
end

return story
