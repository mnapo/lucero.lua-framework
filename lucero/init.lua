--global configuration
_LIB_NAME = "lucero"

_DIR_CLASSES = "./".._LIB_NAME.."/cls"
_DIR_GUI = "./".._LIB_NAME.."/cls/gui"

_REQUIRED_CLASSES = {"DOM_Formatter", "SDK_Bridge", "SDK_Adapter"} --determines which classess are necessary

_DEBUG_MODE_ON = true --set to true to print command-line logs

_SDK_VALID_NAMES = {"solar2D", "react", "defold", "custom"}
_SDK_NAME_DEFAULT = "solar2D"

_SHAPES_VALID = {"rect", "circle", "text", "label", "line", "polygon", "particle-system"}
--[TO-DO] complete list _SHAPES_MODIFICATIONS_VALID = {"corners", "background-color", "position"}

_SDK_SELECTED = _SDK_NAME_DEFAULT
_CONTROLLERS_FORMATTER = nil

_MEMBERS_SPECIAL = {
    "id",
    "children",
    "parent",
    "color"
}
_MEMBERS_DIMENTIONAL = {
    "x",
    "y",
    "width",
    "height",
    "margin_left",
    "margin_right",
    "margin_top",
    "margin_bottom"
}

--path setup
package.path = package.path..";".._DIR_CLASSES.."/?.lua;".._DIR_GUI.."/?.lua"

--base class loading
ClassPrototype = require("ClassPrototype")

--helpers/global use functions
function print_table(t)
    print(tostring(t).."'s values:")
    for i = 1, #t do
        print(i..") "..tostring(t[i]))
    end
    for k, v in pairs(t) do
        print(tostring(k)..") "..tostring(v))
    end
end

function is_in(t, v)
    for i = 1, #t do
        if (t[i] == v) then
            return true
        end
    end
    return false
end

function autoset_id()
    --[TO-DO] Strategy
    return "undefined"
end

--necessary classes loading
for i = 1, #_REQUIRED_CLASSES do
    local name = _REQUIRED_CLASSES[i]
    local dummy = require(name):new()
    _REQUIRED_CLASSES[i] = {name, dummy}
end

--debugging prints
if _DEBUG_MODE_ON then
    --helper function for tests printing
    local test_print = function(name, result)
        print(name.."'s test | result: "..result.." ("..os.time()..")")
    end
    --define basic tests
    local tests = {
        [1] = {"package.path", package.path},
        [2] = {"ClassPrototype", ClassPrototype:debugging_log()}
    }
    --add tests for necessary classes
    for i = 1, #_REQUIRED_CLASSES do
        local test = _REQUIRED_CLASSES[i][2]
        if not (test == nil) then
            local result = _REQUIRED_CLASSES[i][2]:debugging_log()
            tests[#tests+1] = {_REQUIRED_CLASSES[i][1], result}
        end
    end
    --additional tests
    tests[#tests+1] = {_REQUIRED_CLASSES[1][1], _REQUIRED_CLASSES[1][2]:format()}
    tests[#tests+1] = {_REQUIRED_CLASSES[2][1], _REQUIRED_CLASSES[2][2]:select_SDK("solar2D")}
    tests[#tests+1] = {_REQUIRED_CLASSES[2][1], _REQUIRED_CLASSES[2][2]:get("creators")["circle"]}
    tests[#tests+1] = {_REQUIRED_CLASSES[3][1], _REQUIRED_CLASSES[3][2]:set_SDK_Bridge(_REQUIRED_CLASSES[2][2])}
    
    --print tests
    for i = 1, #tests do
        tests[i][2] = tostring(tests[i][2]) or "none (error)"
        test_print(tests[i][1], tests[i][2])
    end
    --while true do end --keeps cmd opened
end