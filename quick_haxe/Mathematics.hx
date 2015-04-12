package quick_haxe;

class Mathematics
{
	public inline static function radiansToDegrees(angle:Float):Float
	{
		return 180 / Math.PI * angle;
	}
	
	public inline static function degreesToRadians(angle:Float):Float
	{
		return Math.PI / 180 * angle;
	}
	
	public inline static function modularDifference(a:Float, b:Float, mod:Float):Float
	{
		var result:Float = (a - b) % mod;
		if (result < 0) return result + mod;
		else return result;
	}
}