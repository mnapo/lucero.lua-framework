local ClassPrototype = {}
ClassPrototype.__index = ClassPrototype

function ClassPrototype:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function ClassPrototype:get(member)
	return self.member
end

function ClassPrototype:set(member, value)
	member = member or "none"
	value = value or "none"
	if (_DEBUG_MODE_ON) then
		local self_ref = tostring(self)
		print(self_ref.."'s "..member.." set to "..value)
	end
	self.member = value
	return self --allows chained calls
end

function ClassPrototype:destroy()
	self = nil
end

function ClassPrototype:debugging_log()
	return self
end

return ClassPrototype