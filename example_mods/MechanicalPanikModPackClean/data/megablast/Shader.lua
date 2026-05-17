local characterEventTiming = {} --- this script is not mine, please don't hate on me
function onCreatePost()
    local index = 0
    for i = 0, getProperty('eventNotes.length') - 1 do
        if getPropertyFromGroup('eventNotes', i, 'event') == 'Change Character' then
            index = index + 1   
            characterEventTiming[index] = {
                charType = getCharacterType(getPropertyFromGroup('eventNotes', i, 'value1')),
                strumTime = getPropertyFromGroup('eventNotes', i, 'strumTime'),
                shaderSaved = false
            }
        end
    end

    runHaxeCode([[
        var bfShader:FlxRuntimeShader;
        var dadShader:FlxRuntimeShader;
        var gfShader:FlxRuntimeShader;

        function saveShader(character:String) {
            switch(character) {
                case 'boyfriend':
                    bfShader = game.boyfriend.shader;
                case 'dad':
                    dadShader = game.dad.shader;
                case 'gf':
                    gfShader = game.gf.shader;
                default:
                    return;
            }
        }

        function applyShader(character:String) {
            switch(character) {
                case 'boyfriend':
                    game.boyfriend.shader = bfShader;
                case 'dad':
                    game.dad.shader = dadShader;
                case 'gf':
                    game.gf.shader = gfShader;
                default:
                    return;
            }
        }
    ]])
end

function onEvent(event, value1, value2, strumTime)
    if event == 'Change Character' then
        runHaxeFunction('applyShader', {getCharacterType(value1)})
    end
end

function onUpdate(elapsed)
    for i = 1, #characterEventTiming do
        if characterEventTiming[i].shaderSaved == false then
            if getSongPosition() >= characterEventTiming[i].strumTime - (elapsed * 1000 * playbackRate) then
                runHaxeFunction('saveShader', {characterEventTiming[i].charType})
                removeSpriteShader(characterEventTiming[i].charType)
                characterEventTiming[i].shaderSaved = true
            end
        end
    end
end

function getCharacterType(stringValue)
    stringValue = string.lower(stringValue)
    if stringValue == '0' or stringValue == 'bf' or stringValue == 'boyfriend' then
        return 'boyfriend'
    elseif stringValue == '1' or stringValue == 'dad' or stringValue == 'opponent' then
        return 'dad'
    elseif stringValue == '2' or stringValue == 'gf' or stringValue == 'girlfriend' then
        return 'gf'
    end
end
function onCreatePost()
    if not shadersEnabled then return end

    initLuaShader('Light_Shader')

    local chars = {
        boyfriend = {
            angle = 110,
            lightOpacity = 1.0,
            thr = 0.1,
            useMask = true,
            thr2 = 0.1,
            dist = 12.5,
            brightness = -100,
            hue = -10,
            contrast = -25,
            saturation = -25,
            lightColor = {150/255, 150/255, 255/255}
        },
        gf = {
            angle = 90,
            lightOpacity = 1.0,
            thr = 0.1,
            useMask = true,
            thr2 = 0.1,
            dist = 23.5,
            brightness = -100,
            hue = 10,
            contrast = -25,
            saturation = -25,
            lightColor = {205/255, 231/255, 254/255}
        },
        dad = {
            angle = 70,
            lightOpacity = 1.0,
            thr = 0.1,
            useMask = true,
            thr2 = 0.1,
            dist = 12.5,
            brightness = -100,
            hue = -10,
            contrast = -25,
            saturation = -25,
            lightColor = {222/255, 249/255, 249/255}
        }
    }

    for char, data in pairs(chars) do
        setSpriteShader(char, 'Light_Shader')

        -- Luz e máscara
        setShaderFloat(char, 'thr', data.thr)
        if data.thr2 then setShaderFloat(char, 'thr2', data.thr2) end
        setShaderFloat(char, 'ang', math.rad(data.angle))
        setShaderBool(char, 'useMask', data.useMask)
        setShaderFloat(char, 'dist', data.dist)

        -- Qualidade do efeito
        setShaderFloat(char, 'AA_STAGES', 2)
        setShaderFloat(char, 'str', 0.8)

        if data.lightColor then
            setShaderFloatArray(char, 'dropColor', data.lightColor)
        end

        -- Ajustes de cor
        setShaderFloat(char, 'brightness', data.brightness or 0)
        setShaderFloat(char, 'hue', data.hue or 0)
        setShaderFloat(char, 'contrast', data.contrast or 0)
        setShaderFloat(char, 'saturation', data.saturation or 0)
        setShaderFloat(char, 'lightOpacity', data.lightOpacity or 1)

        updateFrameInfo(char)
    end
end

function onUpdatePost()
    if not shadersEnabled then return end
    for char in pairs({boyfriend=true, gf=true, dad=true}) do
        updateFrameInfo(char)
    end
end

function updateFrameInfo(s)
    if getProperty(s..'.pixel') then return end
    setShaderFloatArray(s, 'uFrameBounds', {
        getProperty(s..'.frame.uv.x'),
        getProperty(s..'.frame.uv.y'),
        getProperty(s..'.frame.uv.width'),
        getProperty(s..'.frame.uv.height')
    })
end
function onCreate()
    makeLuaSprite('blackBox', nil, 0, 0)
    makeGraphic('blackBox', 5840, 2160, '000000')
    setBlendMode('blackBox', 'multiply')
    screenCenter('blackBox', 'xy')
    setProperty('blackBox.alpha', 0.50)
    addLuaSprite('blackBox', true)
end
