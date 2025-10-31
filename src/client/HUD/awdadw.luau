local crewManagementContainer = Instance.new("Frame")
crewManagementContainer.Name = "CrewManagementContainer"
crewManagementContainer.AnchorPoint = Vector2.new(0.5, 0.5)
crewManagementContainer.BackgroundTransparency = 1
crewManagementContainer.Position = UDim2.fromScale(0.5, 0.5)
crewManagementContainer.Size = UDim2.fromScale(1, 1)

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "UIListLayout"
uIListLayout.FillDirection = Enum.FillDirection.Horizontal
uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.Parent = crewManagementContainer

local availableJobs = Instance.new("ScrollingFrame")
availableJobs.Name = "AvailableJobs"
availableJobs.Active = true
availableJobs.AnchorPoint = Vector2.new(0.5, 0.5)
availableJobs.AutomaticCanvasSize = Enum.AutomaticSize.Y
availableJobs.BackgroundTransparency = 1
availableJobs.ScrollBarImageColor3 = Color3.new()
availableJobs.ScrollBarThickness = 0
availableJobs.ScrollingDirection = Enum.ScrollingDirection.Y
availableJobs.Size = UDim2.fromScale(0.45, 1)

local uIGridLayout = Instance.new("UIGridLayout")
uIGridLayout.Name = "UIGridLayout"
uIGridLayout.CellSize = UDim2.fromScale(0.9, 0.3)
uIGridLayout.FillDirectionMaxCells = 50
uIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout.Parent = availableJobs

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

local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundTransparency = 1
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UDim2.fromScale(1, 1)

local uIPadding = Instance.new("UIPadding")
uIPadding.Name = "UIPadding"
uIPadding.PaddingBottom = UDim.new(0.03, 0)
uIPadding.PaddingLeft = UDim.new(0.03, 0)
uIPadding.PaddingRight = UDim.new(0.03, 0)
uIPadding.PaddingTop = UDim.new(0.03, 0)
uIPadding.Parent = frame

local frame1 = Instance.new("Frame")
frame1.Name = "Frame"
frame1.AnchorPoint = Vector2.new(0, 0.5)
frame1.BackgroundTransparency = 1
frame1.Position = UDim2.fromScale(0, 0.5)
frame1.Size = UDim2.fromScale(0.3, 0.8)

local textLabel = Instance.new("TextLabel")
textLabel.Name = "TextLabel"
textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel.BackgroundTransparency = 1
textLabel.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
textLabel.Position = UDim2.fromScale(0.5, 0.5)
textLabel.Size = UDim2.fromScale(1, 1)
textLabel.Text = "Lane 1"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 14
textLabel.Parent = frame1

frame1.Parent = frame

local frame2 = Instance.new("Frame")
frame2.Name = "Frame"
frame2.AnchorPoint = Vector2.new(1, 0.5)
frame2.BackgroundTransparency = 1
frame2.Position = UDim2.fromScale(1, 0.5)
frame2.Size = UDim2.fromScale(0.7, 1)

local slot1 = Instance.new("ImageButton")
slot1.Name = "Slot_1"
slot1.AnchorPoint = Vector2.new(0.5, 0.5)
slot1.BackgroundTransparency = 1
slot1.HoverImage = "rbxassetid://92405962434895"
slot1.Image = "rbxassetid://97020661068672"
slot1.Position = UDim2.fromScale(0.5, 0.5)
slot1.ScaleType = Enum.ScaleType.Fit
slot1.Size = UDim2.fromScale(1, 1)
slot1.SliceCenter = Rect.new(60, 60, 60, 60)

local bG1 = Instance.new("ImageLabel")
bG1.Name = "BG"
bG1.AnchorPoint = Vector2.new(0.5, 0.5)
bG1.BackgroundTransparency = 1
bG1.Image = "rbxassetid://133301576965616"
bG1.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG1.Position = UDim2.fromScale(0.5, 0.5)
bG1.ScaleType = Enum.ScaleType.Fit
bG1.Size = UDim2.fromScale(0.3, 0.3)
bG1.Parent = slot1

slot1.Parent = frame2

local uIGridLayout1 = Instance.new("UIGridLayout")
uIGridLayout1.Name = "UIGridLayout"
uIGridLayout1.CellSize = UDim2.fromScale(0.3, 1)
uIGridLayout1.FillDirectionMaxCells = 3
uIGridLayout1.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout1.VerticalAlignment = Enum.VerticalAlignment.Center
uIGridLayout1.Parent = frame2

local slot2 = Instance.new("ImageButton")
slot2.Name = "Slot_2"
slot2.AnchorPoint = Vector2.new(0.5, 0.5)
slot2.BackgroundTransparency = 1
slot2.HoverImage = "rbxassetid://92405962434895"
slot2.Image = "rbxassetid://97020661068672"
slot2.Position = UDim2.fromScale(0.5, 0.5)
slot2.ScaleType = Enum.ScaleType.Fit
slot2.Size = UDim2.fromScale(1, 1)
slot2.SliceCenter = Rect.new(60, 60, 60, 60)

local bG2 = Instance.new("ImageLabel")
bG2.Name = "BG"
bG2.AnchorPoint = Vector2.new(0.5, 0.5)
bG2.BackgroundTransparency = 1
bG2.Image = "rbxassetid://133301576965616"
bG2.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG2.Position = UDim2.fromScale(0.5, 0.5)
bG2.ScaleType = Enum.ScaleType.Fit
bG2.Size = UDim2.fromScale(0.3, 0.3)
bG2.Parent = slot2

slot2.Parent = frame2

local slot3 = Instance.new("ImageButton")
slot3.Name = "Slot_3"
slot3.AnchorPoint = Vector2.new(0.5, 0.5)
slot3.BackgroundTransparency = 1
slot3.HoverImage = "rbxassetid://92405962434895"
slot3.Image = "rbxassetid://97020661068672"
slot3.Position = UDim2.fromScale(0.5, 0.5)
slot3.ScaleType = Enum.ScaleType.Fit
slot3.Size = UDim2.fromScale(1, 1)
slot3.SliceCenter = Rect.new(60, 60, 60, 60)

local bG3 = Instance.new("ImageLabel")
bG3.Name = "BG"
bG3.AnchorPoint = Vector2.new(0.5, 0.5)
bG3.BackgroundTransparency = 1
bG3.Image = "rbxassetid://133301576965616"
bG3.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG3.Position = UDim2.fromScale(0.5, 0.5)
bG3.ScaleType = Enum.ScaleType.Fit
bG3.Size = UDim2.fromScale(0.3, 0.3)
bG3.Parent = slot3

slot3.Parent = frame2

frame2.Parent = frame

frame.Parent = availableJobTemplate

availableJobTemplate.Parent = availableJobs

local availableJobTemplate1 = Instance.new("Frame")
availableJobTemplate1.Name = "AvailableJobTemplate"
availableJobTemplate1.AnchorPoint = Vector2.new(0.5, 0.5)
availableJobTemplate1.BackgroundTransparency = 1
availableJobTemplate1.Position = UDim2.fromScale(0.5, 0.5)
availableJobTemplate1.Size = UDim2.fromScale(1, 1)

local bG4 = Instance.new("ImageLabel")
bG4.Name = "BG"
bG4.AnchorPoint = Vector2.new(0.5, 0.5)
bG4.BackgroundTransparency = 1
bG4.Image = "rbxassetid://82464405703579"
bG4.Position = UDim2.fromScale(0.5, 0.5)
bG4.ScaleType = Enum.ScaleType.Slice
bG4.Size = UDim2.fromScale(1, 1)
bG4.SliceCenter = Rect.new(45, 45, 45, 45)
bG4.Parent = availableJobTemplate1

local frame3 = Instance.new("Frame")
frame3.Name = "Frame"
frame3.AnchorPoint = Vector2.new(0.5, 0.5)
frame3.BackgroundTransparency = 1
frame3.Position = UDim2.fromScale(0.5, 0.5)
frame3.Size = UDim2.fromScale(1, 1)

local uIPadding1 = Instance.new("UIPadding")
uIPadding1.Name = "UIPadding"
uIPadding1.PaddingBottom = UDim.new(0.03, 0)
uIPadding1.PaddingLeft = UDim.new(0.03, 0)
uIPadding1.PaddingRight = UDim.new(0.03, 0)
uIPadding1.PaddingTop = UDim.new(0.03, 0)
uIPadding1.Parent = frame3

local frame4 = Instance.new("Frame")
frame4.Name = "Frame"
frame4.AnchorPoint = Vector2.new(0, 0.5)
frame4.BackgroundTransparency = 1
frame4.Position = UDim2.fromScale(0, 0.5)
frame4.Size = UDim2.fromScale(0.3, 0.8)

local textLabel1 = Instance.new("TextLabel")
textLabel1.Name = "TextLabel"
textLabel1.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel1.BackgroundTransparency = 1
textLabel1.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
textLabel1.Position = UDim2.fromScale(0.5, 0.5)
textLabel1.Size = UDim2.fromScale(1, 1)
textLabel1.Text = "Lane 1"
textLabel1.TextColor3 = Color3.new(1, 1, 1)
textLabel1.TextSize = 14
textLabel1.Parent = frame4

frame4.Parent = frame3

local frame5 = Instance.new("Frame")
frame5.Name = "Frame"
frame5.AnchorPoint = Vector2.new(1, 0.5)
frame5.BackgroundTransparency = 1
frame5.Position = UDim2.fromScale(1, 0.5)
frame5.Size = UDim2.fromScale(0.7, 1)

local slot11 = Instance.new("ImageButton")
slot11.Name = "Slot_1"
slot11.AnchorPoint = Vector2.new(0.5, 0.5)
slot11.BackgroundTransparency = 1
slot11.HoverImage = "rbxassetid://92405962434895"
slot11.Image = "rbxassetid://97020661068672"
slot11.Position = UDim2.fromScale(0.5, 0.5)
slot11.ScaleType = Enum.ScaleType.Fit
slot11.Size = UDim2.fromScale(1, 1)
slot11.SliceCenter = Rect.new(60, 60, 60, 60)

local bG5 = Instance.new("ImageLabel")
bG5.Name = "BG"
bG5.AnchorPoint = Vector2.new(0.5, 0.5)
bG5.BackgroundTransparency = 1
bG5.Image = "rbxassetid://133301576965616"
bG5.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG5.Position = UDim2.fromScale(0.5, 0.5)
bG5.ScaleType = Enum.ScaleType.Fit
bG5.Size = UDim2.fromScale(0.3, 0.3)
bG5.Parent = slot11

slot11.Parent = frame5

local uIGridLayout2 = Instance.new("UIGridLayout")
uIGridLayout2.Name = "UIGridLayout"
uIGridLayout2.CellSize = UDim2.fromScale(0.3, 1)
uIGridLayout2.FillDirectionMaxCells = 3
uIGridLayout2.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout2.VerticalAlignment = Enum.VerticalAlignment.Center
uIGridLayout2.Parent = frame5

local slot21 = Instance.new("ImageButton")
slot21.Name = "Slot_2"
slot21.AnchorPoint = Vector2.new(0.5, 0.5)
slot21.BackgroundTransparency = 1
slot21.HoverImage = "rbxassetid://92405962434895"
slot21.Image = "rbxassetid://97020661068672"
slot21.Position = UDim2.fromScale(0.5, 0.5)
slot21.ScaleType = Enum.ScaleType.Fit
slot21.Size = UDim2.fromScale(1, 1)
slot21.SliceCenter = Rect.new(60, 60, 60, 60)

local bG6 = Instance.new("ImageLabel")
bG6.Name = "BG"
bG6.AnchorPoint = Vector2.new(0.5, 0.5)
bG6.BackgroundTransparency = 1
bG6.Image = "rbxassetid://133301576965616"
bG6.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG6.Position = UDim2.fromScale(0.5, 0.5)
bG6.ScaleType = Enum.ScaleType.Fit
bG6.Size = UDim2.fromScale(0.3, 0.3)
bG6.Parent = slot21

slot21.Parent = frame5

local slot31 = Instance.new("ImageButton")
slot31.Name = "Slot_3"
slot31.AnchorPoint = Vector2.new(0.5, 0.5)
slot31.BackgroundTransparency = 1
slot31.HoverImage = "rbxassetid://92405962434895"
slot31.Image = "rbxassetid://97020661068672"
slot31.Position = UDim2.fromScale(0.5, 0.5)
slot31.ScaleType = Enum.ScaleType.Fit
slot31.Size = UDim2.fromScale(1, 1)
slot31.SliceCenter = Rect.new(60, 60, 60, 60)

local bG7 = Instance.new("ImageLabel")
bG7.Name = "BG"
bG7.AnchorPoint = Vector2.new(0.5, 0.5)
bG7.BackgroundTransparency = 1
bG7.Image = "rbxassetid://133301576965616"
bG7.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG7.Position = UDim2.fromScale(0.5, 0.5)
bG7.ScaleType = Enum.ScaleType.Fit
bG7.Size = UDim2.fromScale(0.3, 0.3)
bG7.Parent = slot31

slot31.Parent = frame5

frame5.Parent = frame3

frame3.Parent = availableJobTemplate1

availableJobTemplate1.Parent = availableJobs

local availableJobTemplate2 = Instance.new("Frame")
availableJobTemplate2.Name = "AvailableJobTemplate"
availableJobTemplate2.AnchorPoint = Vector2.new(0.5, 0.5)
availableJobTemplate2.BackgroundTransparency = 1
availableJobTemplate2.Position = UDim2.fromScale(0.5, 0.5)
availableJobTemplate2.Size = UDim2.fromScale(1, 1)

local bG8 = Instance.new("ImageLabel")
bG8.Name = "BG"
bG8.AnchorPoint = Vector2.new(0.5, 0.5)
bG8.BackgroundTransparency = 1
bG8.Image = "rbxassetid://82464405703579"
bG8.Position = UDim2.fromScale(0.5, 0.5)
bG8.ScaleType = Enum.ScaleType.Slice
bG8.Size = UDim2.fromScale(1, 1)
bG8.SliceCenter = Rect.new(45, 45, 45, 45)
bG8.Parent = availableJobTemplate2

local frame6 = Instance.new("Frame")
frame6.Name = "Frame"
frame6.AnchorPoint = Vector2.new(0.5, 0.5)
frame6.BackgroundTransparency = 1
frame6.Position = UDim2.fromScale(0.5, 0.5)
frame6.Size = UDim2.fromScale(1, 1)

local uIPadding2 = Instance.new("UIPadding")
uIPadding2.Name = "UIPadding"
uIPadding2.PaddingBottom = UDim.new(0.03, 0)
uIPadding2.PaddingLeft = UDim.new(0.03, 0)
uIPadding2.PaddingRight = UDim.new(0.03, 0)
uIPadding2.PaddingTop = UDim.new(0.03, 0)
uIPadding2.Parent = frame6

local frame7 = Instance.new("Frame")
frame7.Name = "Frame"
frame7.AnchorPoint = Vector2.new(0, 0.5)
frame7.BackgroundTransparency = 1
frame7.Position = UDim2.fromScale(0, 0.5)
frame7.Size = UDim2.fromScale(0.3, 0.8)

local textLabel2 = Instance.new("TextLabel")
textLabel2.Name = "TextLabel"
textLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel2.BackgroundTransparency = 1
textLabel2.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
textLabel2.Position = UDim2.fromScale(0.5, 0.5)
textLabel2.Size = UDim2.fromScale(1, 1)
textLabel2.Text = "Lane 1"
textLabel2.TextColor3 = Color3.new(1, 1, 1)
textLabel2.TextSize = 14
textLabel2.Parent = frame7

frame7.Parent = frame6

local frame8 = Instance.new("Frame")
frame8.Name = "Frame"
frame8.AnchorPoint = Vector2.new(1, 0.5)
frame8.BackgroundTransparency = 1
frame8.Position = UDim2.fromScale(1, 0.5)
frame8.Size = UDim2.fromScale(0.7, 1)

local slot12 = Instance.new("ImageButton")
slot12.Name = "Slot_1"
slot12.AnchorPoint = Vector2.new(0.5, 0.5)
slot12.BackgroundTransparency = 1
slot12.HoverImage = "rbxassetid://92405962434895"
slot12.Image = "rbxassetid://97020661068672"
slot12.Position = UDim2.fromScale(0.5, 0.5)
slot12.ScaleType = Enum.ScaleType.Fit
slot12.Size = UDim2.fromScale(1, 1)
slot12.SliceCenter = Rect.new(60, 60, 60, 60)

local bG9 = Instance.new("ImageLabel")
bG9.Name = "BG"
bG9.AnchorPoint = Vector2.new(0.5, 0.5)
bG9.BackgroundTransparency = 1
bG9.Image = "rbxassetid://133301576965616"
bG9.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG9.Position = UDim2.fromScale(0.5, 0.5)
bG9.ScaleType = Enum.ScaleType.Fit
bG9.Size = UDim2.fromScale(0.3, 0.3)
bG9.Parent = slot12

slot12.Parent = frame8

local uIGridLayout3 = Instance.new("UIGridLayout")
uIGridLayout3.Name = "UIGridLayout"
uIGridLayout3.CellSize = UDim2.fromScale(0.3, 1)
uIGridLayout3.FillDirectionMaxCells = 3
uIGridLayout3.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout3.VerticalAlignment = Enum.VerticalAlignment.Center
uIGridLayout3.Parent = frame8

local slot22 = Instance.new("ImageButton")
slot22.Name = "Slot_2"
slot22.AnchorPoint = Vector2.new(0.5, 0.5)
slot22.BackgroundTransparency = 1
slot22.HoverImage = "rbxassetid://92405962434895"
slot22.Image = "rbxassetid://97020661068672"
slot22.Position = UDim2.fromScale(0.5, 0.5)
slot22.ScaleType = Enum.ScaleType.Fit
slot22.Size = UDim2.fromScale(1, 1)
slot22.SliceCenter = Rect.new(60, 60, 60, 60)

local bG10 = Instance.new("ImageLabel")
bG10.Name = "BG"
bG10.AnchorPoint = Vector2.new(0.5, 0.5)
bG10.BackgroundTransparency = 1
bG10.Image = "rbxassetid://133301576965616"
bG10.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG10.Position = UDim2.fromScale(0.5, 0.5)
bG10.ScaleType = Enum.ScaleType.Fit
bG10.Size = UDim2.fromScale(0.3, 0.3)
bG10.Parent = slot22

slot22.Parent = frame8

local slot32 = Instance.new("ImageButton")
slot32.Name = "Slot_3"
slot32.AnchorPoint = Vector2.new(0.5, 0.5)
slot32.BackgroundTransparency = 1
slot32.HoverImage = "rbxassetid://92405962434895"
slot32.Image = "rbxassetid://97020661068672"
slot32.Position = UDim2.fromScale(0.5, 0.5)
slot32.ScaleType = Enum.ScaleType.Fit
slot32.Size = UDim2.fromScale(1, 1)
slot32.SliceCenter = Rect.new(60, 60, 60, 60)

local bG11 = Instance.new("ImageLabel")
bG11.Name = "BG"
bG11.AnchorPoint = Vector2.new(0.5, 0.5)
bG11.BackgroundTransparency = 1
bG11.Image = "rbxassetid://133301576965616"
bG11.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG11.Position = UDim2.fromScale(0.5, 0.5)
bG11.ScaleType = Enum.ScaleType.Fit
bG11.Size = UDim2.fromScale(0.3, 0.3)
bG11.Parent = slot32

slot32.Parent = frame8

frame8.Parent = frame6

frame6.Parent = availableJobTemplate2

availableJobTemplate2.Parent = availableJobs

local availableJobTemplate3 = Instance.new("Frame")
availableJobTemplate3.Name = "AvailableJobTemplate"
availableJobTemplate3.AnchorPoint = Vector2.new(0.5, 0.5)
availableJobTemplate3.BackgroundTransparency = 1
availableJobTemplate3.Position = UDim2.fromScale(0.5, 0.5)
availableJobTemplate3.Size = UDim2.fromScale(1, 1)

local bG12 = Instance.new("ImageLabel")
bG12.Name = "BG"
bG12.AnchorPoint = Vector2.new(0.5, 0.5)
bG12.BackgroundTransparency = 1
bG12.Image = "rbxassetid://82464405703579"
bG12.Position = UDim2.fromScale(0.5, 0.5)
bG12.ScaleType = Enum.ScaleType.Slice
bG12.Size = UDim2.fromScale(1, 1)
bG12.SliceCenter = Rect.new(45, 45, 45, 45)
bG12.Parent = availableJobTemplate3

local frame9 = Instance.new("Frame")
frame9.Name = "Frame"
frame9.AnchorPoint = Vector2.new(0.5, 0.5)
frame9.BackgroundTransparency = 1
frame9.Position = UDim2.fromScale(0.5, 0.5)
frame9.Size = UDim2.fromScale(1, 1)

local uIPadding3 = Instance.new("UIPadding")
uIPadding3.Name = "UIPadding"
uIPadding3.PaddingBottom = UDim.new(0.03, 0)
uIPadding3.PaddingLeft = UDim.new(0.03, 0)
uIPadding3.PaddingRight = UDim.new(0.03, 0)
uIPadding3.PaddingTop = UDim.new(0.03, 0)
uIPadding3.Parent = frame9

local frame10 = Instance.new("Frame")
frame10.Name = "Frame"
frame10.AnchorPoint = Vector2.new(0, 0.5)
frame10.BackgroundTransparency = 1
frame10.Position = UDim2.fromScale(0, 0.5)
frame10.Size = UDim2.fromScale(0.3, 0.8)

local textLabel3 = Instance.new("TextLabel")
textLabel3.Name = "TextLabel"
textLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel3.BackgroundTransparency = 1
textLabel3.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
textLabel3.Position = UDim2.fromScale(0.5, 0.5)
textLabel3.Size = UDim2.fromScale(1, 1)
textLabel3.Text = "Lane 1"
textLabel3.TextColor3 = Color3.new(1, 1, 1)
textLabel3.TextSize = 14
textLabel3.Parent = frame10

frame10.Parent = frame9

local frame11 = Instance.new("Frame")
frame11.Name = "Frame"
frame11.AnchorPoint = Vector2.new(1, 0.5)
frame11.BackgroundTransparency = 1
frame11.Position = UDim2.fromScale(1, 0.5)
frame11.Size = UDim2.fromScale(0.7, 1)

local slot13 = Instance.new("ImageButton")
slot13.Name = "Slot_1"
slot13.AnchorPoint = Vector2.new(0.5, 0.5)
slot13.BackgroundTransparency = 1
slot13.HoverImage = "rbxassetid://92405962434895"
slot13.Image = "rbxassetid://97020661068672"
slot13.Position = UDim2.fromScale(0.5, 0.5)
slot13.ScaleType = Enum.ScaleType.Fit
slot13.Size = UDim2.fromScale(1, 1)
slot13.SliceCenter = Rect.new(60, 60, 60, 60)

local bG13 = Instance.new("ImageLabel")
bG13.Name = "BG"
bG13.AnchorPoint = Vector2.new(0.5, 0.5)
bG13.BackgroundTransparency = 1
bG13.Image = "rbxassetid://133301576965616"
bG13.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG13.Position = UDim2.fromScale(0.5, 0.5)
bG13.ScaleType = Enum.ScaleType.Fit
bG13.Size = UDim2.fromScale(0.3, 0.3)
bG13.Parent = slot13

slot13.Parent = frame11

local uIGridLayout4 = Instance.new("UIGridLayout")
uIGridLayout4.Name = "UIGridLayout"
uIGridLayout4.CellSize = UDim2.fromScale(0.3, 1)
uIGridLayout4.FillDirectionMaxCells = 3
uIGridLayout4.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout4.VerticalAlignment = Enum.VerticalAlignment.Center
uIGridLayout4.Parent = frame11

local slot23 = Instance.new("ImageButton")
slot23.Name = "Slot_2"
slot23.AnchorPoint = Vector2.new(0.5, 0.5)
slot23.BackgroundTransparency = 1
slot23.HoverImage = "rbxassetid://92405962434895"
slot23.Image = "rbxassetid://97020661068672"
slot23.Position = UDim2.fromScale(0.5, 0.5)
slot23.ScaleType = Enum.ScaleType.Fit
slot23.Size = UDim2.fromScale(1, 1)
slot23.SliceCenter = Rect.new(60, 60, 60, 60)

local bG14 = Instance.new("ImageLabel")
bG14.Name = "BG"
bG14.AnchorPoint = Vector2.new(0.5, 0.5)
bG14.BackgroundTransparency = 1
bG14.Image = "rbxassetid://133301576965616"
bG14.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG14.Position = UDim2.fromScale(0.5, 0.5)
bG14.ScaleType = Enum.ScaleType.Fit
bG14.Size = UDim2.fromScale(0.3, 0.3)
bG14.Parent = slot23

slot23.Parent = frame11

local slot33 = Instance.new("ImageButton")
slot33.Name = "Slot_3"
slot33.AnchorPoint = Vector2.new(0.5, 0.5)
slot33.BackgroundTransparency = 1
slot33.HoverImage = "rbxassetid://92405962434895"
slot33.Image = "rbxassetid://97020661068672"
slot33.Position = UDim2.fromScale(0.5, 0.5)
slot33.ScaleType = Enum.ScaleType.Fit
slot33.Size = UDim2.fromScale(1, 1)
slot33.SliceCenter = Rect.new(60, 60, 60, 60)

local bG15 = Instance.new("ImageLabel")
bG15.Name = "BG"
bG15.AnchorPoint = Vector2.new(0.5, 0.5)
bG15.BackgroundTransparency = 1
bG15.Image = "rbxassetid://133301576965616"
bG15.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG15.Position = UDim2.fromScale(0.5, 0.5)
bG15.ScaleType = Enum.ScaleType.Fit
bG15.Size = UDim2.fromScale(0.3, 0.3)
bG15.Parent = slot33

slot33.Parent = frame11

frame11.Parent = frame9

frame9.Parent = availableJobTemplate3

availableJobTemplate3.Parent = availableJobs

local availableJobTemplate4 = Instance.new("Frame")
availableJobTemplate4.Name = "AvailableJobTemplate"
availableJobTemplate4.AnchorPoint = Vector2.new(0.5, 0.5)
availableJobTemplate4.BackgroundTransparency = 1
availableJobTemplate4.Position = UDim2.fromScale(0.5, 0.5)
availableJobTemplate4.Size = UDim2.fromScale(1, 1)

local bG16 = Instance.new("ImageLabel")
bG16.Name = "BG"
bG16.AnchorPoint = Vector2.new(0.5, 0.5)
bG16.BackgroundTransparency = 1
bG16.Image = "rbxassetid://82464405703579"
bG16.Position = UDim2.fromScale(0.5, 0.5)
bG16.ScaleType = Enum.ScaleType.Slice
bG16.Size = UDim2.fromScale(1, 1)
bG16.SliceCenter = Rect.new(45, 45, 45, 45)
bG16.Parent = availableJobTemplate4

local frame12 = Instance.new("Frame")
frame12.Name = "Frame"
frame12.AnchorPoint = Vector2.new(0.5, 0.5)
frame12.BackgroundTransparency = 1
frame12.Position = UDim2.fromScale(0.5, 0.5)
frame12.Size = UDim2.fromScale(1, 1)

local uIPadding4 = Instance.new("UIPadding")
uIPadding4.Name = "UIPadding"
uIPadding4.PaddingBottom = UDim.new(0.03, 0)
uIPadding4.PaddingLeft = UDim.new(0.03, 0)
uIPadding4.PaddingRight = UDim.new(0.03, 0)
uIPadding4.PaddingTop = UDim.new(0.03, 0)
uIPadding4.Parent = frame12

local frame13 = Instance.new("Frame")
frame13.Name = "Frame"
frame13.AnchorPoint = Vector2.new(0, 0.5)
frame13.BackgroundTransparency = 1
frame13.Position = UDim2.fromScale(0, 0.5)
frame13.Size = UDim2.fromScale(0.3, 0.8)

local textLabel4 = Instance.new("TextLabel")
textLabel4.Name = "TextLabel"
textLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel4.BackgroundTransparency = 1
textLabel4.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
textLabel4.Position = UDim2.fromScale(0.5, 0.5)
textLabel4.Size = UDim2.fromScale(1, 1)
textLabel4.Text = "Lane 1"
textLabel4.TextColor3 = Color3.new(1, 1, 1)
textLabel4.TextSize = 14
textLabel4.Parent = frame13

frame13.Parent = frame12

local frame14 = Instance.new("Frame")
frame14.Name = "Frame"
frame14.AnchorPoint = Vector2.new(1, 0.5)
frame14.BackgroundTransparency = 1
frame14.Position = UDim2.fromScale(1, 0.5)
frame14.Size = UDim2.fromScale(0.7, 1)

local slot14 = Instance.new("ImageButton")
slot14.Name = "Slot_1"
slot14.AnchorPoint = Vector2.new(0.5, 0.5)
slot14.BackgroundTransparency = 1
slot14.HoverImage = "rbxassetid://92405962434895"
slot14.Image = "rbxassetid://97020661068672"
slot14.Position = UDim2.fromScale(0.5, 0.5)
slot14.ScaleType = Enum.ScaleType.Fit
slot14.Size = UDim2.fromScale(1, 1)
slot14.SliceCenter = Rect.new(60, 60, 60, 60)

local bG17 = Instance.new("ImageLabel")
bG17.Name = "BG"
bG17.AnchorPoint = Vector2.new(0.5, 0.5)
bG17.BackgroundTransparency = 1
bG17.Image = "rbxassetid://133301576965616"
bG17.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG17.Position = UDim2.fromScale(0.5, 0.5)
bG17.ScaleType = Enum.ScaleType.Fit
bG17.Size = UDim2.fromScale(0.3, 0.3)
bG17.Parent = slot14

slot14.Parent = frame14

local uIGridLayout5 = Instance.new("UIGridLayout")
uIGridLayout5.Name = "UIGridLayout"
uIGridLayout5.CellSize = UDim2.fromScale(0.3, 1)
uIGridLayout5.FillDirectionMaxCells = 3
uIGridLayout5.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout5.VerticalAlignment = Enum.VerticalAlignment.Center
uIGridLayout5.Parent = frame14

local slot24 = Instance.new("ImageButton")
slot24.Name = "Slot_2"
slot24.AnchorPoint = Vector2.new(0.5, 0.5)
slot24.BackgroundTransparency = 1
slot24.HoverImage = "rbxassetid://92405962434895"
slot24.Image = "rbxassetid://97020661068672"
slot24.Position = UDim2.fromScale(0.5, 0.5)
slot24.ScaleType = Enum.ScaleType.Fit
slot24.Size = UDim2.fromScale(1, 1)
slot24.SliceCenter = Rect.new(60, 60, 60, 60)

local bG18 = Instance.new("ImageLabel")
bG18.Name = "BG"
bG18.AnchorPoint = Vector2.new(0.5, 0.5)
bG18.BackgroundTransparency = 1
bG18.Image = "rbxassetid://133301576965616"
bG18.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG18.Position = UDim2.fromScale(0.5, 0.5)
bG18.ScaleType = Enum.ScaleType.Fit
bG18.Size = UDim2.fromScale(0.3, 0.3)
bG18.Parent = slot24

slot24.Parent = frame14

local slot34 = Instance.new("ImageButton")
slot34.Name = "Slot_3"
slot34.AnchorPoint = Vector2.new(0.5, 0.5)
slot34.BackgroundTransparency = 1
slot34.HoverImage = "rbxassetid://92405962434895"
slot34.Image = "rbxassetid://97020661068672"
slot34.Position = UDim2.fromScale(0.5, 0.5)
slot34.ScaleType = Enum.ScaleType.Fit
slot34.Size = UDim2.fromScale(1, 1)
slot34.SliceCenter = Rect.new(60, 60, 60, 60)

local bG19 = Instance.new("ImageLabel")
bG19.Name = "BG"
bG19.AnchorPoint = Vector2.new(0.5, 0.5)
bG19.BackgroundTransparency = 1
bG19.Image = "rbxassetid://133301576965616"
bG19.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG19.Position = UDim2.fromScale(0.5, 0.5)
bG19.ScaleType = Enum.ScaleType.Fit
bG19.Size = UDim2.fromScale(0.3, 0.3)
bG19.Parent = slot34

slot34.Parent = frame14

frame14.Parent = frame12

frame12.Parent = availableJobTemplate4

availableJobTemplate4.Parent = availableJobs

local availableJobTemplate5 = Instance.new("Frame")
availableJobTemplate5.Name = "AvailableJobTemplate"
availableJobTemplate5.AnchorPoint = Vector2.new(0.5, 0.5)
availableJobTemplate5.BackgroundTransparency = 1
availableJobTemplate5.Position = UDim2.fromScale(0.5, 0.5)
availableJobTemplate5.Size = UDim2.fromScale(1, 1)

local bG20 = Instance.new("ImageLabel")
bG20.Name = "BG"
bG20.AnchorPoint = Vector2.new(0.5, 0.5)
bG20.BackgroundTransparency = 1
bG20.Image = "rbxassetid://82464405703579"
bG20.Position = UDim2.fromScale(0.5, 0.5)
bG20.ScaleType = Enum.ScaleType.Slice
bG20.Size = UDim2.fromScale(1, 1)
bG20.SliceCenter = Rect.new(45, 45, 45, 45)
bG20.Parent = availableJobTemplate5

local frame15 = Instance.new("Frame")
frame15.Name = "Frame"
frame15.AnchorPoint = Vector2.new(0.5, 0.5)
frame15.BackgroundTransparency = 1
frame15.Position = UDim2.fromScale(0.5, 0.5)
frame15.Size = UDim2.fromScale(1, 1)

local uIPadding5 = Instance.new("UIPadding")
uIPadding5.Name = "UIPadding"
uIPadding5.PaddingBottom = UDim.new(0.03, 0)
uIPadding5.PaddingLeft = UDim.new(0.03, 0)
uIPadding5.PaddingRight = UDim.new(0.03, 0)
uIPadding5.PaddingTop = UDim.new(0.03, 0)
uIPadding5.Parent = frame15

local frame16 = Instance.new("Frame")
frame16.Name = "Frame"
frame16.AnchorPoint = Vector2.new(0, 0.5)
frame16.BackgroundTransparency = 1
frame16.Position = UDim2.fromScale(0, 0.5)
frame16.Size = UDim2.fromScale(0.3, 0.8)

local textLabel5 = Instance.new("TextLabel")
textLabel5.Name = "TextLabel"
textLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel5.BackgroundTransparency = 1
textLabel5.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
textLabel5.Position = UDim2.fromScale(0.5, 0.5)
textLabel5.Size = UDim2.fromScale(1, 1)
textLabel5.Text = "Lane 1"
textLabel5.TextColor3 = Color3.new(1, 1, 1)
textLabel5.TextSize = 14
textLabel5.Parent = frame16

frame16.Parent = frame15

local frame17 = Instance.new("Frame")
frame17.Name = "Frame"
frame17.AnchorPoint = Vector2.new(1, 0.5)
frame17.BackgroundTransparency = 1
frame17.Position = UDim2.fromScale(1, 0.5)
frame17.Size = UDim2.fromScale(0.7, 1)

local slot15 = Instance.new("ImageButton")
slot15.Name = "Slot_1"
slot15.AnchorPoint = Vector2.new(0.5, 0.5)
slot15.BackgroundTransparency = 1
slot15.HoverImage = "rbxassetid://92405962434895"
slot15.Image = "rbxassetid://97020661068672"
slot15.Position = UDim2.fromScale(0.5, 0.5)
slot15.ScaleType = Enum.ScaleType.Fit
slot15.Size = UDim2.fromScale(1, 1)
slot15.SliceCenter = Rect.new(60, 60, 60, 60)

local bG21 = Instance.new("ImageLabel")
bG21.Name = "BG"
bG21.AnchorPoint = Vector2.new(0.5, 0.5)
bG21.BackgroundTransparency = 1
bG21.Image = "rbxassetid://133301576965616"
bG21.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG21.Position = UDim2.fromScale(0.5, 0.5)
bG21.ScaleType = Enum.ScaleType.Fit
bG21.Size = UDim2.fromScale(0.3, 0.3)
bG21.Parent = slot15

slot15.Parent = frame17

local uIGridLayout6 = Instance.new("UIGridLayout")
uIGridLayout6.Name = "UIGridLayout"
uIGridLayout6.CellSize = UDim2.fromScale(0.3, 1)
uIGridLayout6.FillDirectionMaxCells = 3
uIGridLayout6.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout6.VerticalAlignment = Enum.VerticalAlignment.Center
uIGridLayout6.Parent = frame17

local slot25 = Instance.new("ImageButton")
slot25.Name = "Slot_2"
slot25.AnchorPoint = Vector2.new(0.5, 0.5)
slot25.BackgroundTransparency = 1
slot25.HoverImage = "rbxassetid://92405962434895"
slot25.Image = "rbxassetid://97020661068672"
slot25.Position = UDim2.fromScale(0.5, 0.5)
slot25.ScaleType = Enum.ScaleType.Fit
slot25.Size = UDim2.fromScale(1, 1)
slot25.SliceCenter = Rect.new(60, 60, 60, 60)

local bG22 = Instance.new("ImageLabel")
bG22.Name = "BG"
bG22.AnchorPoint = Vector2.new(0.5, 0.5)
bG22.BackgroundTransparency = 1
bG22.Image = "rbxassetid://133301576965616"
bG22.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG22.Position = UDim2.fromScale(0.5, 0.5)
bG22.ScaleType = Enum.ScaleType.Fit
bG22.Size = UDim2.fromScale(0.3, 0.3)
bG22.Parent = slot25

slot25.Parent = frame17

local slot35 = Instance.new("ImageButton")
slot35.Name = "Slot_3"
slot35.AnchorPoint = Vector2.new(0.5, 0.5)
slot35.BackgroundTransparency = 1
slot35.HoverImage = "rbxassetid://92405962434895"
slot35.Image = "rbxassetid://97020661068672"
slot35.Position = UDim2.fromScale(0.5, 0.5)
slot35.ScaleType = Enum.ScaleType.Fit
slot35.Size = UDim2.fromScale(1, 1)
slot35.SliceCenter = Rect.new(60, 60, 60, 60)

local bG23 = Instance.new("ImageLabel")
bG23.Name = "BG"
bG23.AnchorPoint = Vector2.new(0.5, 0.5)
bG23.BackgroundTransparency = 1
bG23.Image = "rbxassetid://133301576965616"
bG23.ImageColor3 = Color3.fromRGB(44, 55, 198)
bG23.Position = UDim2.fromScale(0.5, 0.5)
bG23.ScaleType = Enum.ScaleType.Fit
bG23.Size = UDim2.fromScale(0.3, 0.3)
bG23.Parent = slot35

slot35.Parent = frame17

frame17.Parent = frame15

frame15.Parent = availableJobTemplate5

availableJobTemplate5.Parent = availableJobs

local uIPadding6 = Instance.new("UIPadding")
uIPadding6.Name = "UIPadding"
uIPadding6.PaddingTop = UDim.new(0.03, 0)
uIPadding6.Parent = availableJobs

availableJobs.Parent = crewManagementContainer

local availableCrew = Instance.new("ScrollingFrame")
availableCrew.Name = "AvailableCrew"
availableCrew.Active = true
availableCrew.AnchorPoint = Vector2.new(0.5, 0.5)
availableCrew.AutomaticCanvasSize = Enum.AutomaticSize.Y
availableCrew.BackgroundTransparency = 1
availableCrew.ScrollBarImageColor3 = Color3.new()
availableCrew.ScrollBarThickness = 0
availableCrew.ScrollingDirection = Enum.ScrollingDirection.Y
availableCrew.Size = UDim2.fromScale(0.45, 1)

local uIGridLayout7 = Instance.new("UIGridLayout")
uIGridLayout7.Name = "UIGridLayout"
uIGridLayout7.CellSize = UDim2.fromScale(0.95, 0.3)
uIGridLayout7.FillDirection = Enum.FillDirection.Vertical
uIGridLayout7.FillDirectionMaxCells = 50
uIGridLayout7.HorizontalAlignment = Enum.HorizontalAlignment.Center
uIGridLayout7.SortOrder = Enum.SortOrder.LayoutOrder
uIGridLayout7.Parent = availableCrew

local uIPadding7 = Instance.new("UIPadding")
uIPadding7.Name = "UIPadding"
uIPadding7.PaddingTop = UDim.new(0.03, 0)
uIPadding7.Parent = availableCrew

local frame18 = Instance.new("Frame")
frame18.Name = "Frame"
frame18.AnchorPoint = Vector2.new(0.5, 0.5)
frame18.BackgroundColor3 = Color3.new(1, 1, 1)
frame18.BorderColor3 = Color3.new()
frame18.BorderSizePixel = 0
frame18.Position = UDim2.fromScale(0.5, 0.5)
frame18.Size = UDim2.fromScale(1, 1)
frame18.Parent = availableCrew

availableCrew.Parent = crewManagementContainer
