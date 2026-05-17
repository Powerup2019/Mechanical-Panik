function onCreatePost()
    makeLuaSprite('brightThingies', 'factory/bright thingies', 88, 163)
    makeLuaSprite('darkMetalThing', 'factory/darkmetal thingy', 193, 488)
    makeLuaSprite('metalThing', 'factory/metal thingy', 62, 225)
    makeLuaSprite('hallwalls', 'factory/hallwalls', 23, 393)
    makeLuaSprite('hallfloor', 'factory/hallfloor', 1, 815)
    makeLuaSprite('hallLight', 'factory/hall light', 0, 373)
    makeLuaSprite('floor', 'factory/floor', 0, 51)
    makeLuaSprite('mainLight', 'factory/main light', 29, 0)
    makeLuaSprite('foreWires', 'factory/foreground wires', 0, 51)
    makeLuaSprite('foreThing', 'factory/foreground thingy', 0, 989)

    setScrollFactor('metalThing', 0.95, 1)
    setScrollFactor('brightThingies', 0.95, 1)
    setScrollFactor('darkmetalThing', 0.95, 1)
    setScrollFactor('gf', 1, 1)

    addLuaSprite('brightThingies', false)
    addLuaSprite('darkMetalThing', false)
    addLuaSprite('metalThing', false)
    addLuaSprite('hallwalls', false)
    addLuaSprite('hallfloor', false)
    addLuaSprite('hallLight', false)
    addLuaSprite('floor', false)
    addLuaSprite('mainLight', true)
    addLuaSprite('foreWires', true)
    addLuaSprite('foreThing', true)

end

function onBeatHit()
    if curBeat % 3 == 0 then
        if getRandomInt(1,4) == 1 then
            setProperty('mainLight.alpha', 0)
            setProperty('boyfriend.color', getColorFromHex('BBB8B4'))
            setProperty('dad.color', getColorFromHex('BBB8B4'))
            setProperty('gf.color', getColorFromHex('BBB8B4'))
            runTimer('flicker', 0.2)
        end
    end
    if curBeat % 2 == 0 then
        if getRandomInt(1,6) == 1 then
            setProperty('hallLight.alpha', 0)
            runTimer('flicker2', 0.4)
        end
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'flicker' then
        setProperty('mainLight.alpha', 1)
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
        setProperty('gf.color', getColorFromHex('FFFFFF'))
    end
    if tag == 'flicker2' then
        setProperty('hallLight.alpha', 1)
    end
end
addLuaScript('scripts/hud/BatteryBar')
addLuaScript('scripts/hud/BotNoteSkin')