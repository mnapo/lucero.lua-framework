--[[ControllerPrototype is being used instead of Controller to test DOM_Formatter
    TO-DO:
    * remove ControllerPrototype
    * use Controller:
        - inherits Base
        - wraps visual elements and its data model
        - can emit and respond to events
        - can wrap an SDK's DisplayObject (as ShapeController) or other Controllers
        - might be formatted by a ControllersFormatter
        - ultimately it is indirectly rendered by SDK libraries
        ShapeFactory + SDK_DisplayObjectAdapter -> ShapeController -> CircleShape, RectShape, TextShape...
        ShapeController: adapts a Shape as a Controller
]]
local ClassPrototype = require("cls.ClassPrototype")
local DOM_Formatter = require("cls.gui.DOM_Formatter")

ControllerPrototype = {}
ControllerPrototype.__index = ControllerPrototype

local special_props = {
    "id",
    "children",
    "parent",
    "color"
}
local dimentional_props = {
    "x",
    "y",
    "width",
    "height",
    "margin_left",
    "margin_right",
    "margin_top",
    "margin_bottom"
}

function ControllerPrototype:new(id, props, parent)
    local o = ClassPrototype:new()
    local props = props or {x = 0, y = 0, width = display.actualContentWidth, height = display.actualContentHeight}
    o.__index = {}
    o.parent = parent
    o.id = id
    o.x = props.x
    o.y = props.y
    o.width = props.width
    o.height = props.height
    o.margin_left = props.margin_left or 0
    o.margin_right = props.margin_right or 0
    o.margin_top = props.margin_top or 0
    o.margin_bottom = props.margin_bottom or 0
    o.children = {}
    o.display_object = display.newRect(o.x, o.y, o.width, o.height)
    o.display_object.anchorX = 0
    o.display_object.anchorY = 0
    return setmetatable(o, self)
end

function ControllerPrototype:get(prop)
    if (isIn(special_props, prop)) then
        if (prop == "color") then
            return self.display_object["fill_color"]
        else --if (prop == "parent" or prop == "children" or prop == "margin_left" or prop == "margin_right" or prop == "margin_top" or prop == "margin_bottom") then
            return self[prop]
        end
    end
    if (isIn(dimentional_props, prop)) then
            return self[prop]
    end
    return self.display_object[prop]
end

function ControllerPrototype:set(prop, value)
    if (isIn(special_props, prop)) then
        if (prop == "color") then
            if (type(value) == "number") then
                self.display_object:setFillColor(value)
            else
                self.display_object:setFillColor(unpack(value))
            end
        else
            self[prop] = value
            --positional 
        end
    elseif (isIn(dimentional_props, prop)) then
        --since dimentional_props updating causes siblings update cascade, we check whether property value is new, to avoid an infinite loop
        if (self[prop] ~= value) then
            self[prop] = value
            if (prop == "x" or prop == "y" or prop == "width" or prop == "height") then
                self.display_object[prop] = value
            end
            if (self.parent) then
                print("Se afectó una variable dimensional de "..self.id.."(padre: "..self.parent.id.."). Se ajustan los hijos del padre:")
                local ParentFormatter = DOM_Formatter:new(self.parent.children, self.parent)
                ParentFormatter:format()
            end
        end
    else
        self.display_object[prop] = value
    end
end

function ControllerPrototype:append(Child)
    table.insert(self.children, Child)
    self.children[#self.children]:set("parent", self)
    local ChildrenFormatter = DOM_Formatter:new(self.children, self)
    ChildrenFormatter:format()
end

function ControllerPrototype:remove(child_index)
    self.children[child_index]:set("parent", nil)
    table.remove(self.children, child_index)
    local ChildrenFormatter = DOM_Formatter:new(self.children, self)
    ChildrenFormatter:format()
end

return ControllerPrototype