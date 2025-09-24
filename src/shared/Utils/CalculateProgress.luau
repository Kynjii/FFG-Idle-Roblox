local CalculateProgress = function(currentValue: number, maxValue: number)
	if currentValue == nil or maxValue == nil then print("A value was nil when attempting to calculate progress") end

	local progress = currentValue / maxValue

	if currentValue == 0 then progress = 0 end

	return progress
end

return CalculateProgress
