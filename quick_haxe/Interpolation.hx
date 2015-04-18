package quick_haxe;

class Interpolation
{

	public function new() 
	{
		
	}
	
	static inline public function linear (start:Float, end:Float, normalisedTime:Float)
	{
		return ((end - start) * normalisedTime) + start;
	}
		
}