local ClassPrototype = require("cls.ClassPrototype")

Formatter = {}
Formatter.__index = Formatter

function Formatter:new(ControllersList, ListParent)
    local o = ClassPrototype:new(ControllersList, ListParent)
    o:set("controllers", ControllersList)
    o:set("parent", ListParent)
    return o
end

function Formatter:format()