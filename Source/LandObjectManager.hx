package; 

import org.flixel.FlxGroup;
import org.flixel.FlxG;

/**
 * @author Yura
 */

class LandObjectManager extends FlxGroup
{
    public function new() 
    {
		super();
        for ( i in 0...2 ) 
        {
            add(new LandObject(0, 0, LandObject.ROOF));
            add(new LandObject(0, 0, LandObject.HOUSE_MEDIUM));
            add(new LandObject(0, 0, LandObject.HOUSE_MEDIUM_2));
            add(new LandObject(0, 0, LandObject.PHARMACY));
            add(new LandObject(0, 0, LandObject.PHARMACY_2));
        }
    }
    
    //public function getWaitingObject():LandObject
    //{
        //for (i in 0...this.members.length)
        //{
            //var temp:LandObject = cast(this.members[i], LandObject);
            //if (!temp.alive)
                //return temp;
        //}
        //return null;
    //}
}
