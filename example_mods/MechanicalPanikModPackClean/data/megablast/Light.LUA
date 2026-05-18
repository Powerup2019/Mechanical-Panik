function onCreate()
    playSound('BF YEA!')
    triggerEvent('Hey!', 'BF', 0.8)
    playSound('LightOff')
    setProperty("startCountdown", true)
end