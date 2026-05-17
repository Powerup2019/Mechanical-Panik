function onCreate()

    -- Create black screen
    makeLuaSprite('blackScreen', nil, 0, 0)
    makeGraphic('blackScreen', screenWidth, screenHeight, '000000')

    -- Put it above EVERYTHING
    setObjectCamera('blackScreen', 'hud')
    addLuaSprite('blackScreen', true)

    -- Optional: block HUD too
    setProperty('blackScreen.alpha', 1)
end

function onEvent(name, value1, value2)
    if name == 'Camera Flash' then
        removeLuaSprite('blackScreen', true)
        setProperty('data/machina/songCredits', 'hud')
    end
end