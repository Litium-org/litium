function start()
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

    litgraphics.loadPallete(sprPallete)
end

function render()
    litgraphics.newSprite(logo, 16, 160, 160)
end

function update(dt)

end

function keydown(k)

end

function keyup(k)

end