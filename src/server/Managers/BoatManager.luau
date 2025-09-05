local BoatManager = {}
BoatManager.Profiles = {}

function BoatManager.RegisterBoat(boatModel: Model, player: Player)
	-- Get Attribute from the model for it's Tier
	-- Attempt to locate the associated Tender based on Owner (player.UserId) and Tier
	-- Add a player profile for the boat/tender similar to DataService
end

function BoatManager.RegisterTender(tenderModel: Model, player: Player)
	-- Get Attribute from the model for it's Tier
	-- Attempt to locate the associated Tender based on Owner (player.UserId) and Tier
	-- Add a player profile for the boat/tender similar to DataService
end

function BoatManager.LoadFish(tenderState, linkedBoat)
	-- create function to locate the correct Boat the Tender is linked to
	-- create function to attempt to add fish within a 5 second timeframe
	-- create function to move the Tender to the Port/Original position
	-- ReadyToOffload(state, boat)
end

function BoatManager.OffloadFish(tenderState, linkedBoat)
	-- create function to attempt to remove fish within a 5 second timeframe
	-- create function to move the Tender to the Port/Original position
	-- ReadyForFish(tenderState, linkedBoat)
end

return BoatManager
