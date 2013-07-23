package;

import flash.display.Sprite;
import flash.Lib;

/**
 * @author Partysun - yura.zatsepin@gmail.com
 */

class Main extends Sprite
{
	
	public static function main() 
	{
		new Main();
	}
	
	public function new() 
	{
		super();
		Lib.current.addChild(new Migration());
	}
}
