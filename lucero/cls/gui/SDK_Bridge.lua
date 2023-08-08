local ClassPrototype = require("ClassPrototype")
local Bridge = ClassPrototype:new()
Bridge.__index = Bridge

function Bridge:new(ControllersList, ListParent)
    local o = ClassPrototype:new()
    o = setmetatable(o, self)
    o.__index = self
    return o
end

return Bridge