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
            dist = 25,
            brightness = -95,
            hue = -10,
            contrast = -25,
            saturation = 0,
            lightColor = {150/255, 150/255, 255/255}
        },
        gf = {
            angle = 90,
            lightOpacity = 1.0,
            thr = 0.1,
            useMask = true,
            thr2 = 0.1,
            dist = 20,
            brightness = -95,
            hue = 10,
            contrast = -25,
            saturation = 0,
            lightColor = {205/255, 231/255, 254/255}
        },
        dad = {
            angle = 70,
            lightOpacity = 1.0,
            thr = 0.1,
            useMask = true,
            thr2 = 0.1,
            dist = 20,
            brightness = -95,
            hue = -10,
            contrast = -25,
            saturation = 0,
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
