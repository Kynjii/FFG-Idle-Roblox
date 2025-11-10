local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HelperType = require(ReplicatedStorage.Shared.Types.Classes.HelperType)
local StatsIndexer = {}

function StatsIndexer.Prepare(helper: HelperType.HelperInstance)
	local preparedStatData: { [number]: { [string]: any } }? = {}

	local index = 1
	for statName, statValue in pairs(helper.Stats) do
		preparedStatData[index] = { Label = statName, Value = statValue }
		index += 1
	end

	return preparedStatData
end

return StatsIndexer
