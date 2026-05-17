setProperty('introSoundsSuffix', '-power')
addLuaScript('scripts/hud/BatteryBar')
addLuaScript('scripts/hud/BotNoteSkin')
local WEDGE_DISTANCE = 270

function onCreatePost()
    -- Hide default visuals (keep logic)
    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.alpha', 0)

    makeLuaSprite('healthBarCustom', 'b/hud/bar', 0, getProperty('healthBar.y'))
    screenCenter('healthBarCustom', 'x')
    setObjectCamera('healthBarCustom', 'hud') 
    addLuaSprite('healthBarCustom', false)

    makeLuaSprite('healthBarFill', 'b/hud/barFill',
        getProperty('healthBarCustom.x') + 21,
        getProperty('healthBarCustom.y') + 7)
    setObjectCamera('healthBarFill', 'hud') 
    addLuaSprite('healthBarFill', false)

    makeLuaSprite('leftWedge', 'b/hud/wedge', WEDGE_DISTANCE, getProperty('healthBar.y') - 55)
    setProperty('leftWedge.flipX', true)
    setObjectCamera('leftWedge', 'hud') 
    addLuaSprite('leftWedge', false)

    makeLuaSprite('rightWedge', 'b/hud/wedge', 1280 - WEDGE_DISTANCE, getProperty('healthBar.y') - 55)
    setProperty('rightWedge.x', getProperty('rightWedge.x') - getProperty('rightWedge.width'))
    setObjectCamera('rightWedge', 'hud') 
    addLuaSprite('rightWedge', false)

    setObjectCamera('iconP1', 'hud')
    setObjectCamera('iconP2', 'hud')

    setObjectOrder('healthBarCustom', getObjectOrder('healthBar') + 1)
    setObjectOrder('healthBarFill', getObjectOrder('healthBarCustom') + 1)
    setObjectOrder('leftWedge', getObjectOrder('healthBarCustom') + 2)
    setObjectOrder('rightWedge', getObjectOrder('healthBarCustom') + 2)
end

function onUpdatePost()
    local percent = getProperty('healthBar.percent') / 100

    setProperty('healthBarFill.scale.x', percent)

   local barX = getProperty('healthBarCustom.x')
local barWidth = getProperty('healthBarCustom.width')

local percent = getProperty('healthBar.percent') / 100

local iconX = barX + (barWidth * (1 - percent))

setProperty('iconP1.x', iconX - 55)
setProperty('iconP2.x', iconX - 125)


    setProperty('iconP1.scale.x', 0.9 + (0.2 * (1 - percent)))
    setProperty('iconP1.scale.y', 0.9 + (0.2 * (1 - percent)))

    setProperty('iconP2.scale.x', 0.9 + (0.2 * (1 - percent)))
    setProperty('iconP2.scale.y', 0.9 + (0.2 * (1 - percent)))

makeLuaText('scoreTxtCustom', 'Score: 0', 360, 150, 600)
setTextSize('scoreTxtCustom', 18)
setObjectCamera('scoreTxtCustom', 'hud')
addLuaText('scoreTxtCustom')

makeLuaText('accuracyTxt', 'Accuracy: 0%', 1550, 150, 600)
setTextSize('accuracyTxt', 18)
setObjectCamera('accuracyTxt', 'hud')
addLuaText('accuracyTxt')
setTextString('scoreTxtCustom', 'Score: ' .. getProperty('songScore'))

local acc = getProperty('ratingPercent') * 100
setTextString('accuracyTxt', 'Accuracy: ' .. string.format('%.2f%%', acc))
setProperty('scoreTxt.visible', false)

end