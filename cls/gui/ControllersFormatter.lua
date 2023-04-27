--class ControllersFormatter inherits Base
--TODO: positioning, stretching, line-breaking, scaling, styling, default_props, default_parent

--[[ControllersFormatter:new(ControllersList, ListParent){
    self.controllers = ControllersList
    self.parent = ListParent or screen
}
ControllersFormatters:setList(ControllersList){
    self.controllers = ControllersList
}
ControllersFormatter:format(){
    for each leaf in self.controllers{
        print leaf
    }
}


ControllersFormatter:format(){
    ini_x = self.parent:get("x")
    ini_y = self.parent:get("y")
    max_width = self.parent:get("width")
    max_height = self.parent:get("height")
    last_leaf_right = ini_x
    last_leaf_bottom = ini_y
    max_leaf_height = 0
    for each leaf in self.controllers{
        leaf_x = last_leaf_right
        leaf_y = last_leaf_bottom
        leaf_width = leaf:get("width")
        leaf_height = leaf:get("height")
        leaf_margin_left = leaf:get("margin_left")
        leaf_margin_top = leaf:get("margin_top")
        leaf_margin_bottom = leaf:get("margin_bottom")
        if (leaf_height + leaf_margin_top > max_leaf_height){
            max_leaf_height = leaf_height + leaf_margin_bottom
        }
        if (leaf_x + leaf_width + leaf_margin_left > ini_x + max_width){
            leaf_x = ini_x
            last_leaf_bottom = last_leaf_bottom + max_leaf_height
            leaf_y = last_leaf_bottom
        }
        leaf_y = leaf_y + leaf_margin_top
        leaf_x = leaf_x + leaf_margin_left
        last_leaf_right = leaf_x + leaf_width
        leaf:set("x", leaf_x)
        leaf:set("y", leaf_y)
        LeafChildrenFormatter = DOM_Formatter:new({leaf.children}, leaf)
        LeafChildrenFormatter:format()
    }
}]]