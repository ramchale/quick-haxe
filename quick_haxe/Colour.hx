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
	
	public static function GetRed(colour:Int) : Int
	{
		return 0;
	}
	
	public static function GetGreen(colour:Int) : Int
	{
		return 0;
	}
	
	public static function GetBlue(colour:Int) : Int
	{
		return 0;
	}
}