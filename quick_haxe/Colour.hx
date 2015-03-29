package quick_haxe;

class Colour
{
	public static function Random() : Int
	{
		var r:Int = Math.round(Math.random() * 0xFF);
		var g:Int = Math.round(Math.random() * 0xFF);
		var b:Int = Math.round(Math.random() * 0xFF);
		return r << 16 | g << 8 | b;
	}
	
}