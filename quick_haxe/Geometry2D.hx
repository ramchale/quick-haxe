package quick_haxe;

typedef Point2D = {
	var x : Int;
	var y : Int;
};

typedef Rectangle2D = {
	var minX: Float;
	var maxX: Float;
	var minY: Float;
	var maxY: Float;
};

class Geometry2D 
{
	
	/**
	 * Get the distance squared between two points 
	 * (more computationally efficient than getting the unsquared distance as it does not need to  calculate the square root)
	 * @param	aX 	Point A - X Position
	 * @param	ay	Point A - Y Position
	 * @param	bx	Point B - X Position
	 * @param	by	Point B - Y Position
	 * @return	squared distance between the two objects
	 */
	public static inline function distanceSquared(aX:Float, aY:Float, bX:Float, bY:Float) : Float
	{
		return Math.pow(aX - bX, 2) + Math.pow(aY - bY, 2);
	}
	
	/**
	 * Get the distance between two points 
	 * @param	aX 	Point A - X Position
	 * @param	ay	Point A - Y Position
	 * @param	bx	Point B - X Position
	 * @param	by	Point B - Y Position
	 * @return	distance between the two points
	 */
	public static inline function distance(aX:Float, aY:Float, bX:Float, bY:Float) : Float
	{
		return Math.sqrt(Math.pow(aX - bX, 2) + Math.pow(aY - bY, 2));
	}
	
	/**
	 * Get the angle in radians from point A to point B
	 * (Angle is from the y axis)
	 * @param	aX 	Point A - X Position
	 * @param	ay	Point A - Y Position
	 * @param	bx	Point B - X Position
	 * @param	by	Point B - Y Position
	 * @return	squared distance between the two objects
	 */
	public static inline function angleFromAtoB(aX:Float, aY:Float, bX:Float, bY:Float) : Float
	{
		return Math.atan2(bX - aX, bY - aY);
	}
	
	public static inline function isPolygonOrderedClockwise(points:Array<Point2D>) : Bool
	{
		var sum:Float = 0.0;
    
		for (i in 0 ... points.length) 
		{
			var v1 = points[i];
			var v2 = points[(i + 1) % points.length];
			sum += (v2.x - v1.x) * (v2.y + v1.y);
		}
    
		return sum > 0.0;
	}
}