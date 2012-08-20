package utils;

import org.flixel.FlxSprite;
import org.flixel.FlxPoint;

class BasicUtils 
{
    /**
     * Sets the x/y velocity on the source FlxSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
     * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
     * Timings are approximate due to the way Flash timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
     * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
     * 
     * @param   source      The FlxSprite to move
     * @param   target      The FlxPoint coordinates to move the source FlxSprite towards
     * @param   speed       The speed it will move, in pixels per second (default is 60 pixels/sec)
     */
    public static function moveTowardsPoint(source:FlxSprite, target:FlxPoint, ?speed:Int = 60):Void
    {
        var a:Float = angleBetweenPoint(source, target);

        source.velocity.x = Math.cos(a) * speed;
        source.velocity.y = Math.sin(a) * speed;
    }

    /**
     * Find the distance (in pixels, rounded) from    an FlxSprite to the given FlxPoint, taking the source origin into account
     * 
     * @paramaThe first FlxSprite
     * @paramtargetThe FlxPoint
     * @returnintDistance (in pixels)
     */
    public static function distanceToPoint(a:FlxSprite, target:FlxPoint):Int
    {
      var dx:Float = (a.x + a.origin.x) - (target.x);
      var dy:Float = (a.y + a.origin.y) - (target.y);

      return cast(vectorLength(dx, dy), Int);
    }

    /**
    * Finds the length of the given vector
    * 
    * @param   dx
    * @param   dy
    * 
    * @return
    */
    public static function vectorLength(dx:Float, dy:Float):Float
    {
        return Math.sqrt(dx * dx + dy * dy);
    }

    /*
     * Find the angle (in radians) between an FlxSprite and an FlxPoint. The source sprite takes its x/y and origin into account.
     * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
     * 
     * @param   a           The FlxSprite to test from
     * @param   target      The FlxPoint to angle the FlxSprite towards
     * @param   asDegrees   If you need the value in degrees instead of radians, set to true
     * 
     * @return  Number The angle (in radians unless asDegrees is true)
     */
    public static function angleBetweenPoint(a:FlxSprite, target:FlxPoint):Float
    {
        var dx:Float = (target.x) - (a.x + a.origin.x);
        var dy:Float = (target.y) - (a.y + a.origin.y);

        return Math.atan2(dy, dx);
    }
}
