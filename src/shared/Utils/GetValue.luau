-- Primarily used for vide components

local function getValue(val): any
	if type(val) == "function" then return val() end
	return val
end

return getValue
