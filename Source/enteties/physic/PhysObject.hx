package enteties.physic;
import org.flixel.FlxSprite;

import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2CircleShape;

/**
 * Игровой объект имеющий физику.
 * @author Yura - 30.08.2011 12:45
 */
class PhysObject extends FlxSprite
{ 
    public var _fixDef:B2FixtureDef;
    public var _bodyDef:B2BodyDef;
    // Body
    public var _body:B2Body;
    //Physics params default value
    //Трение
    public var _friction:Float = 1;
    // Упругость
    public var _restitution:Float = 0.05;
    // Плотность
    public var _density:Float = 3; 
    //Default angle
    public var _angle:Float = 0;
    //Default body type
    private var _type:Int = 2;//B2Body.b2_dynamicBody;		
    // Синхронизировать угол поворота физического объекта с графическим представление
    private var isB2AngleSynchronized:Bool = true;
    // Мир в котором существует физический объект
    private var _world:B2World; 
    // Warning: ratio from GameManager
    private var ratio:Int = 30;//GameManager.RATIO;
    
    public function new(X:Float, Y:Float, Width:Float, Height:Float, World:B2World) 
    {
        // Создаем графическую оболочку
        super(X, Y);
        
        width = Width;
        height = Height;			
        _world = World;			
    }
    
    // Синхронизирует угол визуального  игрового объект с физическим
    override public function update():Void 
    {
        super.update();
        if(isB2AngleSynchronized)
            angle = _body.getAngle() * (180 / Math.PI);
    }
    
    // Создаем физическое Body игрового объекта
    public function createBody():Void
    {            
        _fixDef = new B2FixtureDef();
        _fixDef.density = _density;
        _fixDef.restitution = _restitution;
        _fixDef.friction = _friction;                                   
        _fixDef.shape = new B2CircleShape(width/2/ratio);

        _bodyDef = new B2BodyDef();
        _bodyDef.position.set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
        _bodyDef.angle = _angle * (Math.PI / 180);	
        _bodyDef.type = _type;		
        _bodyDef.angularDamping = 5;

        _body = _world.createBody(_bodyDef);			
        _body.createFixture(_fixDef);		
    }
}
