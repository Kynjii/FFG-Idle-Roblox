local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharmSync = require(ReplicatedStorage.Packages.CharmSync)
local PlayerStateService = require(ReplicatedStorage.Shared.Atoms.PlayerStateService)
local CharmPackets = require(ReplicatedStorage.Shared.Networking.CharmSyncPackets)
task.wait(3)

local atomsToGet = PlayerStateService:Get()

local syncer = CharmSync.client({
    atoms = atomsToGet,
    ignoreUnhydrated = true,
})

CharmPackets.StateUpdate.listen(function(data)
    syncer:sync(data.message)
end)

CharmPackets.RequestHydrate.send({
    message = true,
})
