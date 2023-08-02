--global configuration
_LIB_NAME = "lucero"
_DIR_CLASSES = "./".._LIB_NAME.."/cls"
_DIR_GUI = "./".._LIB_NAME.."/cls/gui"
_REQUIRED_CLASSES = {"ControllersFormatter"} --determines which classess are necessary
_DEBUG_MODE_ON = true --set to true to print command-line logs

--path setup
package.path = package.path..";".._DIR_CLASSES.."/?.lua;".._DIR_GUI.."/?.lua"

--base class loading
ClassPrototype = require("ClassPrototype")

--necessary classes loading
for i = 1, #_REQUIRED_CLASSES do
    local name = _REQUIRED_CLASSES[i]
    _REQUIRED_CLASSES[i] = {name, require(name):new()}
end

--debugging prints
if _DEBUG_MODE_ON then
    --helper function for tests printing
    local test_print = function(name, result)
        print(name.." set to "..result.." ("..os.time()..")")
    end
    --define basic tests
    local tests = {
        [1] = {"package.path", package.path},
        [2] = {"ClassPrototype", ClassPrototype:debugging_log()}
    }
    --add tests for necessary classes
    for i = 1, #_REQUIRED_CLASSES do
        tests[#tests+1] = _REQUIRED_CLASSES[i]
    end
    --run tests
    for i = 1, #tests do
        tests[i][2] = tostring(tests[i][2]) or "none (error)"
        test_print(tests[i][1], tests[i][2])
    end
    --while true do end --keeps cmd opened
end

