local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local React = require(ReplicatedStorage.Packages.react)
local ReactRoblox = require(ReplicatedStorage.Packages:FindFirstChild("react-roblox"))

local function MyTestFrame()
    return React.createElement("Frame", {
        Size = UDim2.new(0, 100, 0, 100),
    })
end

local handle = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui)
local root = ReactRoblox.createRoot(handle)
root:render(React.createElement(MyTestFrame, {}, {}))
