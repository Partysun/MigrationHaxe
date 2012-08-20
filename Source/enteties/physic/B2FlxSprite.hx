package enteties.physic;

//import org.flixel.*;

import enteties.physic.PhysObject;

import box2D.dynamics.B2World;
//import box2D.collision.*;
//import box2D.collision.shapes.*;
import box2D.common.math.B2Vec2;

/**
 * @author Yura - 23.08.2011 16:49
 */
class B2FlxSprite extends PhysObject
{
    //Счетчик для сброса (зацикливания физического мира)
    private var countCycle:Int = 0;

    public function new(X:Float, Y:Float, Width:Float, Height:Float, World:B2World):Void
    {
        super(X, Y, Width, Height, World); 
        this.createBody();
    }

    override public function update():Void
    {
        super.update();
        
        if (_body.getPosition().x>40)
        {
            _body.setPosition(new B2Vec2(0, _body.getPosition().y));
            countCycle++;					
        }
        
        x = (_body.getPosition().x * ratio) - width / 2 + countCycle*1200;
        y = (_body.getPosition().y * ratio) - height / 2;
    }	
}	
