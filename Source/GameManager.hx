package;  

//import enteties.Plane;
import org.flixel.FlxSound;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxGroup;
import org.flixel.FlxCamera;
import org.flixel.FlxG;	
import box2D.dynamics.B2World;

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
    
    public static var RATIO:Int = 30;		
    
    public static var gameCondition:Int = STOPED;
    //public static var player:Plane;	
    public static var countTime: Int;		
    private static var _volume:Float = 0.5;
    private static var _musicVolume:Float = 0.6;
    public static var world:B2World;

    public static var levelWidth:Int = 480;
    public static var levelHeight:Int = 320; 
    
    public function GameManager() 
    {						
    }
    
    static public function init():Void
    {			
        // Устанавливаем игровое состояние в начальное
        GameManager.gameCondition = GameManager.STOPED;
    }
    
    /**
     * Очищаем Игровой Менеджер. Освобождаем память.
     */
    static public function clear():Void
    {
        //player = null;		
    }
}
