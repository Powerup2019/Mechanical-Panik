playerSpeed = 1
oppSpeed = 1
function onSpawnNote(index, noteData, noteType, isSustain, strumTime)
    if getProperty('notes.members[0].mustPress') then
        setProperty('notes.members[0].multSpeed', playerSpeed)
    else
        setProperty('notes.members[0].multSpeed', oppSpeed)
    end
end
function onEvent(event, value1, value2, strumTime)
  if event == 'Change Speeds' then
    if value1 == nil then
      playerSpeed = 1
    else
      playerSpeed = value1
    end

    if value2 == nil then
      oppSpeed = 1
    else
      oppSpeed = value2
    end
  end
end
