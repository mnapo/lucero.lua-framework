ShapeFactory = {}
ShapeFactory.__index = ShapeFactory

function ShapeFactory:new(o)
	local o = o or {}
	return setmetatable(o, ShapeFactory)
end

function ShapeFactory:get(property, value)
end

function ShapeFactory:set(property)
end

function ShapeFactory:destroy()
	self = nil
end

return ShapeFactory