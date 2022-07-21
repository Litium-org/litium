pluginmnger = {}

settings = require 'src/native/engine/core/file_reader'
diskcheck = require 'src/native/engine/loader/diskcheck'

function pluginmnger.loadPlugins()
    pluginList = diskcheck.plugins()
    plugins = settings.getvalue("engine.lua", "bios_enablePlugins")
    if plugins then
        for i = 1, #pluginList do
            
        end
    end
end


----------------------------------------------------------------
--[[                       Functions                        ]]--
----------------------------------------------------------------

function pluginmnger.kall(mod, func)
    pcall(mod, func)
end

return pluginmnger