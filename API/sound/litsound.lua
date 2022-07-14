litsound = {}

sounddriver = require 'src/native/engine/sound/soundgen'
json = require 'src/thirdparty/json'

isPlayingTrack = false
isPaused = false
timer = 0
arraySection = 1

-- pause vars --
savedSection = 0

--- Generate simple tone
--- @param waveLength number
--- @param frequency number
--- @param waveType string
function litsound.newWaveFrequency(waveLength, frequency, waveType)
    sounddriver.newWaveFrequency(waveLength, frequency, waveType)
end

--- Generate a tone based on predefined tones list (7 tones)
---@param WaveLength number
---@param tone number
---@param waveType string
function litsound.newWave(WaveLength, tone, waveType)
    sounddriver.newWave(WaveLength, tone, waveType)
end

-- "*all"
function litsound.playTrackFromFile(filename)
    file = io.open(path, "r")
    songjson = json.decode(file:read("*all"))
    litsound.playTrack(songjson)
end

--- Play your table song
--- @param trackTable table
function litsound.playTrack(trackTable)
    WaveLength      =       trackTable[arraySection][1]
    freque          =       trackTable[arraySection][2]
    noteType        =       trackTable[arraySection][3]
    waitMS          =       trackTable[arraySection][4]

    isPlayingTrack = true

    if isPlayingTrack then
        if not isPaused then
            if arraySection < #trackTable then
                timer = timer + 1
                if timer > waitMS then
                    arraySection = arraySection + 1
                    print(WaveLength, freque, noteType, waitMS)
                    sounddriver.newWaveFrequency(WaveLength, freque, noteType)
                    timer = 0
                end
            end
        end
    else
        isPlayingTrack = false
        return
    end
end

-- functions --
function litsound:pause()
    if isPlayingTrack then
        isPaused = true
        savedSection = arraySection
    else
        error("no song is playing")
    end
end

function litsound:resume()
    if isPlayingTrack then
        if isPaused then
            arraySection = savedSection
            isPaused = false
        end
    else
       error("no song is playing") 
   end 
end

return litsound