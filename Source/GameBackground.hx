package;

import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxGroup;

class GameBackground extends FlxGroup 
{
    public var ground_1:BG;
    public var ground_2:BG;

	public function new() 
	{
		super();

        var back1_1:BG = new BG(0, -100);
        var back1_2:BG = new BG(FlxG.width, -100);

        back1_1.scrollFactor = new FlxPoint(0.019, 0);
        back1_2.scrollFactor = new FlxPoint(0.019, 0);

        var back2_1:BG = new BG(0, FlxG.height - 24 - 235);
        var back2_2:BG = new BG(FlxG.width, FlxG.height - 24 - 235);

        back2_1.scrollFactor = new FlxPoint(0.36, 0);
        back2_2.scrollFactor = new FlxPoint(0.36, 0);

        var back3_1:BG = new BG(0, FlxG.height - 24 - 189);
        var back3_2:BG = new BG(FlxG.width, FlxG.height - 24 - 189);

        back3_1.scrollFactor = new FlxPoint(0.29, 0);
        back3_2.scrollFactor = new FlxPoint(0.29, 0);

        ground_1 = new BG(0, FlxG.height - 24);
        ground_2 = new BG(FlxG.width, FlxG.height - 24);

        var cloud_1:BG = new BG(Math.random() * 200 + 20, Math.random() * 80 + 5);
        var cloud_2:BG = new BG(Math.random() * 120 + 380, Math.random() * 80 + 5);
        var cloud_3:BG = new BG(Math.random() * 100 + 50, Math.random() * 40 + 5);
        var cloud_4:BG = new BG(Math.random() * 120 + 280, Math.random() * 40 + 5);

        cloud_1.scrollFactor = new FlxPoint(0.41, 0);
        cloud_2.scrollFactor = new FlxPoint(0.41, 0);
        cloud_3.scrollFactor = new FlxPoint(0.71, 0);
        cloud_4.scrollFactor = new FlxPoint(0.71, 0);

        back1_1.loadGraphic("assets/png/night_sky.png");
        back1_2.loadGraphic("assets/png/night_sky.png");

        back2_1.loadGraphic("assets/png/townback.png");
        back2_2.loadGraphic("assets/png/townback.png");

        back3_1.loadGraphic("assets/png/townback_first.png");
        back3_2.loadGraphic("assets/png/townback_first.png");

        ground_1.loadGraphic("assets/png/ground.png");
        ground_2.loadGraphic("assets/png/ground.png");

        cloud_1.loadGraphic("assets/png/cloud_night_1.png");
        cloud_2.loadGraphic("assets/png/cloud_night_2.png");
        cloud_3.loadGraphic("assets/png/cloud_night_2.png");
        cloud_4.loadGraphic("assets/png/cloud_night_1.png");
        //ground_1.scale.x = 1.02;

        ground_1.immovable = true;
        ground_2.immovable = true;

        this.add(back1_1);
        this.add(back1_2);

        var moon:FlxSprite = new FlxSprite(30, FlxG.height - 24 - 275);
        moon.loadGraphic("assets/png/moon.png");
        moon.scrollFactor.x = 0.0005;
        this.add(moon);

        // Clouds
        this.add(cloud_1);
        this.add(cloud_2);
        this.add(cloud_3);
        this.add(cloud_4);

        this.add(back3_1);
        this.add(back3_2);
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
