function start()
    
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

    litgraphics.loadPallete(pallete)
end

function render()
    litgraphics.newText("", 200, 100, 5, 4, 1)
    litgraphics.newSprite(pluginIcon, 5, 90 ,90)
end

function update(dt)

end

function keydown(k)

end

function keyup(k)

end