--[[
	Events.luau
	
	Central registry for RemoteEvents, RemoteFunctions, BindableEvents, and BindableFunctions.
	
	Usage:
		Events.InitOnServer() -- Call once during server init
		local remote = Events.GetRemote(Events.RemoteNames.GoldChanged)
		remote:FireClient(player, newGold)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Events = {}

Events.RemoteNames = {
    PlayerAssigned = "PlayerAssigned",
    GoldChanged = "GoldChanged",
    LootNotification = "LootNotification",
    PlayerNotification = "PlayerNotification",
    OpenEntityDetails = "OpenEntityDetails",
    OpenHelperShop = "OpenHelperShop",
    OpenMarketShop = "OpenMarketShop",
    OpenFishingRodShop = "OpenFishingRodShop",
    OpenJobPanel = "OpenJobPanel",
    UpdateHelperShopUI = "UpdateHelperShopUI",
    UpdateFishingRodShopUI = "UpdateFishingRodShopUI",
    PurchaseJobSlot = "PurchaseJobSlot",
    HelperPurchased = "HelperPurchased",
    UpgradeHelper = "UpgradeHelper",
    UpdateJobManagementUI = "UpdateJobManagementUI",
    UpdateInfoPanel = "UpdateInfoPanel",
    HelperUpgraded = "HelperUpgraded",
    AssignJob = "AssignJob",
    StartFishingMiniGame = "StartFishingMiniGame",
    FishingResult = "FishingResult",
    GameEnded = "GameEnded",
    SellItem = "SellItem",
    UpdateMarketUI = "UpdateMarketUI",
    RodPurchased = "RodPurchased",
}

Events.RemoteFunctionNames = {
    GetHelperInventory = "GetHelperInventory",
    GetCrewManagementState = "GetCrewManagementState",
    GetPlayerInventory = "GetPlayerInventory",
    GetJobData = "GetJobData",
    GetFishDex = "GetFishDex",
    GetFishStat = "GetFishStat",
    CanAfford = "CanAfford",
}

Events.BindableFunctionNames = {
    GatherResource = {
        Fish = "Fish",
        Ore = "Ore",
        Wood = "Wood",
        OpenFish = "OpenFish",
    },
}

--- Bindable event names for server-side internal communication
Events.BindableNames = {
    -- UI
    ShowTooltip = "ShowTooltip", -- Display tooltip popup
    CloseUIWindow = "CloseUIWindow", -- Close an open UI window

    -- Helper Pathfinding
    HelperAtGatheringLoc = "HelperAtGatheringLoc", -- Helper reached gather point
    HelperAtUnloadingLoc = "HelperAtUnloadingLoc", -- Helper reached unload point

    -- Transporter (Helper) cycle
    GetStorageFish = "RequestStorageFish", -- Request fish from port storage
    SendStorageFish = "SendStorageFish", -- Deposit fish to port storage

    -- Entity Purchase/Upgrade/State
    PurchaseEntity = "PurchaseEntity", -- Entity was purchased
    UpdateState = "UpdateState", -- Entity state changed

    -- Jobs
    JobUnlocked = "JobUnlocked", -- New job tier unlocked

    -- Helper Purchase
    HelperUpgraded = "HelperUpgraded", -- Helper was upgraded
    PurchasedHelper = "PurchasedHelper", -- Helper was purchased

    -- Rod Purchased
    PurchasedRod = "PurchasedRod", -- Fishing rod was purchased

    -- Helper UI (CrewManagement)
    AvailableHelperSelected = "AvailableHelperSelected", -- Helper selected in UI

    -- Tab selection
    TabSelected = "TabSelected", -- UI tab was selected

    -- FishDex
    UpdateCaughtFish = "UpdateCaughtFish", -- New fish added to collection

    -- Fishing
    FishCaught = "FishCaught", -- Fish was caught
    EquippedRod = "EquippedRod", -- Rod was equipped
}

local FOLDER_NAME = "RME" -- Remote Events folder
local FOLDER_NAME_BINDABLES = "BEV" -- Bindable Events folder
local FOLDER_NAME_BINDABLE_FUNCS = "BFN" -- Bindable Functions folder
local FOLDER_NAME_REMOTE_FUNCS = "RFN" -- Remote Functions folder

--- Initializes all event instances on the server.
--- Must be called once during server startup before any events are used.
--- Creates folders and instances for all registered event names.
function Events.InitOnServer()
    assert(RunService:IsServer(), "InitOnServer must be called from the server")

    -- Remotes
    local remoteFolder = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
    if not remoteFolder then
        remoteFolder = Instance.new("Folder")
        remoteFolder.Name = FOLDER_NAME
        remoteFolder.Parent = ReplicatedStorage
    end

    for _, remoteName in pairs(Events.RemoteNames) do
        if not remoteFolder:FindFirstChild(remoteName) then
            local ev = Instance.new("RemoteEvent")
            ev.Name = remoteName
            ev.Parent = remoteFolder
        end
    end

    local remoteFnFolder = ReplicatedStorage:FindFirstChild(FOLDER_NAME_REMOTE_FUNCS)
    if not remoteFnFolder then
        remoteFnFolder = Instance.new("Folder")
        remoteFnFolder.Name = FOLDER_NAME_REMOTE_FUNCS
        remoteFnFolder.Parent = ReplicatedStorage
    end

    for _, remoteFnName in pairs(Events.RemoteFunctionNames) do
        if not remoteFnFolder:FindFirstChild(remoteFnName) then
            local ev = Instance.new("RemoteFunction")
            ev.Name = remoteFnName
            ev.Parent = remoteFnFolder
        end
    end

    -- Bindables
    local bindableFolder = ReplicatedStorage:FindFirstChild(FOLDER_NAME_BINDABLES)
    if not bindableFolder then
        bindableFolder = Instance.new("Folder")
        bindableFolder.Name = FOLDER_NAME_BINDABLES
        bindableFolder.Parent = ReplicatedStorage
    end

    for _, bindableName in pairs(Events.BindableNames) do
        if not bindableFolder:FindFirstChild(bindableName) then
            local ev = Instance.new("BindableEvent")
            ev.Name = bindableName
            ev.Parent = bindableFolder
        end
    end

    local bindableFnFolder = ReplicatedStorage:FindFirstChild(FOLDER_NAME_BINDABLE_FUNCS)
    if not bindableFnFolder then
        bindableFnFolder = Instance.new("Folder")
        bindableFnFolder.Name = FOLDER_NAME_BINDABLE_FUNCS
        bindableFnFolder.Parent = ReplicatedStorage
    end

    for _, bindableFnName in pairs(Events.BindableFunctionNames.GatherResource) do
        if not bindableFnFolder:FindFirstChild(bindableFnName) then
            local ev = Instance.new("BindableFunction")
            ev.Name = bindableFnName
            ev.Parent = bindableFnFolder
        end
    end
end

--- Gets a RemoteEvent by name, waiting if necessary.
--- @param name string -- Event name from Events.RemoteNames
--- @return RemoteEvent? -- The event instance, or nil if not found
function Events.GetRemote(name: string): RemoteEvent?
    local folder = ReplicatedStorage:WaitForChild(FOLDER_NAME, 10)
    if not folder then
        return nil
    end
    local ev = folder:FindFirstChild(name)
    if ev and ev:IsA("RemoteEvent") then
        return ev
    end

    return folder:WaitForChild(name, 5) :: RemoteEvent
end

--- Gets a BindableEvent by name, waiting if necessary.
--- @param name string -- Event name from Events.BindableNames
--- @return BindableEvent? -- The event instance, or nil if not found
function Events.GetBindableEvent(name: string): BindableEvent?
    local folder = ReplicatedStorage:WaitForChild(FOLDER_NAME_BINDABLES, 10)
    if not folder then
        return nil
    end
    local ev = folder:FindFirstChild(name)
    if ev and ev:IsA("BindableEvent") then
        return ev
    end

    return folder:WaitForChild(name, 5) :: BindableEvent
end

--- Gets a RemoteFunction by name, waiting if necessary.
--- @param name string -- Function name from Events.RemoteFunctionNames
--- @return RemoteFunction? -- The function instance, or nil if not found
function Events.GetRemoteFn(name: string): RemoteFunction?
    local folder = ReplicatedStorage:WaitForChild(FOLDER_NAME_REMOTE_FUNCS, 10)
    if not folder then
        return nil
    end
    local ev = folder:FindFirstChild(name)
    if ev and ev:IsA("RemoteFunction") then
        return ev
    end

    return folder:WaitForChild(name, 5) :: RemoteFunction
end

--- Gets a BindableFunction by name, waiting if necessary.
--- @param name string -- Function name from Events.BindableFunctionNames
--- @return BindableFunction? -- The function instance, or nil if not found
function Events.GetBindableFn(name: string): BindableFunction?
    local folder = ReplicatedStorage:WaitForChild(FOLDER_NAME_BINDABLE_FUNCS, 10)
    if not folder then
        return nil
    end
    local ev = folder:FindFirstChild(name)
    if ev and ev:IsA("BindableFunction") then
        return ev
    end

    return folder:WaitForChild(name, 5) :: BindableFunction
end

--- Fires a BindableEvent with the given data.
--- @param name string -- Event name from Events.BindableNames
--- @param data any -- Data to pass to listeners
--- @return boolean -- True if event was found and fired
function Events.FireBindableEvent(name: string, data: any)
    local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME_BINDABLES)
    local ev = folder and folder:FindFirstChild(name)
    if ev and ev:IsA("BindableEvent") then
        ev:Fire(data)
        return true
    else
        warn(("BindableEvent %q not found under ReplicatedStorage/%s"):format(name, FOLDER_NAME_BINDABLES))
        return false
    end
end

--- Fires a RemoteEvent to a specific player (server) or to server (client).
--- @param name string -- Event name from Events.RemoteNames
--- @param player Player -- Target player (server-side only)
--- @param data any -- Data to send
--- @return boolean -- True if event was found and fired
function Events.FireEvent(name: string, player: Player, data: any)
    local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
    local ev = folder and folder:FindFirstChild(name)
    if ev and ev:IsA("RemoteEvent") then
        if RunService:IsServer() then
            ev:FireClient(player, data)
        end
        if RunService:IsClient() then
            ev:FireServer(data)
        end

        return true
    else
        warn(("RemoteEvent %q not found under ReplicatedStorage/%s"):format(name, FOLDER_NAME))
        return false
    end
end

return Events
