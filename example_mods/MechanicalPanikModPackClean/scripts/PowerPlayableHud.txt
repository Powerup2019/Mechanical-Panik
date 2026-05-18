function onCreate()
    local bf = getProperty('boyfriend.curCharacter')

    if bf == 'Power-Playable' then
        addLuaScript('scripts/hud/BatteryBar', true)
        addHScript('scripts/hud/BotNoteSkin', true)

        setProperty('healthBar.visible', true)
        makeLuaSprite('healthBar', 'PowerHUD/healthBar', 268, 615)
        setObjectCamera('healthBar', 'camHUD')
        addLuaSprite('healthBar')
    end
end
