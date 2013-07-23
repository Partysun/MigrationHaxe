package;

import org.flixel.FlxG;
import org.flixel.FlxGame;

class Migration extends FlxGame
{
	public function new()
	{
		super(480, 320, PlayState, 1, 60, 60);

        //#if iphone
		//super(320, 480, NyanState, 1, 60, 60);
        //#end

		#if !neko
		FlxG.bgColor = 0x00808080;
		#else
		FlxG.bgColor = {rgb: 0x808080, a: 0x00};
		#end

        //forceDebugger = true;
	}
}
