--global configuration
_REQUIRED_CLASSES = {} --determines which classess are necessary
_DEBUG_MODE_ON = false --set to true to print command-line logs

--path setup
package.path = package.path..";./?.lua"

--base class loading
ClassPrototype = require("ClassPrototype")

--necessary classes loading

--debugging prints
if _DEBUG_MODE_ON then
    local tests = {
        [1] = {"package.path", package.path},
        [2] = {"ClassPrototype", ClassPrototype:debugging_log()}
    }
    for i = 1, #tests do
        print(tests[i][1].." set to "..tests[i][2].." ("..os.time()..")")
    end
end


