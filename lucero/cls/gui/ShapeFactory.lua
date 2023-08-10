local ControllersFactory = require("ControllersFactory")
local ShapeController = require("Shape")
local StyledShapeController = require("StyledShape")
local Factory = ControllersFactory:new()
Factory.__index = Factory

function Factory:new(selected_SDK)
    local o = ControllersFactory:new()
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Factory:create(id, object_type, options, parent, style)
    id = id or autoset:id()
    local display_object = _SDK_SELECTED:create_DisplayObject(object_type, options)
    if style then
        return StyledShape:new(id, options, parent):set("display_object", display_object)
    else
        return Shape:new(id, options, parent, style):set("display_object", display_object)
    end
end

return Factory