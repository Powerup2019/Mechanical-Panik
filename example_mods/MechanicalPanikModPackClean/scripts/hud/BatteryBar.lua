
function onCreate()
    makeLuaSprite('Barbg','timebar/BatteryBg', 425,10)
    addLuaSprite('Barbg')
    if downscroll then
        setProperty('Barbg.y', screenHeight - 40)
    end
    makeLuaSprite('wunderbar','timebar/wunderBattery',getProperty('Barbg.x') + 6,getProperty('Barbg.y') + 6)
    addLuaSprite('wunderbar')
    makeAnimatedLuaSprite("insidebar","timebar/BatteryInsideBar",getProperty('Barbg.x') + 1.6,getProperty('Barbg.y') + 1.6)
    addLuaSprite('insidebar')
    for i = 0, 100 do
        addAnimationByIndices('insidebar', ""..i, 'BatteryCharges', ""..i)
    end
    --scaleObject('wunderbar', 0.8, 0.8)
    --scaleObject('insidebar', 0.8, 0.8)
    --scaleObject('Barbg', 0.8,0.8)
    setObjectCamera('Barbg','hud')
    setObjectCamera('wunderbar','hud')
    setObjectCamera('insidebar','hud')
end
function onUpdate(elapsed)
    setProperty("timeBar.y", -9999)
    setProperty('timeTxt.y', getProperty('wunderbar.y') - 5)
    setProperty('timeTxt.x', getProperty('wunderbar.x'))

    playAnim('insidebar', tostring(math.floor(getProperty("timeBar.percent"))))
    setProperty('wunderbar.color',  getColorFromHex(getTimeBarColors()))
	--setProperty('insidebar.color', getColorFromHex(hex2))

    setProperty('Barbg.alpha', getProperty('timeBar.alpha'))
    setProperty('wunderbar.alpha', getProperty('timeBar.alpha'))
    setProperty('insidebar.alpha', getProperty('timeBar.alpha'))
    setProperty('shade.alpha', getProperty('timeBar.alpha'))

    setProperty('Barbg.angle', getProperty('timeBar.angle'))
    setProperty('wunderbar.angle', getProperty('timeBar.angle'))
    setProperty('insidebar.angle', getProperty('timeBar.angle'))
    setProperty('shade.angle', getProperty('timeBar.angle'))
end
function getTimeBarColors()
    RightColor = getProperty('timeBar.rightBar.color')

    r = bit.rshift(bit.band(RightColor, 0xFF0000), 16)

    g = bit.rshift(bit.band(RightColor, 0x00FF00), 8)

    b = bit.band(RightColor, 0x0000FF)
    
    return string.format("%02X%02X%02X", r, g, b)
end