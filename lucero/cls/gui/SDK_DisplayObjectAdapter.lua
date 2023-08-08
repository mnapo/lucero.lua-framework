local ClassPrototype = require("cls.ClassPrototype")

Adapter = {}
Adapter.__index = Adapter

function Adapter:new(SDK, object_type)
	if (object_type == "rect") then
	end
	local o = o or {}
	return setmetatable(o, Adapter)
end

function Adapter:get(property, value)
end

function Adapter:set(property)
end

function Adapter:destroy()
	self = nil
end

return Adapter