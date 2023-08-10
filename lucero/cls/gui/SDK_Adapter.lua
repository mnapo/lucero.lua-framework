local ClassPrototype = require("ClassPrototype")
local Adapter = ClassPrototype:new()
Adapter.__index = Adapter

local valid_SDK_names = _SDK_VALID_NAMES or {}

function Adapter:new(SDK_Bridge)
    _SDK_SELECTED = self
    local o = ClassPrototype:new()
    o:set("SDK_Bridge", SDK_Bridge)
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Adapter:set_SDK_Bridge(SDK_Bridge)
    local test = "invalid SDK"--TO-DO: remove after testing
    print(tostring(SDK_Bridge))
    if (is_in(valid_SDK_names, SDK_Bridge:get("selected_SDK"))) then
        self:set("SDK_Bridge", SDK_Bridge)
        test = "SDK_Bridge set to "..tostring(SDK_Bridge)--test, remove
    end
    return test --remove
end

function Adapter:create_Presentation(object_type, options)
    local o = {
        ["object_type"] = object_type,
        table.unpack(options)
    }
    table.unpack(options)}
    return o
end

function Adapter:create_DisplayObject(object_type, options)
    local creators = self:get("SDK_Bridge"):get("creators")
    local creator = creators[object_type]
    return creator(options)
end

return Adapter