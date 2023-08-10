local ClassPrototype = require("ClassPrototype")
local Formatter = ClassPrototype:new()
Formatter.__index = Formatter

function Formatter:new(ControllersList, ListParent)
    _CONTROLLERS_FORMATTER = self
    local o = ClassPrototype:new()
    o = setmetatable(o, self)
    o.__index = self
    o:set("parent", ListParent):set("controllers", ControllersList)
    return o
end

function Formatter:format()
    return "hi"
end

return Formatter