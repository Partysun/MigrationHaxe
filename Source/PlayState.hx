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

import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import box2D.collision.B2AABB;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2Body;

import enteties.physic.B2FlxTileBlock;

class PlayState extends FlxState 
{
	public var gameover:Bool = false;
    public var _world:B2World;
    //private var plane:Plane;
	
	private var _bird:Bird;
	private var _cats:FlxGroup;
	private var _spawnTimer:Float;
	private var _spawnInterval:Float = 4.5;
	private var _scoreText:FlxText;
	private var _gameOverText:FlxText;
	
	override public function create():Void 
	{
		FlxG.mouse.hide();
        add(new GameBackground());
		
		_cats = new FlxGroup();
		add(_cats);
		
		resetSpawnTimer();
		
		//FlxG.playMusic("NyanCat");
        //Создаем физический мир
        setupWorld();
        var block1 = new B2FlxTileBlock(0, GameManager.levelHeight - 50, 1280, 50, _world);
        add(block1);
        block1.visible = false;
        //// Создаем главны игровой объект
        _bird = new Bird(_world, 50, GameManager.levelHeight - 70);
		add(_bird);

        FlxG.camera.follow(_bird);
        FlxG.camera.setBounds(0, 0, 32000000, FlxG.height);
                  
		super.create();
	}
    
    private function setupWorld():Void
    {
        var gravity:B2Vec2 = new B2Vec2(0, 5);
        _world = new B2World(gravity, true);
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
