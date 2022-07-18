function start()

    state = "loader"
    Ymax = 0

    selection = 1

    noDisks = false
    noPlugins = false
    isPluginPageEnable = false
    biosSplashTimer = 0

scriptContent = [[
function start()
    -- everything here will run only on startup --
end

function render()
    -- will render objects on screen every frame --
end

function update(dt)
    -- will update every frame --
end

function keydown(k)
    -- called when key is down --
end

function keyup(k)
    -- called when key is up --
end
]]

    settings = require 'src/native/engine/core/file_reader'
    diskcheck = require 'src/native/engine/loader/diskcheck'
    lang = settings.getvalue("engine.lua", "bios_language")
    diskList = diskcheck.init()
    pluginsList = diskcheck.plugins()

    litsystem.setName("Litium [BETA] v0.4 - Ruby [NO GAME LOADED]")

    sprPallete = {
        {0,0,0,0},      -- transparent color
        {0,0,0},
        {10,10,10},
        {20,20,20},
        {30,30,30},
        {40,40,40},
        {50,50,50},
        {60,60,60},
        {70,70,70},
        {80,80,80},
        {90,90,90},
        {255,255,255}
    }

    heartPallete = {
        {0,0,0,0},
        {255,0,0},
        {255,255,255}
    }

    logo = {
        {2,2,2,2,2,2,2,2},
        {2,7,7,7,7,7,7,2},
        {2,6,6,12,6,6,6,2},
        {2,6,6,12,6,6,6,2},
        {2,6,6,12,6,6,6,2},
        {2,6,6,12,12,12,6,2},
        {2,5,5,5,5,5,5,2},
        {2,2,2,2,2,2,2,2},
    }

    Heart = {
        {1,1,1,1,1,1,1,1,1},
        {1,2,2,1,1,1,2,2,1},
        {2,2,2,2,1,2,3,2,2},
        {2,2,2,2,2,3,2,2,2},
        {2,2,2,2,2,2,2,2,2},
        {1,2,2,2,2,2,2,2,1},
        {1,1,2,2,2,2,2,1,1},
        {1,1,1,2,2,2,1,1,1},
        {1,1,1,1,2,1,1,1,1},
    }

    pluginPallete = {
        {0,0,0,0},
        {1,1,1},
        {255, 255, 255}
    }
    pluginIcon = {
        {1,3,1,1,1,3,1},
        {1,3,1,1,1,3,1},
        {3,3,3,3,3,3,3},
        {3,3,3,3,3,3,3},
        {1,3,3,3,3,3,1},
        {1,1,1,3,1,1,1},
        {1,1,1,3,1,1,1},
        {1,1,1,1,3,1,1},
        {1,1,1,1,3,1,1},
    }

    shine = {
        {
            {1,1,1},
            {1,3,1},
            {1,1,1}
        },
        {
            {1,3,1},
            {3,3,3},
            {1,3,1}
        },
        {
            {3,1,3},
            {1,3,1},
            {3,1,3}
        },
    }

    cursor = {
        {1,1,3,1,1},
        {1,1,1,3,1},
        {1,1,1,1,3},
        {1,1,1,3,1},
        {1,1,3,1,1}
    }

    cursorY = 200

    frame = 1
    txtFrame = 1
    Timer = 0
    
    litgraphics.loadPallete(sprPallete)
    heart = settings.getvalue("engine.lua", "bios_heart")
    isSplashActive = settings.getvalue("engine.lua", "bios_splash")

    -- version Check
    engineVer = settings.getvalue("engine.lua", "bios_version")
    code, serverEngineVersion = request.newRequest("https://raw.githubusercontent.com/Litium-org/litium/master/.litversion")

    isOutdated = versionCheck.doCheck(engineVer, serverEngineVersion)

    --print(diskList[1])
end

function render()
    if state == "loader" then
        if isSplashActive then
            if biosSplashTimer >= 120 then
                if not heart or heart == nil then
                    litgraphics.newSprite(logo, 16, 60, 60)
                else
                    litgraphics.newSprite(Heart, 16, 60, 60, heartPallete)
                end
            end
            if biosSplashTimer >= 70 then
                litgraphics.newText("Powered with litium", 70, 200, 5, 3, 1)
            end
        else
            state = "boot"
        end
    end
    
    if state == "boot" then
        litgraphics.rect(0, 0, 1280, 768, 3, "fill")
        litgraphics.rect(0, 0, 1280, 18, 23, "fill")
            
        if not heart or heart == nil then
            litgraphics.newSprite(logo, 16, 60, 60)
        else
            litgraphics.newSprite(Heart, 16, 60, 60, heartPallete)
        end

        -- custom blinking text
        if isOutdated then
            if txtFrame == 1 then
                litgraphics.newText(language[lang].noDisk.outdatedVersion, 0, 2, 2, 1, 1)
                litgraphics.newText(language[lang].noDisk.outdatedVersion, 0, 0, 2, 3, 1)
            end
            if txtFrame == 2 then
                litgraphics.newText(language[lang].noDisk.outdatedVersion, 0, 2, 2, 1, 1)
                litgraphics.newText(language[lang].noDisk.outdatedVersion, 0, 0, 2, 4, 1)
            end
        end
    
        litgraphics.newText(language[lang].noDisk.line1, 230, 306, 6, 1, 1)
        litgraphics.newText(language[lang].noDisk.line1, 230, 300, 6, 3, 1)
        litgraphics.newText(language[lang].noDisk.line2, 230, 394, 4, 1, 1)
        litgraphics.newText(language[lang].noDisk.line2, 230, 390, 4, 3, 1)
        litgraphics.newText(language[lang].noDisk.bootSelect, 10, 734, 3, 1, 1)
        litgraphics.newText(language[lang].noDisk.bootSelect, 10, 730, 3, 3, 1)
        litgraphics.newText(language[lang].noDisk.pluginSelect, 10, 704, 3, 1, 1)
        litgraphics.newText(language[lang].noDisk.pluginSelect, 10, 700, 3, 3, 1)
        litgraphics.newSprite(shine[frame], 8, 290, 190, heartPallete)
        litgraphics.newSprite(shine[frame], 8, 340, 70, heartPallete)
        litgraphics.newSprite(shine[frame], 8, 20, 50, heartPallete)
        litgraphics.newSprite(shine[frame], 8, 190, 40, heartPallete)
        litgraphics.newSprite(shine[frame], 8, 180, 290, heartPallete)
    end

    if state == "disks" then
        litgraphics.newText(language[lang].bootSelection.title, 10, 10, 5, 3, 1)
        litgraphics.newText(language[lang].bootSelection.description, 10, 80, 3, 3, 1)
        litgraphics.newText(language[lang].bootSelection.back, 10, 730, 3, 3, 1)
        if not noDisks then
            litgraphics.newSprite(cursor, 4, 10, cursorY, heartPallete)
        else
            litgraphics.newText(language[lang].bootSelection.noDisksInstalled, 10, 140, 4, 3, 1)
        end
        if #diskList ~= 0 then
            noDisks = false
            renderDiskList()
        else
            noDisks = true
        end
    end

    if isPluginPageEnable then
        litgraphics.rect(0, 0, 360, Ymax + 40, 2, "fill")
        litgraphics.newText(language[lang].pluginsList.title, 0, 10, 3, 3, 1)
        litgraphics.newSprite(pluginIcon, 3, 325 ,0, pluginPallete)
        if noPlugins then
            litgraphics.newText(language[lang].pluginsList.noPlugins, 10, 10, 3, 3, 1)
        end
        if #pluginsList ~= 0 then
            noPlugins = false
            renderPluginList()
        else
            print(#pluginsList)
            noPlugins = true
        end
    end
end

function update(dt)
    if state == "loader" then
        biosSplashTimer = biosSplashTimer + 1
        if biosSplashTimer > 270 then
            state = "boot"
        end
    end
    if state == "boot" then
        Timer = Timer + 1
        if Timer > 10 then
            Timer = 0
            txtFrame = txtFrame + 1
            frame = frame + 1
            if frame > #shine then
                frame = 1
            end
            if txtFrame > 2 then
                txtFrame = 1
            end
        end
        if litinput.isKeyDown("insert") then
            isPluginPageEnable = true
        else
            isPluginPageEnable = false
        end
    end
    if state == "disks" then
    end
end

function keydown(k)
    if state == "boot" then
        if k == "1" then
            litfilesystem.newDir("projects/newGame")
            file = litfilesystem.createFile("projects/newGame/main.lua")
            file:open("w")
            file:write(scriptContent)
            file:close()
        end
        if k == "delete" then
            state = "disks"
        end
    end
    if state == "disks" then
        if k == "escape" then
            state = "boot"
        end

        -- cursor control
        if not noDisks then
            if k == "up" then
                cursorY = cursorY - 40
                selection = selection - 1
                if cursorY < 200 then
                    cursorY = 200
                end
                if selection < 1 then
                    selection = 1
                end
            end
            if k == "down" then
                cursorY = cursorY + 40
                selection = selection + 1
                if cursorY > Ymax then
                    cursorY = Ymax
                end
                if selection > #diskList then
                    selection = #diskList
                end
            end
        end
        if k == "return" then
            imageloader.changeImageName(diskList[selection])
            litgame.restart()
        end
    end
end

function keyup(k)

end

function renderDiskList()
    y = 200
    for li = 1, #diskList do
        litgraphics.newText(diskList[li], 50, y, 3, 3, 1)

        y = y + 40
        li = li + 1
    end
    Ymax = y - 40
end

function renderPluginList()
    y = 100
    for pli = 1, #pluginsList do
        if pli < 11 then
            litgraphics.newText(tostring(pluginsList[pli]):gsub("%.lua", ""), 25, y, 3, 3, 1)
            litgraphics.newSprite(pluginIcon, 2, 0, y + 3, pluginPallete)
            y = y + 40
            pli = pli + 1
        end
    end
    Ymax = y - 40
end