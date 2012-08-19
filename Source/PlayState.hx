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

class PlayState extends FlxState 
{
	public var gameover:Bool = false;
	
	private var _bird: Bird;
	private var _cats:FlxGroup;
	private var _spawnTimer:Float;
	private var _spawnInterval:Float = 4.5;
	private var _scoreText:FlxText;
	private var _gameOverText:FlxText;
	
	override public function create():Void 
	{
		FlxG.mouse.hide();
		//FlxG.camera.zoom = 2;
        add(new GameBackground());

		_bird = new Bird();
		add(_bird);
		
		_cats = new FlxGroup();
		add(_cats);
		
		resetSpawnTimer();
		
		//FlxG.score = 0;
		//_scoreText = new FlxText(10, 8, 200, "0");
		//_scoreText.setFormat(null, 32, 0xFFFFFF, "left");
		//add(_scoreText);
		
		//FlxG.playMusic("NyanCat");

		_bird.y = 120;
		_bird.x = 250;

        FlxG.camera.follow(_bird);
        FlxG.camera.setBounds(0, 0, 100000, FlxG.height);
                  
		super.create();
	}
	
	override public function update():Void 
	{	
		var control:String = "keyboard";
					
		_spawnTimer -= FlxG.elapsed;
		
		if (_spawnTimer < 0) 
		{
			spawnCat();
			resetSpawnTimer();
		}
		
		//FlxG.overlap(_cats, _bullets, overlapCatBullet);
		//FlxG.overlap(_cats, _bird, overlapCatShip);
		
		if (FlxG.keys.ENTER && !_bird.alive /*_bird.destroy*/) 
		{
			_bird.destroy();
			
			FlxG.switchState(new PlayState());
		}
		
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
