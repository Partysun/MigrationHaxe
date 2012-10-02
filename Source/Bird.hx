package;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;

class Bird extends FlxSprite 
{
    private var jumpLimit:Float = 0;
    private var jump:Float = 0;
    private var lassitude:Float = 0.0;
    private var maxLassitude:Float = 3.0;
    private var stunning:Float = 0.0;
    private var maxStunning:Float = 1.0;

    private static var DOWNFORCE:Int = 80;

	public function new(x:Float, y:Float) 
	{
		super(x, y);

	    loadGraphic("assets/png/bat.png", true, true, 30, 40);
		addAnimation("fly", [0, 1], 6);

		velocity.x = 20;
        acceleration.y = DOWNFORCE;
        acceleration.x = 20;
                
        maxVelocity.x = 600;
        maxVelocity.y = 320;

        elasticity = 0.0;
        jump = 0;
    }

	override public function update():Void 
	{
		play("fly");

        if (velocity.x < 0) velocity.x = 0;
        else if (velocity.x < 100) acceleration.x = 36;
        else if (velocity.x < 250) acceleration.x = 24;
        else if (velocity.x < 400) acceleration.x = 12;
        else if (velocity.x < 600) acceleration.x = 6;
        else acceleration.x = 4;

        acceleration.y = DOWNFORCE;
        jump = 0;

        //jumping
        jumpLimit = velocity.x / (maxVelocity.x * 2.5);
        if (jumpLimit > 0.35) jumpLimit = 0.35;

        //if (touching == FlxObject.FLOOR)
          //jump = 0;
        if (lassitude > 0)
            lassitude -= FlxG.elapsed;
        else
            lassitude = 0;

        if (stunning > 0)
        {
            stunning -= FlxG.elapsed;
            jump = -1;
        }
        else
            stunning = 0;

        if (jump >= 0 && FlxG.keys.X) {
          lassitude = maxLassitude;
          jump += FlxG.elapsed;
          if (jump > jumpLimit) {
            jump = -1;
          }
        } else
          jump = -1;

        if (jump > 0) {
            if (jump < 0.08)
                velocity.y = -maxVelocity.y * 0.85;
            else
                velocity.y = -maxVelocity.y * 1.20;
            FlxG.watch(velocity, "y", "velocity.y");
            
        }
        if (FlxG.keys.justReleased("X"))
        {
            if (lassitude > 2.80)
                velocity.y = maxVelocity.y*0.5;
            //else if (lassitude > 2.25)
                //velocity.y = maxVelocity.y*0.25;  
            //else
                //velocity.y = maxVelocity.y*0.45;  
        }

        if (y < 10)
        {
            acceleration.y = acceleration.y * 3;
            velocity.y = maxVelocity.y*3;  
            FlxG.shake(0.01);
            stunning = maxStunning;
        }
        //FlxG.watch(this, "lassitude", "lassitude");
        //FlxG.watch(this, "jump", "jump");
		super.update();
	}
}
