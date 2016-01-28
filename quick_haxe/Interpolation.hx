package quick_haxe;

/**
* A colletion of static methods for handling interpolation
**/
class Interpolation
{
	/**
	* Linearly interpolated value
	*
	* @param	start	Start value
	* @param	end		End value
	* @param	normalisedTime		Normalised time (0 to 1)
	*
	* @return	Interpolated value
	**/
	public inline static function linear (start:Float, end:Float, normalisedTime:Float)
	{
		return ((end - start) * normalisedTime) + start;
	}

}
