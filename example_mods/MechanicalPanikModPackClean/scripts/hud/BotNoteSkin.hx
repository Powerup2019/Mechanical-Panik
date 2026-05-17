import objects.Note;
import backend.Paths;

var ogSkin:String = PlayState.SONG.arrowSkin;

function onCreate() {
    if (Paths.fileExists((ClientPrefs.data.noteSkin == 'Default' ? 'images/noteSkins/NOTE_assets-default-bot.png' : 'images/noteSkins/NOTE_assets' + Note.getNoteSkinPostfix() + '-bot.png'))) {
        PlayState.SONG.arrowSkin = ClientPrefs.data.noteSkin == 'Default' ? 'noteSkins/NOTE_assets-default-bot' : 'noteSkins/NOTE_assets' + Note.getNoteSkinPostfix() + '-bot';
    }
}

function onDestroy() {
    PlayState.SONG.arrowSkin = ogSkin;
}