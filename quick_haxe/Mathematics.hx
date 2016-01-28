package quick_haxe;

/**
* A colletion of useful math related static methods
**/
class Mathematics
{
	/**
	* Convert radians to degrees
	*
	* @param	angle	Angle in radians
	*
	* @return	Angle in degrees
	**/
	public inline static function radiansToDegrees(angle:Float):Float
	{
		return 180 / Math.PI * angle;
	}

	/**
	* Convert degrees to radians
	*
	* @param	angle	Angle in degrees
	*
	* @return	Angle in radians
	**/
	public inline static function degreesToRadians(angle:Float):Float
	{
		return Math.PI / 180 * angle;
	}

	/**
	* Subtract b from a using modular/clock arithmatic
	*
	* @param	a	Initial value
	* @param	b	Value to Subtract
	* @param	mod	Modulo (wrap around value)
	*
	* @return	Angle in radians
	**/
	public inline static function modularDifference(a:Float, b:Float, mod:Float):Float
	{
		var result:Float = (a - b) % mod;
		if (result < 0) return result + mod;
		else return result;
	}

	/**
	* Generate a random float. Greater than or equal to the the minimum value, and less than the maximum value.
	*
	* @param	min	The minimun to return
	* @param	maxish	The upper value that result will get near
	*
	* @return	A random integer
	**/
	public inline static function random(min:Float, maxish:Float) : Float
	{
		return (Math.random() * (maxish - min)) + min;
	}

	/**
	* Generate a random integer. Greater than or equal to the the minimum value, and less than or equal to the maximum value.
	*
	* @param	min	The minimun to return
	* @param	max	The maximum to return
	*
	* @return	A random float
	**/
	public inline static function randomInt(min:Float, max:Float) : Int
	{
		return Math.floor((Math.random() * (max + 1 - min)) + min);
	}
}
