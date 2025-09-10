local function setInterval(fn: () -> (), interval: number)
	local alive = true
	local thread = task.spawn(function()
		while alive do
			local ok, err = pcall(fn)
			if not ok then warn("[setInterval] Error in callback:", err) end
			task.wait(interval)
		end
	end)

	return function()
		alive = false
		if thread then task.cancel(thread) end
	end
end

return setInterval
