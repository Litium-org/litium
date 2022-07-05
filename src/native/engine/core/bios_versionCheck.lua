versionCheck = {}

stringx = require 'pl/stringx'

function versionCheck.doCheck(version1, version2)
    -- get the engine vcurrent version lol
    _version1 = stringx.split(version1, ".")
    -- get internet version
    _version2 = stringx.split(version2, ".")


    if _version1[1] ~= _version2[1] then
        return true
    else
        if _version1[2] ~= _version2[2] then
            return true
        else
            if _version1[3] ~= _version2[3] then
                 return true
            end
        end
        return false
    end

    -- check em up XD

end

function versionCheck.ignored()
    file = love.filesystem.newFile(".litignored")
    file:open("w")
    file:write("true")
    file:close()
end

return versionCheck