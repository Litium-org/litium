pluginmnger = {}

settings = require 'src/native/engine/core/file_reader'

function pluginmnger.loadPlugins()
    plugins = settings.getvalue(".litplugins", "plugins")
    if plugins ~= nil or plugins ~= {} then
        for pluginName, value in pairs(plugins) do
            if value == true then
                plugincode, err = love.filesystem.load("plugins/" .. pluginName .. "/plugin.lua")
                pcall(plugincode(), onLoad())
            end
        end
    else
        print("no plugins installed yet...")
    end
end

function pluginmnger.renderContent()
    plugins = settings.getvalue(".litplugins", "plugins")
    if plugins ~= nil or plugins ~= {} then
        for pluginName, value in pairs(plugins) do
            if value == true then
                plugincode, err = love.filesystem.load("plugins/" .. pluginName .. "/plugin.lua")
                pcall(plugincode(), toRender())
            end
        end
    else
        print("no plugins installed yet...")
    end
end

function pluginmnger.updatePlugins(dt)
    plugins = settings.getvalue(".litplugins", "plugins")
    if plugins ~= nil or plugins ~= {} then
        for pluginName, value in pairs(plugins) do
            if value == true then
                plugincode, err = love.filesystem.load("plugins/" .. pluginName .. "/plugin.lua")
                pcall(plugincode(), onUpdate(dt))
            end
        end
    else
        print("no plugins installed yet...")
    end
end

function pluginmnger.listenForKeyDown(k)
    plugins = settings.getvalue(".litplugins", "plugins")
    if plugins ~= nil or plugins ~= {} then
        for pluginName, value in pairs(plugins) do
            if value == true then
                plugincode, err = love.filesystem.load("plugins/" .. pluginName .. "/plugin.lua")
                pcall(plugincode(), onKeyDown(k))
            end
        end
    else
        print("no plugins installed yet...")
    end
end

function pluginmnger.listenForKeyUp(dt)
    plugins = settings.getvalue(".litplugins", "plugins")
    if plugins ~= nil or plugins ~= {} then
        for pluginName, value in pairs(plugins) do
            if value == true then
                plugincode, err = love.filesystem.load("plugins/" .. pluginName .. "/plugin.lua")
                pcall(plugincode(), onKeyUp(k))
            end
        end
    else
        print("no plugins installed yet...")
    end
end

----------------------------------------------------------------
--[[                       Functions                        ]]--
----------------------------------------------------------------


return pluginmnger