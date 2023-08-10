local ClassPrototype = require("ClassPrototype")
local Controller = require("Controller")
local StyledController = require("StyledController")
local Factory = ClassPrototype:new()
Factory.__index = Factory

local _CONTROLLERS_FACTORY = Factory

function Factory:new(selected_SDK)
    local o = ClassPrototype:new()
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Factory:create(id, presentation_type, options, parent, children, presentation, style)
    id = id or autoset:id()
    local presentation = _SDK_SELECTED:create_Presentation(presentation_type, options)
    if style then
        return StyledController:new(id, options, parent, children, style)
                                :set("presentation", presentation)
    else
        return Controller:new(id, options, parent, children)
                                :set("presentation", presentation)
    end
end

return Factory