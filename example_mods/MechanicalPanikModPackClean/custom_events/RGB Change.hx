import backend.MusicBeatState;
import backend.ClientPrefs;
import backend.CoolUtil;

MusicBeatState.getVariables().set('Default', [
    [
        StringTools.hex(ClientPrefs.data.arrowRGB[0][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[0][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[0][2] & 0xFFFFFF, 6)
    ],
    [
        StringTools.hex(ClientPrefs.data.arrowRGB[1][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[1][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[1][2] & 0xFFFFFF, 6)
    ],
    [
        StringTools.hex(ClientPrefs.data.arrowRGB[2][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[2][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[2][2] & 0xFFFFFF, 6)
    ],
    [
        StringTools.hex(ClientPrefs.data.arrowRGB[3][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[3][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGB[3][2] & 0xFFFFFF, 6)
    ]
]);

MusicBeatState.getVariables().set('Default Pixel', [
    [
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[0][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[0][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[0][2] & 0xFFFFFF, 6)
    ],
    [
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[1][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[1][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[1][2] & 0xFFFFFF, 6)
    ],
    [
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[2][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[2][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[2][2] & 0xFFFFFF, 6)
    ],
    [
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[3][0] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[3][1] & 0xFFFFFF, 6),
        StringTools.hex(ClientPrefs.data.arrowRGBPixel[3][2] & 0xFFFFFF, 6)
    ]
]);

MusicBeatState.getVariables().set('BW', [['414141', '8E8E8E', '171717'], ['414141', '8E8E8E', '171717'], ['414141', '8E8E8E', '171717'], ['414141', '8E8E8E', '171717']]);

var lastPlayerRGB:Array<Array<String>> = MusicBeatState.getVariables().get((PlayState.isPixelStage ? 'Default Pixel' : 'Default'));
var lastOpponentRGB:Array<Array<String>> = lastPlayerRGB;

var curPlayerRGB:Array<Array<String>> = lastPlayerRGB;
var curOpponentRGB:Array<Array<String>> = lastOpponentRGB;

function onSpawnNote(note:Note) {
    if (PlayState.SONG.disableNoteRGB) return;

    var rgb:Array<Array<String>> = note.mustPress ? curPlayerRGB : curOpponentRGB;
    var lastRGB:Array<Array<String>> = note.mustPress ? lastPlayerRGB : lastOpponentRGB;

    if (rgb == null || lastRGB == null) return;

    if (note.rgbShader.r == CoolUtil.colorFromString(lastRGB[note.noteData][0])) {
        note.rgbShader.r = CoolUtil.colorFromString(rgb[note.noteData][0]);
        note.noteSplashData.r = CoolUtil.colorFromString(rgb[note.noteData][0]);
    }

    if (note.rgbShader.g == CoolUtil.colorFromString(lastRGB[note.noteData][1])) {
        note.rgbShader.g = CoolUtil.colorFromString(rgb[note.noteData][1]);
        note.noteSplashData.g = CoolUtil.colorFromString(rgb[note.noteData][1]);
    }

    if (note.rgbShader.b == CoolUtil.colorFromString(lastRGB[note.noteData][2])) {
        note.rgbShader.b = CoolUtil.colorFromString(rgb[note.noteData][2]);
        note.noteSplashData.b = CoolUtil.colorFromString(rgb[note.noteData][2]);
    }
}

function onEvent(eventName:String, value1:String, value2:String, strumTime:Float) {

    if (eventName == 'RGB Change') {
        if (value1.toLowerCase() == 'player') updateNotes(true, value2);
        else if (value1.toLowerCase() == 'opponent') updateNotes(false, value2);
        else {
            updateNotes(true, value2);
            updateNotes(false, value2);
        }

    } else if (eventName == 'Add RGB Table') {
        var newArray:Array<String> = value2.split(',');

        MusicBeatState.getVariables().set(value1, [
            [(newArray[0] != null ? newArray[0] : 'FF0000'), (newArray[1] != null ? newArray[1] : '00FF00'), (newArray[2] != null ? newArray[2] : '0000FF')],
            [(newArray[3] != null ? newArray[3] : 'FF0000'), (newArray[4] != null ? newArray[4] : '00FF00'), (newArray[5] != null ? newArray[5] : '0000FF')],
            [(newArray[6] != null ? newArray[6] : 'FF0000'), (newArray[7] != null ? newArray[7] : '00FF00'), (newArray[8] != null ? newArray[8] : '0000FF')],
            [(newArray[9] != null ? newArray[9] : 'FF0000'), (newArray[10] != null ? newArray[10] : '00FF00'), (newArray[11] != null ? newArray[11] : '0000FF')]
        ]);
    }
}

function updateNotes(whoIs:Bool, colorSet:String) {
    var rgb:Array<Array<String>> = MusicBeatState.getVariables().get(colorSet);
    if (rgb == null || PlayState.SONG.disableNoteRGB) return;

    var oldRGB:Array<Array<String>> = whoIs ? lastPlayerRGB : lastOpponentRGB;

    for (strum in (whoIs ? playerStrums : opponentStrums)) {
        if (strum.rgbShader.r == CoolUtil.colorFromString(oldRGB[strum.noteData][0]))
            strum.rgbShader.r = CoolUtil.colorFromString(rgb[strum.noteData][0]);

        if (strum.rgbShader.g == CoolUtil.colorFromString(oldRGB[strum.noteData][1]))
            strum.rgbShader.g = CoolUtil.colorFromString(rgb[strum.noteData][1]);

        if (strum.rgbShader.b == CoolUtil.colorFromString(oldRGB[strum.noteData][2]))
            strum.rgbShader.b = CoolUtil.colorFromString(rgb[strum.noteData][2]);

        strum.playAnim("static", true);
    }

    for (note in notes) {
        if (note.mustPress == whoIs) {

            if (note.rgbShader.r == CoolUtil.colorFromString(oldRGB[note.noteData][0])) {
                note.rgbShader.r = CoolUtil.colorFromString(rgb[note.noteData][0]);
                note.noteSplashData.r = CoolUtil.colorFromString(rgb[note.noteData][0]);
            }

            if (note.rgbShader.g == CoolUtil.colorFromString(oldRGB[note.noteData][1])) {
                note.rgbShader.g = CoolUtil.colorFromString(rgb[note.noteData][1]);
                note.noteSplashData.g = CoolUtil.colorFromString(rgb[note.noteData][1]);
            }

            if (note.rgbShader.b == CoolUtil.colorFromString(oldRGB[note.noteData][2])) {
                note.rgbShader.b = CoolUtil.colorFromString(rgb[note.noteData][2]);
                note.noteSplashData.b = CoolUtil.colorFromString(rgb[note.noteData][2]);
            }
        }
    }

    if (whoIs) {
        lastPlayerRGB = curPlayerRGB;
        curPlayerRGB = rgb;
    } else {
        lastOpponentRGB = curOpponentRGB;
        curOpponentRGB = rgb;
    }
}