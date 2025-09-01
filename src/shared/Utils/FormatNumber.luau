local SUFFIXES = {
	{ value = 1e54, symbol = "Et" }, -- Eternium
	{ value = 1e51, symbol = "St" }, -- Starwoven
	{ value = 1e48, symbol = "Vs" }, -- Voidshard
	{ value = 1e45, symbol = "Tg" }, -- Thronesteel
	{ value = 1e42, symbol = "Sk" }, -- Skyglass
	{ value = 1e39, symbol = "Nf" }, -- Nightfur
	{ value = 1e36, symbol = "Op" }, -- Opalflame
	{ value = 1e33, symbol = "Ar" }, -- Arcanite
	{ value = 1e30, symbol = "Lp" }, -- Lumipaw
	{ value = 1e27, symbol = "Al" }, -- Astralite
	{ value = 1e24, symbol = "Dr" }, -- Dragonite
	{ value = 1e21, symbol = "Ct" }, -- Celestite
	{ value = 1e18, symbol = "My" }, -- Mythril
	{ value = 1e15, symbol = "Qa" }, -- Quadrillion
	{ value = 1e12, symbol = "T" }, -- Trillion
	{ value = 1e9, symbol = "B" }, -- Billion
	{ value = 1e6, symbol = "M" }, -- Million
	{ value = 1e3, symbol = "K" }, -- Thousand
}

-- Formats with 0–2 decimals depending on size, strips trailing .0
local formatNumber = function(n: number): string
	local absn = math.abs(n)

	-- choose suffix if >= 1e3
	for _, s in ipairs(SUFFIXES) do
		if absn >= s.value then
			local v = n / s.value
			local av = math.abs(v)
			local decimals
			if av >= 100 then
				decimals = 0
			elseif av >= 10 then
				decimals = 1
			else
				decimals = 2
			end
			local out = string.format("%." .. decimals .. "f", v)
			out = out:gsub("(%..-)0+$", "%1"):gsub("%.$", "") -- trim trailing zeros/dot
			return out .. s.symbol
		end
	end

	-- no suffix (< 1e3)
	if absn >= 100 then
		return string.format("%.0f", n)
	elseif absn >= 10 then
		return (string.format("%.1f", n):gsub("(%..-)0+$", "%1"):gsub("%.$", ""))
	else
		return (string.format("%.2f", n):gsub("(%..-)0+$", "%1"):gsub("%.$", ""))
	end
end

return formatNumber
