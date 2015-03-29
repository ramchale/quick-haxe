package quick_haxe;

import openfl.display.GraphicsPathCommand;
import openfl.display.Sprite;

class Drawing
{
	public static function DrawPath(sprite:Sprite, coordinates:Array<Float>, colour:Int = 0xFFFFFF, thickness:Float = 1) : Void
	{
		var commands:Array<Int> = new Array<Int>();
		
		for (i in 0...cast(coordinates.length / 2, Int))
		{
			if (commands.length > 0)
			{
				commands.push(GraphicsPathCommand.LINE_TO);
			}
			else
			{
				commands.push(GraphicsPathCommand.MOVE_TO);
			}
		}
		
		sprite.graphics.lineStyle(thickness, colour);
		sprite.graphics.drawPath(commands, coordinates);
	}
	
}