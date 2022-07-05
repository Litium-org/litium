function start()
    settings = require 'src/native/engine/core/file_reader'
    lang = settings.getvalue("engine.lua", "bios_language")

    litsystem.setName("Litium [BETA] v0.3 - Jadeite [OUTDATED ENGINE]")

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

    heartPallete = {
        {0,0,0,0},
        {255,0,0},
        {255,255,255}
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

    litgraphics.loadPallete(sprPallete)
end

function render()
    litgraphics.rect(0, 0, 1280, 768, 3, "fill")
    litgraphics.newSprite(logo, 16, 60, 60)
    litgraphics.newText(language[lang].outdatedEngine.title, 240, 98, 8, 1, 1)
    litgraphics.newText(language[lang].outdatedEngine.title, 240, 90, 8, 3, 1)
    litgraphics.newText(language[lang].outdatedEngine.description, 220, 203, 3, 1, 1)
    litgraphics.newText(language[lang].outdatedEngine.description, 220, 200, 3, 3, 1)
    litgraphics.newText(language[lang].outdatedEngine.description2, 220, 253, 3, 1, 1)
    litgraphics.newText(language[lang].outdatedEngine.description2, 220, 250, 3, 3, 1)
    litgraphics.newText(language[lang].outdatedEngine.description3, 220, 303, 3, 1, 1)
    litgraphics.newText(language[lang].outdatedEngine.description3, 220, 300, 3, 3, 1)
    
end

function update(dt)

end

function keydown(k)
    if k == "return" then
        love.system.openURL("https://github.com/Litium-org/litium/releases")
    end
    if k == "escape" then
        imageloader.changeImageName("-native")
        litgame.restart()
    end
end

function keyup(k)

end