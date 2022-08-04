litshell = {}

diskList = diskcheck.init()
terminal = {}
cmd = {}
isDeleting = false
litshell.txtcolor = 3
litshell.bgcolor = 1
litshell.screenPosition = 1

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
]]

remove = table.remove
insert = table.insert


function litshell.command(command)
    stringx = require 'pl/stringx'

    cmd = stringx.split(command, " ")
    printCMDList()
    
    -- single command parameters --
    litshell.write("> " .. command)

    if cmd[1] == "clear" or cmd[1] == "cls" then
        clearTerminal()
    end
    if cmd[1] == "reboot" then
        litgame.restart()
    end
    if cmd[1] == "exit" then
        imageloader.changeImageName("-native")
        litgame.restart()
    end

    -- Multi paramaters commands --

    if cmd[1] == "boot" then
        if cmd[2] == "select" then
            if cmd[3] == nil  then
                litshell.write("please type a valid boot disk name")
            else
                imageloader.changeImageName(cmd[3])
                litshell.write("disk selected, please reboot with reboot command")
            end
        end
        if cmd[2] == "list" then
            renderDiskList()
        end
    end

    if cmd[1] == "project" then
        if cmd[2] == "create" then
            if cmd[3] == nil then
                litshell.write("Please type a valid project name")
            else
                litfilesystem.newDir("projects/" .. cmd[3])
                file = litfilesystem.createFile("projects/" .. cmd[3] .. "/main.lua")
                file:open("w")
                file:write(scriptContent)
                file:close()
            end
        end
        if cmd[2] == "format" then
            deleteAllProjects()
        end
        if cmd[2] == "list" then
            dirs = diskcheck.getProjects()
            print(dirs)
            for i = 1, #dirs, 1 do
                litshell.write(dirs[i])
            end
        end
    end

    if cmd[1] == "color" then
        if cmd[2] == nil then
            litshell.txtcolor = 3
        else
            litshell.bgcolor = tonumber(cmd[2])

            if cmd[3] == nil then
                litshell.bgcolor = 1
            else
                litshell.bgcolor = tonumber(cmd[3])
            end
        end
    end
    clearCommandList()
end

function litshell.render()
    txtY = 0
    if #terminal > 0 then
        for tc = 1, #terminal, 1 do
            litgraphics.newText(terminal[tc], 0, txtY, 2, litshell.txtcolor, litshell.bgcolor) 
            txtY = txtY + 20
        end
    end
end

function litshell.update(dt)
    if #terminal > 37 then
       remove(terminal, 1)
    end
end

----------------------------------------------------------------
--[[                   Callback Functions                   ]]--
----------------------------------------------------------------

function litshell.write(string)
    insert(terminal, string)
end

----------------------------------------------------------------
--[[                       Functions                        ]]--
----------------------------------------------------------------


function clearCommandList()
    for cmlistitem = #cmd, 1, -1 do
        remove(cmd, cmlistitem)
    end
end

function printCMDList()
    for i = 1, #cmd, 1 do
        print(cmd[i])
    end
end

function deleteAllProjects()
    projdir = diskcheck.getProjects()
    for i = 1, #projdir do
        print(projdir[i])
        love.filesystem.remove("projects/" .. projdir[i])
        i = i + 1
    end
end

function clearTerminal()
    for termItem = #terminal, 1, -1 do
        remove(terminal, termItem)
    end
end

function renderDiskList()
    for li = 1, #diskList, 1 do
        litshell.write(diskList[li])
    end
end


return litshell