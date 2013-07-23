package;

import org.flixel.FlxG;
import org.flixel.util.FlxPoint;
import org.flixel.FlxSprite;

class BG extends FlxSprite 
{
	public function new(?X: Float = 0, ?Y: Float = 0) 
	{
		super(X, Y);
	}

	override public function update():Void 
	{
		super.update();

        var _point:FlxPoint = this.getScreenXY();
        if (_point.x + this.width < 0) {
            x += FlxG.camera.width*2;
        }
	}
}
