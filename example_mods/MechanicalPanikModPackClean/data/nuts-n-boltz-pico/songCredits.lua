-- Script made by OriginDevel (Devel#2081)
-- Special thanks for Lua-X-Dea for the Wiki Lua Spanish
-- Based on RamenDominoes original script

-- CONFIGURATION

local triggerStep = 1
local pauseDuration = 3

-- Style
local bgColor = '000000'
local borderColor = 'FFFFFF'
local textColor = 'FFFFFF'

local bgAlpha = 0.6
local borderAlpha = 0.9

-- Fonts
local titleFont  = 'vcr.ttf'
local creditFont = 'vcr.ttf'

-- Icons (inside images/credits/)
local iconComposer = 'credits/superduptnt'
local iconCoder = 'credits/pwr'
local iconArtist = 'credits/face'
local iconCharter = 'credits/gamerman'

-- Credit contents
local songName = 'Nuts-N-Boltz (PICO)'
local composer = 'Composer: SuperdupTNT'
local coder = 'Coder: PWR'
local artist  = 'Artist: YokoTanuki'
local charter = 'Charter: Gamerman'

-- ⚠️ WARNING – READ THIS BEFORE YOU BREAK SOMETHING ⚠️
-- Hey there, dipshit. 👋 Yeah, you. Listen up:

-- DO NOT touch anything below this line unless:
-- - You know exactly what you’re doing.
-- - You know Lua (or at least argue with Stack Overflow daily).
-- - You're fine with game crashes and cryptic errors at 3AM.
-- - You backed up your mod. Right? RIGHT??

-- All the stuff you should tweak is *above* this message ↑.
-- Below this line is where the black magic lives: animations, math, and maybe some shittly code.

-- Touch it at your own risk.
-- YOU HAVE BEEN WARNED, dipshit. 🛠️🔥💀

-- Layout
local screenWidth = 1280
local screenHeight = 720
local bgWidth = screenWidth + 200
local bgHeight = 260
local borderThickness = 5
local textBlockWidth = 500
local lineSpacing = 44
local iconSize = 60
local iconPaddingX = 20
local extraIconSpacing = 7
local iconYOffset = -42

-- Center in height
local centerY = (screenHeight / 2) - (bgHeight / 2)

-- Internals
local bgStartX = -bgWidth - 200
local textStartX = -screenWidth - 200
local bgExitX = screenWidth + 300
local textExitX = screenWidth + 200
local shown = false

function onCreate()
    -- Background
    makeLuaSprite('creditsBG', '', bgStartX, centerY)
    makeGraphic('creditsBG', bgWidth, bgHeight, bgColor)
    setObjectCamera('creditsBG', 'hud')
    setProperty('creditsBG.alpha', bgAlpha)
    addLuaSprite('creditsBG', true)

    makeLuaSprite('creditsBorderTop', '', bgStartX, centerY - borderThickness)
    makeGraphic('creditsBorderTop', bgWidth, borderThickness, borderColor)
    setObjectCamera('creditsBorderTop', 'hud')
    setProperty('creditsBorderTop.alpha', borderAlpha)
    addLuaSprite('creditsBorderTop', true)

    makeLuaSprite('creditsBorderBottom', '', bgStartX, centerY + bgHeight)
    makeGraphic('creditsBorderBottom', bgWidth, borderThickness, borderColor)
    setObjectCamera('creditsBorderBottom', 'hud')
    setProperty('creditsBorderBottom.alpha', borderAlpha)
    addLuaSprite('creditsBorderBottom', true)

    -- Credit lines
    local textX = (screenWidth / 2) - (textBlockWidth / 2)
    local startY = centerY + 40
    local creditLines = {
        {id = 'txtSong',     text = songName,   size = 48, font = titleFont,  icon = nil, yOffset = -20},
        {id = 'txtComposer', text = composer,   size = 22, font = creditFont, icon = iconComposer, yOffset = 0},
        {id = 'txtCoder',    text = coder,      size = 22, font = creditFont, icon = iconCoder, yOffset = 0},
        {id = 'txtArtist',   text = artist,     size = 22, font = creditFont, icon = iconArtist, yOffset = 0},
        {id = 'txtCharter',  text = charter,    size = 22, font = creditFont, icon = iconCharter, yOffset = 0}
    }

    for i, item in ipairs(creditLines) do
        local posY = startY + (i - 1) * lineSpacing + item.yOffset

        makeLuaText(item.id, item.text, textBlockWidth, textStartX, posY)
        setTextSize(item.id, item.size)
        setTextAlignment(item.id, 'left')
        setTextFont(item.id, item.font)
        setTextColor(item.id, textColor)
        setObjectCamera(item.id, 'hud')
        addLuaText(item.id)

        if item.icon then
            local iconID = 'icon_' .. item.id
            local iconY = posY + (item.size / 2) - (iconSize / 2) + iconYOffset + ((i - 1) * extraIconSpacing)

            makeLuaSprite(iconID, item.icon, textStartX + textBlockWidth + iconPaddingX, iconY)
            setObjectCamera(iconID, 'hud')
            scaleObject(iconID, iconSize / 100, iconSize / 100)
            addLuaSprite(iconID, true)
        end
    end
end

function onStepHit()
    if curStep == triggerStep and not shown then
        shown = true
        local tweenTime = 1.0

        doTweenX('bgIn', 'creditsBG', 0, tweenTime, 'quartOut')
        doTweenX('borderTopIn', 'creditsBorderTop', 0, tweenTime, 'quartOut')
        doTweenX('borderBottomIn', 'creditsBorderBottom', 0, tweenTime, 'quartOut')

        runTimer('textIn', 0.5)
    end
end

function onTimerCompleted(tag)
    if tag == 'textIn' then
        local tweenTime = 1.0
        local textX = (screenWidth / 2) - (textBlockWidth / 2)

        for _, id in ipairs({'txtSong', 'txtComposer', 'txtCoder', 'txtArtist', 'txtCharter'}) do
            doTweenX(id..'In', id, textX, tweenTime, 'quartOut')

            local iconID = 'icon_' .. id
            if getProperty(iconID..'.x') ~= nil then
                doTweenX(iconID..'In', iconID, textX + textBlockWidth + iconPaddingX, tweenTime, 'quartOut')
            end
        end

        runTimer('hideCredits', tweenTime + pauseDuration)

    elseif tag == 'hideCredits' then
        local tweenTime = 1.0
        for _, id in ipairs({'txtSong', 'txtComposer', 'txtCoder', 'txtArtist', 'txtCharter'}) do
            doTweenX(id..'Out', id, textExitX, tweenTime, 'quartIn')

            local iconID = 'icon_' .. id
            if getProperty(iconID..'.x') ~= nil then
                doTweenX(iconID..'Out', iconID, textExitX, tweenTime, 'quartIn')
            end
        end

        runTimer('barOut', 0.5)

    elseif tag == 'barOut' then
        local tweenTime = 1.0
        doTweenX('bgOut', 'creditsBG', bgExitX, tweenTime, 'quartIn')
        doTweenX('borderTopOut', 'creditsBorderTop', bgExitX, tweenTime, 'quartIn')
        doTweenX('borderBottomOut', 'creditsBorderBottom', bgExitX, tweenTime, 'quartIn')
    end
end
setProperty('introSoundsSuffix', '-power')