import flixel.math.FlxAngle;

import backend.MusicBeatState;

function setDropShadowShader(object:Dynamic, angle:Float, distance:Float, strength:Float, color:String, hue:Float, saturation:Float, brightness:Float, contrast:Float) {
    var shader:FlxRuntimeShader = new FlxRuntimeShader(Paths.getTextFromFile('shaders/DropShadowShader.frag'));
    shader.setFloat('ang', angle * (Math.PI / 180));
    shader.setFloat('dist', distance);
    shader.setFloat('str', strength);
    shader.setFloat('hue', hue);
    shader.setFloat('saturation', saturation);
    shader.setFloat('brightness', brightness);
    shader.setFloat('contrast', contrast);

    var colorA:Array<Int> = hexToRGB(color);
    shader.setFloatArray('dropColor', [colorA[0]/255, colorA[1]/255, colorA[2]/255]);

    if (Std.isOfType(object, 'String')) {
        object = MusicBeatState.getVariables().get(object);
    }

    object.shader = shader;

    object.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int)
    {
		if (object.shader != null) {
			object.shader.setFloatArray('uFrameBounds', [object.frame.uv.x, object.frame.uv.y, object.frame.uv.width, object.frame.uv.height]);
    		object.shader.setFloat('angOffset', object.frame.angle * FlxAngle.TO_RAD);
		}
    }
}

function hexToRGB(hex:String):Array<Int>
{
    var value = Std.parseInt("0x" + hex);

    var r = (value >> 16) & 0xFF;
    var g = (value >> 8) & 0xFF;
    var b = value & 0xFF;

    return [r, g, b];
}