local Cleaner = {}
Cleaner.__index = Cleaner

function Cleaner.new()
	return setmetatable({
		_connections = {},
		_threads = {},
		_tweens = {},
		_cancels = {},
		_animations = {},
	}, Cleaner)
end

function Cleaner:add(x)
	if x == nil then return nil end
	local t = typeof(x)
	if t == "RBXScriptConnection" then
		self._connections[#self._connections + 1] = x
	elseif t == "thread" then
		self._threads[#self._threads + 1] = x
	elseif t == "Instance" then
		if x.ClassName == "Tween" then
			self._tweens[#self._tweens + 1] = x
		elseif x.ClassName == "AnimationTrack" then
			self._animations[#self._animations + 1] = x
		end
	elseif type(x) == "function" then
		self._cancels[#self._cancels + 1] = x
	end
	return x
end

function Cleaner:clean()
	-- connections
	for i = #self._connections, 1, -1 do
		local c = self._connections[i]
		pcall(function()
			c:Disconnect()
		end)
		self._connections[i] = nil
	end
	-- tweens
	for i = #self._tweens, 1, -1 do
		local tw = self._tweens[i]
		pcall(function()
			tw:Cancel()
		end)
		self._tweens[i] = nil
	end
	-- threads
	for i = #self._threads, 1, -1 do
		local th = self._threads[i]
		pcall(function()
			task.cancel(th)
		end)
		self._threads[i] = nil
	end
	-- cancel functions (e.g., SetInterval’s cancel)
	for i = #self._cancels, 1, -1 do
		pcall(self._cancels[i])
		self._cancels[i] = nil
	end
	-- Animation Tracks
	for i = #self._animations, 1, -1 do
		local at = self._animations[i]
		pcall(function()
			at:Stop()
		end)
		self._animations[i] = nil
	end
end

return Cleaner
