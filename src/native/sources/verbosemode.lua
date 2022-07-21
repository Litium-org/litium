function start()
    letters = {}
    -- for keyboard driver XD --
    acceptedKeys = {
        "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
        "0","1","2","3","4","5","6","7","8","9",
        "!","=","$","(",")",",",".",":",";","+","-","/","|","<",">","?","[","]",
        "space","backspace"
    }
end

function render()
    generateString()
end

function update(dt)

end

function keydown(k, code)
    if checkForAcceptedKeys(code) then
        if k == "backspace" then
            backspaceCMD()
        else if k == "space" then
            table.insert(letters, " ")
        else
            table.insert(letters, k)
        end
        end
    end
end

----------------------------------------------------------------
--[[                       Functions                        ]]--
----------------------------------------------------------------

function generateString()
    for i = 1, #letters, 1 do
        text = table.concat(letters, "")
        litgraphics.newText(text, 100, 0, 3, 3, 1)
    end
end

function checkForAcceptedKeys(keyboardkey)
    for key = 1, #acceptedKeys do
        print(key, acceptedKeys[key])
        if keyboardkey == acceptedKeys[key] then
            return true
        else
            key = key + 1
            print(keyboardkey, key)
            --return false
        end
    end
    return false
end

function backspaceCMD()
    table.remove(letters, #letters)
end