local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local AnimateButtonHover = require(StarterPlayer.StarterPlayerScripts.Client.HUD.Utils.AnimateButtonHover)
local Events = require(ReplicatedStorage.Shared.Events.Events)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local settingsGui = playerGui:WaitForChild("Settings")

local settingsOpened = false

local settingsButton = settingsGui:FindFirstChild("SettingsButton", true) :: ImageButton
local settingsModal = settingsGui:FindFirstChild("SettingsModel", true) :: Frame
local confirmationModel = settingsGui:FindFirstChild("ConfirmationModel", true) :: Frame

if settingsButton then
	local function toggleSettings()
		print("Settings button clicked!")
		if settingsOpened then
			settingsOpened = false
			settingsModal.Visible = false
			confirmationModel.Visible = false
		else
			settingsOpened = true
			settingsModal.Visible = true
		end
	end

	settingsButton.Activated:Connect(function()
		print("clicked")
		toggleSettings()
	end)

	local baseSize = settingsButton.Size
	settingsButton.MouseEnter:Connect(function()
		AnimateButtonHover.Enter(settingsButton, baseSize)
	end)

	settingsButton.MouseLeave:Connect(function()
		AnimateButtonHover.Leave(settingsButton, baseSize)
	end)
end

if settingsModal then
	local resetButton = settingsModal:FindFirstChild("ResetButton", true) :: ImageButton

	if resetButton then resetButton.Activated:Connect(function()
		confirmationModel.Visible = true
		settingsModal.Visible = false
	end) end
end

if confirmationModel then
	local confirmationButton_NO = confirmationModel:FindFirstChild("No", true) :: ImageButton
	local confirmationButton_YES = confirmationModel:FindFirstChild("Yes", true) :: ImageButton

	if confirmationButton_NO then confirmationButton_NO.Activated:Connect(function()
		confirmationModel.Visible = false
		settingsModal.Visible = true
	end) end

	local function handleReset()
		local resetEvent = Events.GetRemote(Events.RemoteNames.GameReset)
		resetEvent:FireServer(player)

		confirmationModel.Visible = false
		settingsModal.Visible = false
	end

	if confirmationButton_YES then confirmationButton_YES.Activated:Connect(function()
		handleReset()
	end) end
end
