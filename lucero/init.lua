--global configuration
_LIB_NAME = "lucero"
_DIR_CLASSES = "./".._LIB_NAME.."/cls"
_DIR_GUI = "./".._LIB_NAME.."/cls/gui"
_REQUIRED_CLASSES = {"DOM_Formatter"} --determines which classess are necessary
_DEBUG_MODE_ON = true --set to true to print command-line logs
_SDK_NAME_DEFAULT = "solar2D"
_VALID_SDK_NAMES = {"solar2D", "react", "defold", "custom"}

--path setup
package.path = package.path..";".._DIR_CLASSES.."/?.lua;".._DIR_GUI.."/?.lua"

--base class loading
ClassPrototype = require("ClassPrototype")

--helpers/global use functions
function isIn(t, v)
    for i = 1, #t do
        if (t[i] == v) then
            return true
        end
    end
    return false
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
    --print tests
    for i = 1, #tests do
        tests[i][2] = tostring(tests[i][2]) or "none (error)"
        test_print(tests[i][1], tests[i][2])
    end
    --while true do end --keeps cmd opened
end