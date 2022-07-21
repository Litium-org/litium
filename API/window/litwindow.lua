litwindow = {}

--- Display message box
--- @param x number
--- @param y number
--- @param w number
--- @param h number
--- @param title string
--- @param text string
function litwindow.popup(x, y, w, h, title, text)
    litgraphics.rect(x + 32, y + 32, w, h, 2, "fill")   -- shadow --
    litgraphics.rect(x, y, w, h, 3, "fill")     -- current the window XD --
    -- texts --
    litgraphics.newText(title, x + (w / 2 - (#title * 6)), y, 2, 3, 1)
    litgraphics.newText(text, x + (w / 2 - (#text * 6)), y + 24, 2, 3, 1)
end

return litwindow