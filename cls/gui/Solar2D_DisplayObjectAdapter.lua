Solar2D_Adapter = {}
Solar2D_Adapter.__index = Solar2D_Adapter

function Solar2D_Adapter:new(o)
	local o = o or {}
	return setmetatable(o, Solar2D_Adapter)
end

function Solar2D_Adapter:get(property, value)
end

function Solar2D_Adapter:set(property)
end

function Solar2D_Adapter:destroy()
	self = nil
end

return Solar2D_Adapter