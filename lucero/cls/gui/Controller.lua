Controller = {}
Controller.__index = Controller

function Controller:new(o)
	local o = o or {}
	return setmetatable(o, Controller)
end

function Controller:get(property, value)
end

function Controller:set(property)
end

function Controller:destroy()
	self = nil
end

return Controller