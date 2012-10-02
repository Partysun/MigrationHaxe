package;

import org.flixel.FlxEmitter;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxObject;
import org.flixel.FlxParticle;
import org.flixel.FlxPoint;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxCamera;
import org.flixel.FlxSprite;
import org.flixel.FlxTileblock;

class PlayState extends FlxState 
{
	public var gameover:Bool = false;
	
	private var _bird:Bird;
	private var _cats:FlxGroup;
	private var _spawnTimer:Float;
	private var _spawnInterval:Float = 4.5;
	private var _scoreText:FlxText;
	private var _gameOverText:FlxText;

	private var _back:GameBackground;
    //For collision, without some textures.
	private var _c_ground:FlxSprite;

	//private var _gameOverText:FlxText;
	
	override public function create():Void 
	{
        GameManager.init();
    	FlxG.mouse.hide();
        _back = new GameBackground();
        add(_back);
		
		FlxG.playMusic("Theme");
	    _c_ground = new FlxSprite(0, FlxG.height - 20);
        _c_ground.width = FlxG.camera.width;
        _c_ground.immovable = true;
        _c_ground.visible = false;
        add(_c_ground);

        var fx:FlxSprite = new FlxSprite(0, 0);
        fx.loadGraphic("assets/png/fx.png");
        fx.scrollFactor = new FlxPoint(0, 0);
        add(fx);

        var hud:FlxSprite = new FlxSprite(0, 0);
        hud.loadGraphic("assets/png/hud.png");
        hud.scrollFactor = new FlxPoint(0, 0);
        add(hud);

        add(GameManager.landManager);
        // Создаем главный игровой объект
        _bird = new Bird(50, FlxG.height - 200);
		add(_bird);
        GameManager.player = _bird;

        var light:FlxSprite = new FlxSprite(170, FlxG.height - 171);
        light.loadGraphic("assets/png/light.png");
        add(light);
        
        FlxG.camera.follow(_bird);
        FlxG.camera.setBounds(0, 0, 32000000, FlxG.height, true);
                  
        FlxG.flash();
		super.create();
	}
   
	override public function update():Void 
	{	
        // variable to handle enemy speed
        var bird_speed:Float;

        // variable to handle the speed offset:it's the ratio between
        // the real enemy speed and the minimum allowed speed
        var speed_offset:Float;
		//FlxG.camera.target.x = _bird.x - FlxG.width*0.5;
        //Выпускаем новый объект обстановки
        if (GameManager.landManager.countDead() > 0)
        {
            GameManager.reviveLandObject();  
        }
        //_c_ground.x = _bird.x;	
        FlxG.collide(_bird, _back.ground_1);
        FlxG.collide(_bird, _back.ground_2);

        //_bird.velocity = new FlxPoint(0, 0);
		if (FlxG.keys.ENTER && !_bird.alive) 
		{
			_bird.destroy();
			
			FlxG.switchState(new PlayState());
		}

        FlxG.watch(_bird, "x", "x:");
        FlxG.watch(_bird.acceleration, "x", "acceleration");
        FlxG.watch(_bird.velocity, "x", "velocity");

        super.update();
	}
	
	private function spawnCat():Void 
	{
		var x:Float = FlxG.width;
		var y:Float = Math.random() * (FlxG.height - 100) + 50;
		_cats.add(new Cat(x, y));
	}
	
	private function resetSpawnTimer():Void 
	{
		_spawnTimer = _spawnInterval;
		_spawnInterval = Math.random() * 1.45;
		if (_spawnInterval < 0.1) 
		{
			_spawnInterval = 0.1;
		}
	}
      
}
