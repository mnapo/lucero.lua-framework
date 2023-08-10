local Controller = require("Controller")
local ControllersFormatter = require("ControllersFormatter")
local StyledController = Controller:new()
Controller.__index = Controller

function StyledController:new(id, props, parent, children, presentation, style)
    local o = Controller:new(id, props, parent, children, presentation)
    o:set("style", style)
    o = setmetatable(o, self)
    o.__index = self
    return o
end

local function rules_to_presentation(rules, parser)
    return parser.parse_rules(rules)
end

function StyledController:set_presentation(new_presentation)
    self.presentation = new_presentation
    return self
end

function StyledController:set_style(rules)
    local presentation = rules_to_presentation(rules, _LUA_TAG_STYLE)
    self:set_presentation(presentation)
    return self
end

return StyledController