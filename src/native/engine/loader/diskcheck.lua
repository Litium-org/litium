diskcheck = {}

utils = require 'src/native/engine/resources/utils'

insert = table.insert

function diskcheck.init()
    --diskspath = "disk"
    
    if utils.exist("directory", "disk") then
        disks = love.filesystem.getDirectoryItems("disk")

        if disks == 0 then
            return false
        else  
            return disks
        end
    end
end

function diskcheck.plugins()
    Plugins = {}
    if utils.exist("directory", "plugins") then
        items = love.filesystem.getDirectoryItems("plugins")
        for folderItem = 1, #items do
            if love.filesystem.isFile("plugins/" .. items[folderItem]) then
                insert(Plugins, items[folderItem])
            end
        end
        return Plugins
    end
end

return diskcheck