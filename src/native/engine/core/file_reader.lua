fileReader = {}


function fileReader.getvalue(filename, valuename)
	engineConfigFile, err = load(filename)
    data = engineConfigFile()
	return data[valuename]
end

return fileReader