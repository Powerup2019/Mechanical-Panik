function onCreatePost()
    makeLuaSprite('foregroundwires', 'building/foregroundwires', -825, -325)
    makeLuaSprite('biglight', 'building/biglight', -1000, -375)
    makeLuaSprite('waterthing', 'building/waterthing', -775, -290)
    makeLuaSprite('lildarkthings', 'building/lildarkthings', -945, -455)
    makeLuaSprite('boxes', 'building/boxes', -815, -315)
    makeLuaSprite('mainroom', 'building/mainroom', -815, -305)
    makeLuaSprite('lil light', 'building/lil light', -815, -355)
    makeLuaSprite('it dark', 'building/it dark', -535, -575)
    makeLuaSprite('polybus', 'building/polybus', -775, -275)
    makeLuaSprite('backroom', 'building/backroom', -855, -305)

    scaleObject('polybus', 1, 1)
    scaleObject('backroom', 1, 1)
    scaleObject('it dark', 1, 1)
    scaleObject('waterthing', 1, 1)
    scaleObject('boxes', 1, 1)
    scaleObject('mainroom', 1, 1)
    scaleObject('lil light', 1, 1)
    scaleObject('biglight', 1, 1)
    scaleObject('foregroundwires', 1, 1.10)
    scaleObject('lildarkthings', 1, 1)

    setObjectOrder('backroom', 0)
    setObjectOrder('polybus', 1)
    setObjectOrder('it dark', 2)
    setObjectOrder('mainroom', 3)

    setScrollFactor('backroom', 0.85, 1)
    setScrollFactor('polybus', 0.85, 1)
    setScrollFactor('lil light', 0.85, 1)
    setScrollFactor('it dark', 0.85, 1)
    setScrollFactor('gf', 1, 1)

    addLuaSprite('backroom', false)
    addLuaSprite('waterthing', false)
    addLuaSprite('lil light', false)
    addLuaSprite('it dark', false)
    addLuaSprite('mainroom', false)
    addLuaSprite('boxes', false)
    addLuaSprite('lildarkthings', false)
    addLuaSprite('backroom', false)
    addLuaSprite('polybus', false)
    addLuaSprite('foregroundwires', true)
    addLuaSprite('biglight', true)
end
function onBeatHit()
    if curBeat % 3 == 0 then
        if getRandomInt(1,4) == 1 then
            setProperty('biglight.alpha', 0)
            setProperty('boyfriend.color', getColorFromHex('BBB8B4'))
            setProperty('dad.color', getColorFromHex('BBB8B4'))
            setProperty('gf.color', getColorFromHex('BBB8B4'))
            runTimer('flicker', 0.2)
        end
    end
    if curBeat % 2 == 0 then
        if getRandomInt(1,6) == 1 then
            setProperty('lil light.alpha', 0)
            runTimer('flicker2', 0.4)
        end
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'flicker' then
        setProperty('biglight.alpha', 1)
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
        setProperty('gf.color', getColorFromHex('FFFFFF'))
    end
    if tag == 'flicker2' then
        setProperty('lil light.alpha', 1)
    end
end
addLuaScript('scripts/hud/BatteryBar')
addLuaScript('scripts/hud/BotNoteSkin')
addLuaScript('scripts/hud/BSideHud')