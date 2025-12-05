local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HelperType = require(ReplicatedStorage.Shared.Types.Classes.HelperType)
local RodType = require(ReplicatedStorage.Shared.Types.RodType)
local StatsIndexer = {}

function StatsIndexer.Prepare(item: HelperType.HelperInstance | RodType.FishingRodType)
	local preparedStatData: { [number]: { [string]: any } }? = {}

	local index = 1
	for statName, statValue in pairs(item.Stats) do
		preparedStatData[index] = { Label = statName, Value = statValue }
		index += 1
	end

	return preparedStatData
end

return StatsIndexer
