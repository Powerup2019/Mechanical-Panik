addHScript('custom_events/RGB Change', true)
addHScript('custom_events/Change Note Texture', true)

if checkFileExists('data/'..loadedSongName..'/metaData.json') then
    json = callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile('data/'..loadedSongName..'/metaData.json')})
else
    json = nil
end

function returnMetaData()
    return json
end

function addLuaFromHScript(file) --purely because im too lazy to figure it out in hscript
    if file ~= null and file.length > 0 then
        addLuaScript(file, true)
    end
end

function addHScriptFromHScript(file)
    if file ~= null and file.length > 0 then
        addHScript(file, true)
    end
end