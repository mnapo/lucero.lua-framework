local ClassPrototype = require("ClassPrototype")
local Controller = require("Controller")
local Factory = ClassPrototype:new()
Factory.__index = Factory

local function autoset_id()
    --[TO-DO] Strategy
    return "undefined"
end

function Factory:new(selected_SDK)
    local o = ClassPrototype:new()
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Factory:create(id, presentation_type, options, parent)
    id = id or autoset:id()
    local o = _SDK_SELECTED:create_Presentation(presentation_type, options)
    return Controller:new(id, options, parent):set("display_object", display_object)
end

return Factory