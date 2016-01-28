package quick_haxe;

/**
* A colletion of static methods for handling colours
**/
class Colour
{
	/**
	* Generate a random colour
	**/
	public inline static function random() : Int
	{
		var r:Int = Math.round(Math.random() * 0xFF);
		var g:Int = Math.round(Math.random() * 0xFF);
		var b:Int = Math.round(Math.random() * 0xFF);
		return r << 16 | g << 8 | b;
	}

	/**
	* Get the red compont of a colour
	* @param	colour	The colour to return the red part of
	*
	* @return	The red value, 0 to 255
	**/
	public inline static function getRed(colour:Int) : Int
	{
		return (colour & 0xFF0000) >> 16;
	}

	/**
	* Get the green compont of a colour
	* @param	colour	The colour to return the green part of
	*
	* @return	The green value, 0 to 255
	**/
	public inline static function getGreen(colour:Int) : Int
	{
		return (colour & 0xFF00) >> 8;
	}

	/**
	* Get the blue compont of a colour
	* @param	colour	The colour to return the blue part of
	*
	* @return	The blue value, 0 to 255
	**/
	public inline static function getBlue(colour:Int) : Int
	{
		return colour & 0xFF;
	}
}
