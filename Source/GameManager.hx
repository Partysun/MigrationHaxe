package;  

import org.flixel.FlxSound;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxGroup;
import org.flixel.FlxCamera;
import org.flixel.FlxG;	

/**
 * Класс глобальной видимости из любой точки проекта.
 * Можно получить сведения об игроке и камере и других нужных штуках.
 * @author Yura
 */
class GameManager 
{	
    public static var STOPED:Int = 0;
    public static var RUNNING:Int = 1;
    public static var WIN:Int = 2;
    public static var FAILED:Int = 3;
    public static var END:Int = 4;
    
    public static var RATIO:Int = 24;		
    
    public static var gameCondition:Int = STOPED;
    public static var player:Bird;	
    public static var countTime: Int;		
    private static var _volume:Float = 0.5;
    private static var _musicVolume:Float = 0.6;

    public static var levelWidth:Int = 480;
    public static var levelHeight:Int = 320; 

    public static var landManager:LandObjectManager; 
    private static var lastLandObj:Float = 0;
    
    public function GameManager() 
    {						
    }
    
    static public function init():Void
    {			
        // Устанавливаем игровое состояние в начальное
        GameManager.gameCondition = GameManager.STOPED;
        //Создаем Менеджер объектов фона
        GameManager.landManager = new LandObjectManager();
        createLandObjects();
    }

    static public function createLandObjects():Void {
        for (i in 0...GameManager.landManager.countDead())
        {
          reviveLandObject();
        }
    }

    static public function reviveLandObject():Void {
          var temp:LandObject = cast(GameManager.landManager.getFirstDead(), LandObject);
          temp.x = GameManager.lastLandObj + Math.random() * 25 + 2;
          temp.y = FlxG.height - 22 - temp.height;
          GameManager.lastLandObj = temp.x + temp.width;
          temp.revive();
    }
    
    /**
     * Очищаем Игровой Менеджер. Освобождаем память.
     */
    static public function clear():Void
    {
        player = null;		
    }
}
