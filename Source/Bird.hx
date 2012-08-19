package;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class Bird extends FlxSprite 
{
	public function new() 
	{
		super();
		velocity.x = 270;
	}

	override public function update():Void 
	{
		var control:String = "keyboard";
		
	    loadGraphic("assets/png/bird.png");
		
		//velocity.x = 0;
		//velocity.y = 0;
		
		if (FlxG.keys.LEFT && control == "keyboard") 
		{
			velocity.x = -270;
		}
		else if (FlxG.keys.RIGHT && control == "keyboard") 
		{
			velocity.x = 270;
		}
		if (FlxG.keys.UP && control == "keyboard") 
		{
			velocity.y = -270;
		}
		else if (FlxG.keys.DOWN && control == "keyboard") 
		{
			velocity.y = 270;
		}
		
		super.update();
		
		/*if (x > FlxG.width - width - 10) */
		//{
			//x = FlxG.width - width - 10;
		//}
		//else if (x < 10) 
		//{
			//x = 10;
		//}
		//if (y > FlxG.height - height - 10) 
		//{
			//y = FlxG.height - height - 10;
		//}
		//else if (y < 10) 
		//{
			//y = 10;
		/*}*/
	}
	
}