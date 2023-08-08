local ClassPrototype = require("ClassPrototype")
local Adapter = ClassPrototype:new()
Adapter.__index = Adapter

function Adapter:new(ControllersList, ListParent)
    local o = ClassPrototype:new()
    o = setmetatable(o, self)
    o.__index = self
    return o
end

return Adapter