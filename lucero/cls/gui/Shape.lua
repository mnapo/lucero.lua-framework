local Controller = require("Controller")
local ControllersFormatter = require("ControllersFormatter")

ShapeController = {}
ShapeController.__index = ShapeController

function ShapeController:new(id, props, parent, children)
    local o = Controller:new()
    local props = props or {x = 0, y = 0, width = display.actualContentWidth, height = display.actualContentHeight}
    id = id or autoset_id()
    parent = props["parent"] or {}
    children = props["children"] or {}

	o:set(display_object, props["display_object"])
    :set("id", id)
    :set("parent", parent)
    :set("children", children)
    :set("x", props["x"])
    :set("y", props["y"])
    :set("width", props["width"])
    :set("height", props["height"])
    :set("margin_left", props["margin_left"])
	:set("margin_right", props["margin_right"])
	:set("margin_top", props["margin_top"])
	:set("margin_bottom", props["margin_bottom"])

	o.display_object["anchorX"] = 0
	o.display_object["anchorY"] = 0

    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Controller:get(prop)
    if (is_in(_MEMBERS_SPECIAL, prop)) then
        if (prop == "color") then
            return self.display_object["fill_color"]
        else --if (prop == "parent" or prop == "children" or prop == "margin_left" or prop == "margin_right" or prop == "margin_top" or prop == "margin_bottom") then
            return self[prop]
        end
    end
    if (is_in(_MEMBERS_DIMENTIONAL, prop)) then
            return self[prop]
    end
    return self.display_object[prop]
end

function Controller:set(prop, value)
    if (is_in(_MEMBERS_SPECIAL, prop)) then
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
    elseif (is_in(_MEMBERS_DIMENTIONAL, prop)) then
        --since _MEMBERS_DIMENTIONAL updating causes siblings update cascade, we check whether property value is new, to avoid an infinite loop
        if (self[prop] ~= value) then
            self[prop] = value
            if (prop == "x" or prop == "y" or prop == "width" or prop == "height") then
                self.display_object[prop] = value
            end
            if (self.parent) then
                print("Se afectó una variable dimensional de "..self.id.."(padre: "..self.parent.id.."). Se ajustan los hijos del padre:")
                local ParentFormatter = ControllersFormatter:new(self.parent.children, self.parent)
                ParentFormatter:format()
            end
        end
    else
        self.display_object[prop] = value
    end
end

function ShapeController:append(Child)
    table.insert(self.children, Child)
    self.children[#self.children]:set("parent", self)
    local ChildrenFormatter = ControllersFormatter:new(self.children, self)
    ChildrenFormatter:format()
end

function ShapeController:remove(child_index)
    self.children[child_index]:set("parent", nil)
    table.remove(self.children, child_index)
    local ChildrenFormatter = ControllersFormatter:new(self.children, self)
    ChildrenFormatter:format()
end

return ShapeController