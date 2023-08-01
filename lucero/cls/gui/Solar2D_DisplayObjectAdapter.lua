local SDK_Adapter = require("cls.gui.SDK_DisplayObjectAdapter")

Solar2D_Adapter = {}
Solar2D_Adapter.__index = Solar2D_Adapter

function Solar2D_Adapter:new(o)
	local o = SDK_Adapter:new()
	return o
end

function Solar2D_Adapter:get(property, value)
end

function Solar2D_Adapter:set(property)
end

function Solar2D_Adapter:destroy()
	self = nil
end

return Solar2D_Adapter