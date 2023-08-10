--[[TO-DO: provide definitions for SDK coupling
    local composer = require("composer")
    display will be initialized here, meanwhile
]]
local display = {["newRect"]="new_rect function", ["newCircle"]="new_circle function", ["newText"]="new_text function"}
local ClassPrototype = require("ClassPrototype")
local Bridge = ClassPrototype:new()
Bridge.__index = Bridge

local valid_SDK_names = _SDK_VALID_NAMES or {}
local creators_by_SDK = {
    ["solar2D"] = {
		["rect"] = display.newRect,
		["circle"] = display.newCircle,
		["text"] = display.newText
	},
    ["react"] = {
        ["rect"] = newDiv,
		["circle"] = newCircle,
		["text"] = newText
    }
}

local function get_creators(selected_SDK)
    return creators_by_SDK[selected_SDK]
end

function Bridge:new(selected_SDK)
    local o = ClassPrototype:new()
    selected_SDK = selected_SDK or _SDK_NAME_DEFAULT or nil
    o:set("selected_SDK", selected_SDK):set("creators", get_creators(selected_SDK))
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Bridge:select_SDK(selected_SDK)
    local test = "invalid SDK" --TO-DO: remove after testing
    if (is_in(valid_SDK_names, selected_SDK)) then
        self:set("selected_SDK", selected_SDK)
        self:set("creators", get_creators(selected_SDK))
        test = "selected "..selected_SDK --test, remove
    end
    return test --test, remove
end

return Bridge