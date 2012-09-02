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
	
	private var _bird:Cat;
	private var _cats:FlxGroup;
	private var _spawnTimer:Float;
	private var _spawnInterval:Float = 4.5;
	private var _scoreText:FlxText;
	private var _gameOverText:FlxText;

	//private var _gameOverText:FlxText;
	
	override public function create():Void 
	{
		FlxG.mouse.hide();
        add(new GameBackground());
		
		_cats = new FlxGroup();
		//add(_cats);
		
		resetSpawnTimer();
		
		//FlxG.playMusic("NyanCat");

        //Создаем физический мир
        setupWorld();
        var ground = new B2FlxTileBlock(0, FlxG.height - 22, 960, 20, _world);
        add(ground);
        ground.visible = false;

        var h_house:FlxSprite = new FlxSprite(220, FlxG.height - 24 - 188);
        h_house.loadGraphic("assets/png/h_blue.png");
        add(h_house);

        var v_house:FlxSprite = new FlxSprite(320, FlxG.height - 24 - 151);
        v_house.loadGraphic("assets/png/h_violet.png");
        add(v_house);

        var moon:FlxSprite = new FlxSprite(30, FlxG.height - 24 - 275);
        moon.loadGraphic("assets/png/moon.png");
        add(moon);

        //Создаем главный игровой объект
        //_bird = new Bird(_world, 50, FlxG.height - 200);
        //add(_bird);

        // Создаем главный игровой объект
        _bird = new Cat(50, FlxG.height - 200);
		add(_bird);

        FlxG.camera.follow(_bird);
        FlxG.camera.setBounds(0, 0, 32000000, FlxG.height);
                  
		super.create();
	}
    
    private function setupWorld():Void
    {
        var gravity:B2Vec2 = new B2Vec2(0, 0.5);
        _world = new B2World(gravity, true);
    }
	
	override public function update():Void 
	{	
        // variable to handle enemy speed
        var bird_speed:Float;
        // variable to handle the speed offset:it's the ratio between
        // the real enemy speed and the minimum allowed speed
        var speed_offset:Float;
					
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

        // determining enemy speed
        //bird_speed = Math.abs(_bird._body.getLinearVelocity().x) + Math.abs(_bird._body.getLinearVelocity().y);
        //// if the speed is too slow... (lower than 10)
        //if (bird_speed < 8) {
            //// calculating the offset
            //speed_offset = 10 / bird_speed;
            //// multiplying the horizontal and vertical components of the speed
            //// by the offset
            //_bird._body.m_linearVelocity.x = _bird._body.getLinearVelocity().x*speed_offset;
            //_bird._body.m_linearVelocity.y = _bird._body.getLinearVelocity().y*speed_offset;
        //}

        //_world.step(FlxG.elapsed, 10, 10);
        //_world.clearForces();

        if (FlxG.keys.justPressed("X")) {
            FlxG.log("Up");
            //_bird._body.applyImpulse(new B2Vec2(0.0, -0.5), _bird._body.getWorldCenter());
        }
        
        //if (FlxG.keys.justReleased("X")) {
            //FlxG.log("Down");
            //_bird._body.applyImpulse(new B2Vec2(0.0, 0.5), _bird._body.getWorldCenter());
        //}

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
