ClassPrototype = {}
ClassPrototype.__index = ClassPrototype

function ClassPrototype:new(o)
	local o = o or {}
	return setmetatable(o, ClassPrototype)
end

function ClassPrototype:get(property, value)
end

function ClassPrototype:set(property)
end

function ClassPrototype:destroy()
	self = nil
end

return ClassPrototype