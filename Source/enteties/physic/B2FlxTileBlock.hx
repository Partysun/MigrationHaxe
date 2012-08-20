package enteties.physic;

import org.flixel.FlxSprite;
import org.flixel.FlxTileblock;

import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import box2D.collision.shapes.B2PolygonShape;


/**
 * Box2d FlxTileBlock
 * @author Yura - 23.08.2011 15:08
 */
class B2FlxTileBlock extends FlxSprite
{
    //[Embed(source = '../../../../../data/auto_tile.png')] private const AutoTileImg:Class;
    
    private var ratio:Float = 30;

    public var _fixDef:B2FixtureDef;
    public var _bodyDef:B2BodyDef;
    public var _obj:B2Body;
     
    //References			
    private var _world:B2World;
     
    //Physics params default value
    public var _friction:Float = 2;
    public var _restitution:Float = 0.3;
    public var _density:Float = 1;
     
    //Default angle
    public var _angle:Float = 0;
    //Default body type
    public var _type:Int = 0;//B2Body.B2_staticBody;

    public function new(X:Int , Y:Int ,Width:Int, Height:Int , w:B2World) 
    {
        super(X, Y);//, AutoTileImg);   
         _world = w;
        create();
    }
    
    private function create():Void 
    {	
        var boxShape:B2PolygonShape = new B2PolygonShape();
        boxShape.setAsBox((width/2) / ratio, (height/2) /ratio);            
     
        _fixDef = new B2FixtureDef();
        _fixDef.density = _density;
        _fixDef.restitution = _restitution;
        _fixDef.friction = _friction;            
        _fixDef.shape = boxShape;
     
        _bodyDef = new B2BodyDef();
        _bodyDef.position.set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
        _bodyDef.angle = _angle * (Math.PI / 180);
        _bodyDef.type = _type;			

        _obj = _world.createBody(_bodyDef);
        _obj.createFixture(_fixDef);
    }
}
