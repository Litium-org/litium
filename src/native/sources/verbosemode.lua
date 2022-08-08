function start()
    curFile = 1
    isLoadingState = true

    letters = {}

    text = ""
    currentcmd = ""
    filenames = require 'src/native/engine/resources/filenames'
    shell = require 'src/native/sources/shell/litshell'

    remove = table.remove
    insert = table.insert
    concat = table.concat

    time2 = 0
    timems = 0

    litsystem.setName("Litium [BETA] v0.4 - Ruby [COMMAND-LINE MODE]")

    -- for keyboard driver XD --
    acceptedKeys = {
        "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
        "0","1","2","3","4","5","6","7","8","9",
        "!","=","$","(",")",",",".",":",";","+","-","/","|","<",">","?","[","]",
        "space","backspace","return"
    }

end

function render()
    shell.render()
    generateString()
end

function update(dt)
    math.randomseed(os.clock())
    time2 = time2 + 1
    if time2 > 40 and isLoadingState then
        timems = timems + 1
        if timems > math.random(1, 5) then
            FileName = filenames[curFile]
            shell.write("loaded: " .. FileName)
            curFile = curFile + 1
            timems = 0
            if curFile > #fileList then
                isLoadingState = false
                shell.write("Welcome...")
                shell.write("nxstudios 2022 - copyrights reserved")
                shell.write("litium commandline [v0.0.4]")
            end
        end
    end
    shell.update(dt)
end

function keydown(k, code)
    if not isLoadingState then
        if checkForAcceptedKeys(code) then
            if k == "backspace" then
                backspaceCMD()
            else if k == "return" then
                enterCMD()
            else if k == "space" then
                insert(letters, " ")
            else
                insert(letters, k)
            end
            end
            end
        end
    end
end

----------------------------------------------------------------
--[[                       Functions                        ]]--
----------------------------------------------------------------

function generateString()
    for i = 1, #letters, 1 do
        text = concat(letters, "")
        litgraphics.newText(text, 0, 750, 2, litshell.txtcolor, litshell.bgcolor)
    end
end

function checkForAcceptedKeys(keyboardkey)
    for key = 1, #acceptedKeys do
        if keyboardkey == acceptedKeys[key] then
            return true
        else
            key = key + 1
        end
    end
    return false
end

function backspaceCMD()
    remove(letters, #letters)
end

function enterCMD()
    for i = #letters, 1, -1 do
        remove(letters, i)
    end
    shell.command(text)
    text = ""
    print(currentcmd)
end