litplugin = {}

pluginmanager = require 'src/native/engine/plugin/pluginmngr'   

function litplugin.call(func)
    pluginmanager.kall(func)
end

return litplugin