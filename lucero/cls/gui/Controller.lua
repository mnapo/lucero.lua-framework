local ClassPrototype = require("cls.ClassPrototype")
local ControllersFormatter = require("cls.gui.ControllersFormatter")

Controller = {}
Controller.__index = Controller

funcController:new(id, props, parent, children)
    local o = ClassPrototype:new()
    local props = props or {x = 0, y = 0}
    id = id or autoset_id()
    parent = parent or {}
    children = children or {}

	o:set("id", id)
    :set("parent", parent)
    :set("children", children)

	o.display_object["anchorX"] = 0
	o.display_object["anchorY"] = 0

    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Controller:append(Child)
    table.insert(self.children, Child)
    self.children[#self.children]:set("parent", self)
    local ChildrenFormatter = ControllersFormatter:new(self.children, self)
    ChildrenFormatter:format()
end

function Controller:remove(child_index)
    self.children[child_index]:set("parent", nil)
    table.remove(self.children, child_index)
    local ChildrenFormatter = ControllersFormatter:new(self.children, self)
    ChildrenFormatter:format()
end

return Controller