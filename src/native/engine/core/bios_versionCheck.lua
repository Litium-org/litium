versionCheck = {}

stringx = require 'pl/stringx'

function versionCheck.doCheck(version1, version2)
    -- get the engine vcurrent version lol
    _version1 = stringx.split(version1, ".")
    -- get internet version
    _version2 = stringx.split(version2, ".")

    _Version1Major = _version1[1]
    _Version1Minor = _version1[2]
    _Version1Patch = _version1[3]

    _Version2Major = _version2[1]
    _Version2Minor = _version2[2]
    _Version2Patch = _version2[3]


    if _Version1Major ~= _Version2Major then
        print(_Version1Major, _Version2Major)
        return false
    else
        if _Version1Minor ~= _Version2Minor then
            print(_Version1Minor, _Version2Minor)
            return false
        else
            if _Version1Patch ~= _Version2Patch then
                print(_Version1Patch, _Version2Patch)
            else
                return false
            end
        end
    end
    return true
end

function versionCheck.ignored()
    file = love.filesystem.newFile(".litignored")
    file:open("w")
    file:write("true")
    file:close()
end

return versionCheck