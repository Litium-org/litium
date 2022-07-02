versionCheck = {}

stringx = require 'pl/stringx'

function versionCheck.doCheck(version1, version2)
    -- get the engine vcurrent version lol
    eg_major, eg_minor, eg_patch = string.match(version1, "(%d+)%.(%d+)%.(%d+)")

    -- get internet version
    sv_major, sv_minor, sv_patch = string.match(version2, "(%d+)%.(%d+)%.(%d+)")

    -- check em up XD
    if engineVersion[1] > serverCurrentVersion[1] then
        if engineVersion[2] > serverCurrentVersion[2] then
            if engineVersion[3] > serverCurrentVersion[3] then
                return true
            else
                return false
            end
        end
    end
    return false
end

return versionCheck