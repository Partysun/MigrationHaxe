package; 

import org.flixel.FlxSprite;
import org.flixel.FlxG;

/**
 * @author Yura
 */

class LandObject extends FlxSprite
{
    public static var ROOF:Int = 0;
    public static var PHARMACY:Int = 1;
    public static var HOUSE_MEDIUM:Int = 2;
    public static var PHARMACY_2:Int = 3;
    public static var HOUSE_MEDIUM_2:Int = 4;
   
    public function new(x:Int = 0, y:Int = 0, type:Int = 0) 
    {
        super(x, y);
        switch (type) 
        {
            case LandObject.ROOF:
                loadGraphic("assets/png/roof_room.png");
            case LandObject.PHARMACY:
                loadGraphic("assets/png/pharmacy.png");
            case LandObject.HOUSE_MEDIUM:
                loadGraphic("assets/png/house_medium.png");
            case LandObject.PHARMACY_2:
                loadGraphic("assets/png/pharmacy_02.png");
            case LandObject.HOUSE_MEDIUM_2:
                loadGraphic("assets/png/house_medium_02.png");
            default:
                loadGraphic("assets/png/roof_room.png");
        }
        kill();
    }
    
    override public function update():Void 
    {
        super.update();
        if (!this.onScreen() && (GameManager.player.x - this.x) > 0 && this.alive)
            kill();
    }
}
