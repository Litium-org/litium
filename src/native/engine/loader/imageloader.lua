imageloader = {}

load                = love.filesystem.load
getInfo             = love.filesystem.getInfo
newFile             = love.filesystem.newFile
createDirectory     = love.filesystem.createDirectory

SaveDir             = love.filesystem.getSaveDirectory()

defaultSettings = [[
return {
    -- Litium Engine configuration script --
    bios_version = "0.0.4",
    bios_language = "en",
    bios_splash = true,
    bios_enablePlugins = true,
    bios_verbose = false
}
]]

function createSettingsFile()
    file = newFile("engine.lua")
    file:open("w")
    file:write(defaultSettings)
    file:close()
end

function createImageFile()
    file = newFile("image.txt")
    file:open("w")
    file:write("-native")
    file:close()
end

function createEngineFolders()
    diskSucess = createDirectory("disk")
    pluginsSucess = createDirectory("plugins")
    projectSucess = createDirectory("projects")
    saveSucess = createDirectory("save")
end

function exist(type, filename)
    if type == "file" then
        if getInfo(filename) ~= nil then
            return true
        else
            return false
        end
    end

    if type == "directory" or type == "folder" or type == "dir" then
        if getInfo(filename) ~= nil then
            return true
        else
            return false
        end
    end
end

function imageloader.init()
    fileExist = exist("file", "engine.lua")
    imageExist = exist("file", "image.txt")
    dirExist = exist("folder", "disk")
    pluginExist = exist("folder", "plugins")
    projects = exist("folder", "projects")
    saveExist = exist("folder", "save")
    if not fileExist or not dirExist or not projects or not imageExist or not saveExist then
        createSettingsFile()
        createImageFile()
        createEngineFolders()
    end
end


function imageloader.getImage()     --get operating system name image (folder)
    -- get file Version
    
    -- get file datas
    engineConfigFile = load("engine.lua")
    verbmode = fileReader.getvalue("engine.lua", "bios_verbose")
    imageFileName = io.open(SaveDir .. "/image.txt", "r")
    gameName = imageFileName:read()
    data = engineConfigFile()

    if not verbmode then
        if gameName == "nil" or gameName == nil or gameName == "" or gameName == "-native" then
            if exist("file", "firstboot.txt") then
                imagedata, err = load("src/native/sources/boot.lua")
    
                if imagedata == nil then
                    
                    error(err, 2)
                end
            else
                imagedata, err = load("src/native/sources/firstboot.lua")
    
                if imagedata == nil then
                    
                    error(err, 2)
                end
            end
        else
            imagedata, err = load("disk/" .. gameName .. "/main.lua")
    
            if imagedata == nil or err ~= nil then
                
                imagedata, err = load("src/native/sources/errstate.lua")
            end
        end
        if gameName == "-warnoutdate" then
            imagedata, err = load("src/native/sources/bios_updatewarn.lua")
    
            if imagedata == nil then
                
                error(err, 2)
            end
        end
        if gameName == "-debug" then
            imagedata, err = load("src/native/sources/debugstate.lua")
    
            if imagedata == nil then
                
                error(err, 2)
            end
        end
    else
        imagedata, err = load("src/native/sources/verbosemode.lua")
    
        if imagedata == nil then
                
            error(err, 2)
         end
    end
    

    return imagedata
end

function imageloader.getCurrentImageName()
    currentImage = io.open(saveDir .. "/image.txt", "r")
    return currentImage:read()
end
 
function imageloader.changeImageName(image)
    gameTxTFile = io.open(SaveDir .. "/image.txt", "w")
    gameTxTFile:write(image)
    gameTxTFile:close()
end

return imageloader