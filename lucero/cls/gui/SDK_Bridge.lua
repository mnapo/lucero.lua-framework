local ClassPrototype = require("ClassPrototype")
local Bridge = ClassPrototype:new()
Bridge.__index = Bridge

local valid_SDK_names = _SDK_VALID_NAMES or {}
local creators_by_SDK = {
    ["solar2D"] = {
		["rect"] = display.newRect,
		["circle"] = display.newCircle,
		["text"] = display.newText
	}
}

local function get_creators(selected_SDK)
    return creators_by_SDK[selected_SDK]
end

function Bridge:new(selected_SDK)
    local o = ClassPrototype:new()
    selected_SDK = selected_SDK or _SDK_NAME_DEFAULT or nil
    o:set("selected_SDK", selected_SDK):set("creators", get_creators(selectedSDK))
    o = setmetatable(o, self)
    o.__index = self
    return o
end

function Bridge:select_SDK(selected_SDK)
    if (isIn(valid_SDK_names, selected_SDK)) then
        self:set("selected_SDK", selected_SDK)
        self:set("creators", get_creators(selectedSDK))
    end
end

return Bridge