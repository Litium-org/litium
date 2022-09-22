love.setDeprecationOutput(false)
function love.load()
    nativelocks         = require 'src/native/engine/core/nativelocks'
    imageloader         = require 'src/native/engine/loader/imageloader'
    save                = require 'src/native/engine/core/save_handler'
    pluginmanager       = require 'src/native/engine/plugin/pluginmngr'
    language            = require 'src/native/engine/resources/language'
    utils               = require 'src/native/engine/resources/utils'
    request             = require 'src/native/engine/core/request'
    version             = require 'src/thirdparty/version'
    utils               = require 'src/native/engine/resources/utils'
    settings            = require 'src/native/engine/core/file_reader'
    versionCheck        = require 'src/native/engine/core/bios_versionCheck'

    btnPressedCount = 0
    love.keyboard.setKeyRepeat(true)

    -- engine version system
    engineVersion = "0.0.4"
    serverEngineVersion = ""
    function requestFunction()
        code, serverEngineVersion = request.newRequest("https://raw.githubusercontent.com/Litium-org/litium/master/.litversion")
    end
    if pcall(requestFunction) then
        print(serverEngineVersion)
    else
        serverEngineVersion = engineVersion
    end

    nativelocks.lock()


    --=[: API Stuff :]=--
    litgraphics         =       require 'API/sprite/litgraphics'
    litsound            =       require 'API/sound/litsound'
    litgame             =       require 'API/game/litgame'
    litsystem           =       require 'API/system/litsystem'
	litinput			=		require 'API/input/litinput'
    litfilesystem       =       require 'API/filesystem/litfilesystem'
    litwindow           =       require 'API/window/litwindow'
    litsave             =       require 'API/savesystem/litsave'
    switch              =       require 'src/native/sources/switch'

    initLogoTimer = 0

    imageloader.init()
    imagedata = imageloader.getImage()

    theValue = versionCheck.doCheck(engineVersion, serverEngineVersion)
    print(theValue)



    if theValue then
        if imageloader.getCurrentImageName() ~= "-warnoutdate" then
            if not utils.exist("file", ".litignored") then
                imageloader.changeImageName("-warnoutdate")
                versionCheck.ignored()
                litgame.restart()
            end
        end
    end

    pcall(imagedata(), start())
    pluginmanager.loadPlugins()
end

function love.draw()
    litgraphics.clearScreen()
    pcall(imagedata(), render())
end

function love.update(dt)
    pcall(imagedata(), update(dt))
end

function love.keypressed(k, scancode, isRepeat)
    pcall(imagedata(), keydown(k, scancode))

    -- callback if specific keys pressed
    if k == "home" then
        if isRepeat then
            print(btnPressedCount)
            btnPressedCount = btnPressedCount + 1
            if btnPressedCount > 20 then
                imageloader.changeImageName("-native")
                litgame.restart()
            end
        end
    end
    if k == "end" then
        if isRepeat then
            btnPressedCount = btnPressedCount + 1
            if btnPressedCount > 20 then
                litgame.quit()
            end
        end
    end
    if k == "v" then
        if isRepeat then
            btnPressedCount = btnPressedCount + 1
            if btnPressedCount > 20 then
                imageloader.changeImageName("-verbose")
                litgame.restart()
            end
        end
    end
end
