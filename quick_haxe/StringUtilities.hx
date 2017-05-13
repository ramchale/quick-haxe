package quick_haxe;

class StringUtilities
{
	/**
	 * For converting a float to string with a specifed number of decimal places
	 * @param	value	The float to convert
	 * @param	decimalPlaces	The number of decimal places to show
	 * @return	A string representing the float to the desired number of places
	 */
	public static function toString(value:Float, decimalPlaces:Int) : String
	{
		var floatString:String = Std.string(value);
		
		var indexOfPoint = floatString.indexOf(".");
		
		if (indexOfPoint < 0)
		{
			indexOfPoint = floatString.length;
			floatString += ".";
		}
		
		if (decimalPlaces > 0)
		{
			var desiredLength = indexOfPoint + decimalPlaces + 1;
			
			// Pad with zeros or chop the string as needed
			return StringTools.rpad(floatString, "0", desiredLength).substring(0, desiredLength);
		}
		else
		{
			// If zero places required chop off the decimal point as well
			return floatString.substring(0, indexOfPoint);
		}
	}	
}