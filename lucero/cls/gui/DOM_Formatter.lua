local Formatter = require("ControllersFormatter")
local DOM_Formatter = Formatter:new()
DOM_Formatter.__index = DOM_Formatter

function DOM_Formatter:new(ControllersList, ListParent)
    local o = Formatter:new(ControllersList, ListParent)
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function DOM_Formatter:format()
    local parent_id = ""
    local ini_x = 0
    local ini_y = 0
    local max_width = 0
    local max_height = 0
    if (self.parent) then
        parent_id = self.parent:get("id")
        ini_x = self.parent:get("x")
        ini_y = self.parent:get("y")
        max_width = self.parent:get("width")
        max_height = self.parent:get("height")
    end
    local last_leaf_right = ini_x
    local last_leaf_bottom = ini_y
    local max_leaf_height = 0
    for i = 1, #self.controllers do
        local Leaf = self.controllers[i]
        leaf_id = Leaf:get("id")
        print("Leaf inspection: "..leaf_id)
        local leaf_x = last_leaf_right
        local leaf_y = last_leaf_bottom
        local leaf_width = Leaf:get("width")
        local leaf_height = Leaf:get("height")
        local leaf_margin_left = Leaf:get("margin_left")
        local leaf_margin_right = Leaf:get("margin_right")
        local leaf_margin_top = Leaf:get("margin_top")
        local leaf_margin_bottom = Leaf:get("margin_bottom")
        local LeafChildren = Leaf:get("children")
        local LeafChildrenFormatter = DOM_Formatter:new(LeafChildren, Leaf)
        if (leaf_height + leaf_margin_bottom > max_leaf_height) then
            max_leaf_height = leaf_height + leaf_margin_bottom
        end
        if (leaf_x + leaf_width + leaf_margin_left + leaf_margin_right > ini_x + max_width) then
            leaf_x = ini_x
            last_leaf_bottom = last_leaf_bottom + max_leaf_height
            leaf_y = last_leaf_bottom
        end
        leaf_x = leaf_x + leaf_margin_left
        leaf_y = leaf_y + leaf_margin_top
        last_leaf_right = leaf_x + leaf_width + leaf_margin_right
        Leaf:set("x", leaf_x)
        Leaf:set("y", leaf_y)
        LeafChildrenFormatter:format()
    end
    return "test"
end

return DOM_Formatter