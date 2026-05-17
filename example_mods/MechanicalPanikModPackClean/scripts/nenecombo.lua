local combo = 0;

function goodNoteHit(id, direction ,noteType, isSustainNote)
combo = getProperty('combo');
if getProperty('gf.curCharacter') == 'nene' then
if not isSustainNote then
if getProperty('combo') == 50 then
playAnim('gf','combo50',true)
setProperty('gf.specialAnim',true)
end
if getProperty('combo') == 200 then
playAnim('gf','combo200',true)
setProperty('gf.specialAnim',true)
end
end
end
end

function noteMissPress(direction)
if getProperty('gf.curCharacter') == 'nene' then
if combo > 70 then
playAnim('gf','drop70',true)
setProperty('gf.specialAnim',true)
end
end
end

function noteMiss(id, direction, noteType, isSustainNote)
if getProperty('gf.curCharacter') == 'nene' then
if combo > 70 then
playAnim('gf','drop70',true)
setProperty('gf.specialAnim',true)
end
end
end