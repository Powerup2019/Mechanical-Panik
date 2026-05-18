import backend.Paths;
import backend.ClientPrefs;
import backend.CoolUtil;
import objects.BGSprite;

var mainLight:BGSprite;
var miniLight:BGSprite;
var hasLights:Bool = true;


function onCreate() {
    callOnLuas('addLuaFromHScript', ['scripts/hud/BatteryBar']);
    callOnLuas('addHScriptFromHScript', ['scripts/hud/BotNoteSkin']);
    
    var thingies:BGSprite = new BGSprite('factory/bright thingies', 88, 163, 0.95);
    addBehindGF(thingies);

    var darkMetal:BGSprite = new BGSprite('factory/darkmetal thingy', 193, 488, 0.95);
    addBehindGF(darkMetal);

    var metalThing:BGSprite = new BGSprite('factory/metal thingy', 32, 225);
    addBehindGF(metalThing);

    var hallWalls:BGSprite = new BGSprite('factory/hallwalls', 23, 393);
    addBehindGF(hallWalls);

    var hallFloor:BGSprite = new BGSprite('factory/hallfloor', 1, 815);
    addBehindGF(hallFloor);

    miniLight = new BGSprite('factory/hall light', 0, 373);
    addBehindGF(miniLight);

    var floor:BGSprite = new BGSprite('factory/floor', 0, 51);
    addBehindGF(floor);

    mainLight = new BGSprite('factory/main light', 29, 0);
    add(mainLight);

    var foreWires:BGSprite = new BGSprite('factory/foreground wires', 0, 51);
    add(foreWires);

    var foreThing:BGSprite = new BGSprite('factory/foreground thingy', 0, 989);
    add(foreThing);

    if (songName.toLowerCase() == 'megablast') {
        remove(mainLight);
        remove(miniLight);
        hasLights = false;

        thingies.color = darkMetal.color = metalThing.color = hallWalls.color = hallFloor.color = floor.color = foreWires.color = foreThing.color = CoolUtil.colorFromString('696969');
        camHUD.bgColor = 0x7F000000;
    }
}

function onCreatePost() {
    debugPrint(songName.toLowerCase());
    gfGroup.scrollFactor.set(1, 1);
    if (ClientPrefs.data.shaders) {
        switch(songName.toLowerCase()) {
            case 'megablast':
                callOnHScript('setDropShadowShader', [boyfriend, 110, 10, 1, 'BC8660', -10, -25, -75, -25]);
                callOnHScript('setDropShadowShader', [gf, 90, 10, 1,'BC8660', -10, -25, -75, -25]);
                callOnHScript('setDropShadowShader', [dad, 70, 10, 1, 'BC8660', -10, -25, -75, -25]);
            default:
                callOnHScript('setDropShadowShader', [boyfriend, 110, 10, 1, 'FFB780', -10, 0, -50, -35]);
                callOnHScript('setDropShadowShader', [gf, 90, 10, 1,'FFB780', -10, 0, -35, -25]);
                callOnHScript('setDropShadowShader', [dad, 70, 10, 1, 'FFB780', -10, 0, -50, -35]);
        }
    }
}

function onBeatHit() {
    if (curBeat % 3 == 0 && FlxG.random.bool(25) && ClientPrefs.data.flashing && hasLights) {
        mainLight.visible = false;
        boyfriend.color = gf.color = dad.color = CoolUtil.colorFromString('BBB8B4');
        new FlxTimer().start(FlxG.random.float(0.1, 0.5), ()->{ 
            mainLight.visible = true;
            boyfriend.color = gf.color = dad.color = CoolUtil.colorFromString('FFFFFF');
            new FlxTimer().start(0.1, ()->{
                if (FlxG.random.bool(5)) {
                    mainLight.visible = true;
                    boyfriend.color = gf.color = dad.color = CoolUtil.colorFromString('BBB8B4');
                    new FlxTimer().start(FlxG.random.float(0.03, 0.2), ()->{ 
                        mainLight.visible = true;
                        boyfriend.color = gf.color = dad.color = CoolUtil.colorFromString('FFFFFF');
                    });
                }
            });
        });
    }
    if (curBeat % 2 == 0 && FlxG.random.bool(16) && ClientPrefs.data.flashing && hasLights) {
        miniLight.visible = false;
        new FlxTimer().start(FlxG.random.float(0.4, 1.2), ()->{
            mainLight.visible = true;
        });
    }
}