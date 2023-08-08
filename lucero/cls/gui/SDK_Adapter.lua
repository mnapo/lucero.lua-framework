local ClassPrototype = require("ClassPrototype")
local Adapter = ClassPrototype:new()
Adapter.__index = Adapter

local valid_SDK_names = _SDK_VALID_NAMES or {}

function Adapter:new(SDK_Bridge, ShapeFactory)
    local o = ClassPrototype:new()
    o:set("SDK_Bridge", SDK_Bridge):set("ShapeFactory", ShapeFactory)
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Adapter:set_SDK_Bridge(SDK_Bridge)
    if (isIn(valid_SDK_names, SDK_Bridge:get("selected_SDK"))) then
        self:set("SDK_Bridge", SDK_Bridge)
    end
end

function Adapter:set_ShapeFactory(ShapeFactory)
        self:set("ShapeFactory", ShapeFactory)
end

function Adapter:create_DisplayObject(type, options)
    local creators = self:get("SDK_Bridge"):get("creators")
    local creator = creators[type]
    return creator(options)
end

return Adapter