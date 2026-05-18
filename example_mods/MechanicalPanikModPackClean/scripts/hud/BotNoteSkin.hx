import objects.Note;
import backend.Paths;
import backend.ClientPrefs;

var ogSkin:String = PlayState.SONG.arrowSkin;

function onCreate() {
    if (Paths.fileExists((ClientPrefs.data.noteSkin == 'Default' ? 'images/noteSkins/NOTE_assets-default-bot.png' : 'images/noteSkins/NOTE_assets' + Note.getNoteSkinPostfix() + '-bot.png'))) {
        PlayState.SONG.arrowSkin = ClientPrefs.data.noteSkin == 'Default' ? 'noteSkins/NOTE_assets-default-bot' : 'noteSkins/NOTE_assets' + Note.getNoteSkinPostfix() + '-bot';
    }
}

function onDestroy() {
    PlayState.SONG.arrowSkin = ogSkin;
}

function onUpdate(elapsed:Float) {
    for (strum in playerStrums) {
        strum.resetAnim = 99;
        if (strum.animation.curAnim.finished) strum.playAnim('static');
    }
    for (strum in opponentStrums) {
        strum.resetAnim = 99;
        if (strum.animation.curAnim.finished) strum.playAnim('static');
    }
}

function onKeyReleasePre(key:Int) {
    return Function_Stop;
}