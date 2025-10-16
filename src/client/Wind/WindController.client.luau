local WIND_DIRECTION = Vector3.new(19.161, 0, 5.748)
local WIND_SPEED = 20

local WindLines = require(script.Parent.WindLines)

WindLines:Init({
	Direction = WIND_DIRECTION,
	Speed = WIND_SPEED,
	Lifetime = 4,
	SpawnRate = 8,
})
