local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local AnimateButtonHover = require(StarterPlayer.StarterPlayerScripts.Client.HUD.Utils.AnimateButtonHover)
local Events = require(ReplicatedStorage.Shared.Events.Events)
local DeepWait = require(ReplicatedStorage.Shared.Utils.DeepWait)

local player = Players.LocalPlayer
local settingsGui: ScreenGui = DeepWait(player, "PlayerGui", "Settings")

local settingsOpened = false

local settingsBtn = settingsGui:FindFirstChild("SettingsButton", true) :: ImageButton
local settingsModal = settingsGui:FindFirstChild("SettingsModel", true) :: Frame
local confirmationModel = settingsGui:FindFirstChild("ConfirmationModel", true) :: Frame

if settingsBtn then
	print("settings button exists", settingsBtn.Active)
	settingsBtn.Active = true

	print("setting btn is active", settingsBtn.Active)
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

	settingsBtn.MouseButton1Click:Connect(function()
		print("clicked")
		toggleSettings()
	end)

	local baseSize = settingsBtn.Size
	settingsBtn.MouseEnter:Connect(function()
		print("hovered")
		AnimateButtonHover.Enter(settingsBtn, baseSize)
	end)

	settingsBtn.MouseLeave:Connect(function()
		print("hovered out")
		AnimateButtonHover.Leave(settingsBtn, baseSize)
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
