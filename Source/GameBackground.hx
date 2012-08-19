package;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxGroup;

class GameBackground extends FlxGroup 
{
	public function new() 
	{
		super();

        var back1_1:BG = new BG(0, -100);
        var back1_2:BG = new BG(FlxG.width, -100);

        back1_1.scrollFactor = new FlxPoint(0.019, 0);
        back1_2.scrollFactor = new FlxPoint(0.019, 0);

        var back2_1:BG = new BG(0, FlxG.height - 22 - 185);
        var back2_2:BG = new BG(FlxG.width, FlxG.height - 22 - 185);

        back2_1.scrollFactor = new FlxPoint(0.29, 0);
        back2_2.scrollFactor = new FlxPoint(0.29, 0);

        var ground_1:BG = new BG(0, FlxG.height - 22);
        var ground_2:BG = new BG(FlxG.width, FlxG.height - 22);

        back1_1.loadGraphic("assets/png/sky1.png");
        back1_2.loadGraphic("assets/png/sky1.png");

        back2_1.loadGraphic("assets/png/mountains1.png");
        back2_2.loadGraphic("assets/png/mountains2.png");

        ground_1.loadGraphic("assets/png/ground.png");
        ground_2.loadGraphic("assets/png/ground.png");
        ground_1.scale.x = 1.02;

        this.add(back1_1);
        this.add(back1_2);
        this.add(back2_1);
        this.add(back2_2);
        this.add(ground_1);
        this.add(ground_2);
	}

	override public function update():Void 
	{
	    super.update();
    }
}
