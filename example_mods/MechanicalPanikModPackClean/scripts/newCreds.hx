import backend.Paths;
import objects.HealthIcon;
import objects.Alphabet;

var json:Dynamic = callOnLuas('returnMetaData');
var credShit:Array<FlxSprite> = [];

function onCreate() {
    var Tv:FlxSprite = new FlxSprite(262.5, -485.75);
    Tv.frames = Paths.getSparrowAtlas('credits/Tv');
    Tv.animation.addByPrefix("idle", "Tv");
    Tv.animation.play("idle");
    add(Tv);
    credShit.push(Tv);

    var on:FlxSprite = new FlxSprite(275.7, -260.5);
    on.frames = Paths.getSparrowAtlas('credits/Tv');
    on.animation.addByPrefix("on", "turn on", 24, false);
    on.animation.play("on");
    on.visible = false;
    credShit.push(on);

    var composerText:Alphabet = new Alphabet(286.55, -251.15, 'Composers: ' + json.composer[0]);
    composerText.setScale(0.5, 0.5);
    credShit.push(composerText);
    add(composerText);
    composerText.visible = false;

    for (i in 0...json.composer[1].length) {
        var icon:FlxSprite = new FlxSprite(925.5 - (75 * i), -271.5);
        icon.loadGraphic(Paths.image(Paths.fileExists('images/credits/' + json.composer[1][i].toLowerCase() + '.png') ? 'credits/' + json.composer[1][i].toLowerCase() : 'credits/missing'));
        icon.scale.set(0.5, 0.5);
        icon.updateHitbox();
        icon.flipX = true;
        icon.cameras = [camHUD];
        icon.visible = false;
        add(icon);
        credShit.push(icon);
    }

    var coderText:Alphabet = new Alphabet(286.55, -195.15, 'Coders: ' + json.coder[0]);
    coderText.setScale(0.5, 0.5);
    credShit.push(coderText);
    add(coderText);
    coderText.visible = false;

    for (i in 0...json.coder[1].length) {
        var icon:FlxSprite = new FlxSprite(925.5 - (75 * i), -213.5);
        icon.loadGraphic(Paths.image(Paths.fileExists('images/credits/' + json.coder[1][i].toLowerCase() + '.png') ? 'credits/' + json.coder[1][i].toLowerCase() : 'credits/missing'));
        icon.scale.set(0.5, 0.5);
        icon.updateHitbox();
        icon.flipX = true;
        icon.cameras = [camHUD];
        icon.visible = false;
        add(icon);
        credShit.push(icon);
    }

    var artistText:Alphabet = new Alphabet(286.55, -137.95, 'Artists: ' + json.artist[0]);
    artistText.setScale(0.5, 0.5);
    credShit.push(artistText);
    add(artistText);
    artistText.visible = false;

    for (i in 0...json.artist[1].length) {
        var icon:FlxSprite = new FlxSprite(925.5 - (75 * i), -156.3);
        icon.loadGraphic(Paths.image(Paths.fileExists('images/credits/' + json.artist[1][i].toLowerCase() + '.png') ? 'credits/' + json.artist[1][i].toLowerCase() : 'credits/missing'));
        icon.scale.set(0.5, 0.5);
        icon.updateHitbox();
        icon.flipX = true;
        icon.cameras = [camHUD];
        icon.visible = false;
        add(icon);
        credShit.push(icon);
    }

    var charterText:Alphabet = new Alphabet(286.55, -78.05, 'Charters: ' + json.charter[0]);
    charterText.setScale(0.5, 0.5);
    credShit.push(charterText);
    add(charterText);
    charterText.visible = false;

    for (i in 0...json.charter[1].length) {
        var icon:FlxSprite = new FlxSprite(925.5 - (75 * i), -96.4);
        icon.loadGraphic(Paths.image(Paths.fileExists('images/credits/' + json.charter[1][i].toLowerCase() + '.png') ? 'credits/' + json.charter[1][i].toLowerCase() : 'credits/missing'));
        icon.scale.set(0.5, 0.5);
        icon.updateHitbox();
        icon.flipX = true;
        icon.cameras = [camHUD];
        icon.visible = false;
        add(icon);
        credShit.push(icon);
    }
    
    add(on);

    Tv.cameras = on.cameras = coderText.cameras = composerText.cameras = charterText.cameras = artistText.cameras = [camHUD];

    new FlxTimer().start(3.2, function(timer:FlxTimer)
    {
        on.animation.play("on");
        for (thing in credShit) thing.visible = true;
        new FlxTimer().start(4, function(timer:FlxTimer)
        {
            for (thing in credShit) {
                FlxTween.tween(thing, {y: thing.y - 436}, 0.7, {ease: FlxEase.quadOut});
            }
        });
    });

    for (thing in credShit) {
        FlxTween.tween(thing, {y: thing.y + 436}, 3.2, {ease: FlxEase.quadOut});
    }
    //-224.25
}