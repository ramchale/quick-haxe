package quick_haxe.path;

typedef Point = {
	var x : Float;
	var y : Float;
}

class Path
{
	public var id:String;
	public var segments:Array<Segment> = new Array<Segment>();

	public function new() 
	{
		
	}
	
	//public static function CreatePathDrawing(path:Path) : Shape
	//{
		//var s:Shape = new Shape();
		//
		//var commands:Vector.<int> = new Vector.<int>();
		//var coordinates:Vector.<Float> = new Vector.<Float>();
		//
		//for (var segmentCounter:int = 0; segmentCounter < path.segments.length; segmentCounter++)
		//{
			//var segment:Segment = path.segments[segmentCounter];
			//
			//for (var pointCounter:int = 0; pointCounter < segment.points.length; pointCounter++)
			//{
				//var point:PathPoint = segment.points[pointCounter];
				//
				//if (commands.length > 0)
				//{
					//commands.push(GraphicsPathCommand.LINE_TO); //lineTo
				//}
				//else
				//{
					//commands.push(GraphicsPathCommand.MOVE_TO); //moveTo
				//}
				//
				//coordinates.push(point.x);
				//coordinates.push(point.y);
			//}
		//}
		//
		//s.graphics.lineStyle(2, 0xFFFF00);
		//s.graphics.drawPath(commands, coordinates);
		//
		//return s;
	//}
	
	
	//TODO - If you can think of a quicker way of doing this then that would be nice
	public function GetPosition(t:Float) : Point
	{
		var point:Point = null;
		
		if(segments != null && segments.length > 0)
		{
			// Find current segment
			for(currentSegment in segments)
			{
				var lastPoint:PathPoint = currentSegment.points[currentSegment.points.length - 1];
				
				//If t <= than the last point's t you found the right segment
				if (t <= lastPoint.precalculatedT) 
				{
					for (pathCounter in 0 ... currentSegment.points.length)
					{
						//interprolate pos between key frames
						//get key frame just before current t
						var i:Int = currentSegment.points.length - 1;
						while (currentSegment.points[i].precalculatedT > t && i > 0)
						{
							i--;
						}

						var scale:Float = (t - currentSegment.points[i].precalculatedT) / (currentSegment.points[i + 1].precalculatedT - currentSegment.points[i].precalculatedT);
						
						//X' = X1 + ((X2 - X1) * (tDiff / seDiff)
						point = {
							x: currentSegment.points[i].x + ((currentSegment.points[i + 1].x - currentSegment.points[i].x) * scale), 
							y: currentSegment.points[i].y + ((currentSegment.points[i + 1].y - currentSegment.points[i].y) * scale) 
						};
						
						break;
					}
					
					break;
				}	
			}

			
			if (point == null)
			{
				//if t passed end of path set pos to end of path
				var segment:Segment = segments[segments.length - 1];
				
				return { 
					x: segment.points[segment.points.length - 1].x, 
					y: segment.points[segment.points.length - 1].y 
				};
			}
		}
		
		if (point == null)
		{
			point = { x: 0, y: 0 };
		}
		
		return point;
	}
	
	public function CreateSegment(pointList:Array<PathPoint>) : Segment
	{
		var segment:Segment = new Segment();
		segment.points = pointList;
		this.segments.push(segment);
		
		RecalcTimeOffsets();
		
		return segment;
	}
		
	public function CreateSegmentFrom3PointBezierByInterval(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, fDuration:Float, fSampleInterval:Float) : Segment
	{
		if(fSampleInterval > fDuration) { fSampleInterval = fDuration; }
		
		//If the samples do not fit exactly into the elapsed time add an extra point for the end
		var numberOfpoints:Int = Std.int(fDuration / fSampleInterval);
		if((fDuration % fSampleInterval) > 0) { numberOfpoints++; }

		var pathpoints:Array<PathPoint> = new Array<PathPoint>();
		
		//sample points
		var fDurationCounter:Float = 0;
		var InvT:Float;
		var fScaledT:Float;
		var point:PathPoint;
		
		for (i in 0 ... numberOfpoints) {
			point = new PathPoint();
			
			fScaledT = fDurationCounter / fDuration;
			InvT = 1 - fScaledT;

			point.x = ((InvT * InvT) * x1) + 
			(2 * fScaledT * InvT * x2) + 
			((fScaledT * fScaledT) * x3);
			point.y = ((InvT * InvT) * y1) + 
			(2 * fScaledT * InvT * y2) + 
			((fScaledT * fScaledT) * y3);

			point.baseT = fDurationCounter;
			
			fDurationCounter += fSampleInterval;
			if(fDurationCounter > fDuration) fDurationCounter = fDuration;
			
			pathpoints.push(point);
		}
			
		//Redistribute the base time values to compensate for the way bezier curves distribute the points
		//calc total dist
		var fTotalDist:Float = 0;
		var xDiff:Float, yDiff:Float;
		for (i in 0 ... numberOfpoints)
		{
			xDiff = pathpoints[i].x - pathpoints[i - 1].x;
			yDiff = pathpoints[i].y - pathpoints[i - 1].y;

			fTotalDist += Math.sqrt((xDiff * xDiff) + (yDiff * yDiff));
		}
			
		var fTotalTime:Float = 0;

		//for each point t = (prev t + (dist from prevpoint / total dist)) * total duration
		for (i in 0 ... numberOfpoints)
		{
			xDiff = pathpoints[i].x - pathpoints[i - 1].x;
			yDiff = pathpoints[i].y - pathpoints[i - 1].y;

			fTotalTime += Math.sqrt((xDiff * xDiff) + (yDiff * yDiff)) / fTotalDist;
			pathpoints[i].baseT = fTotalTime * fDuration;
		}
		
		var segment:Segment = new Segment();
		segment.points = pathpoints;
		this.segments.push(segment);
		
		RecalcTimeOffsets();
		
		return segment;
	}
	
	public function CreateSegmentFrom4PointBezierByInterval(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float, fDuration:Float, fSampleInterval:Float) : Segment
	{
		if(fSampleInterval > fDuration) { fSampleInterval = fDuration; }
		
		//If the samples do not fit exactly into the elapsed time add an extra point for the end
		var numberOfpoints:Int = Std.int(fDuration / fSampleInterval);
		if((fDuration % fSampleInterval) > 0) { numberOfpoints++; }

		var pathpoints:Array<PathPoint> = new Array<PathPoint>();
		
		//sample points
		var fDurationCounter:Float = 0;
		var InvT:Float;
		var fScaledT:Float;
		var point:PathPoint;
		
		for (i in 0 ... numberOfpoints) {
			point = new PathPoint();
			
			fScaledT = fDurationCounter / fDuration;
			InvT = 1 - fScaledT;

			point.x = ((InvT * InvT * InvT) * x1) + 
			(3 * fScaledT * (InvT * InvT) * x2) + 
			(3 * (fScaledT * fScaledT) * InvT * x3) +
			((fScaledT * fScaledT * fScaledT) * x4);
			point.y = ((InvT * InvT * InvT) * y1) + 
			(3 * fScaledT * (InvT * InvT) * y2) + 
			(3 * (fScaledT * fScaledT) * InvT * y3) +
			((fScaledT * fScaledT * fScaledT) * y4);

			point.baseT = fDurationCounter;
			
			fDurationCounter += fSampleInterval;
			if(fDurationCounter > fDuration) fDurationCounter = fDuration;
			
			pathpoints.push(point);
		}
			
		//Redistribute the base time values to compensate for the way bezier curves distribute the points
		//calc total dist
		var fTotalDist:Float = 0;
		var xDiff:Float, yDiff:Float;
		for (i in 1 ... numberOfpoints)
		{
			xDiff = pathpoints[i].x - pathpoints[i - 1].x;
			yDiff = pathpoints[i].y - pathpoints[i - 1].y;

			fTotalDist += Math.sqrt((xDiff * xDiff) + (yDiff * yDiff));
		}
			
		var fTotalTime:Float = 0;

		//for each point t = (prev t + (dist from prevpoint / total dist)) * total duration
		for (i in 1 ... numberOfpoints)
		{
			xDiff = pathpoints[i].x - pathpoints[i - 1].x;
			yDiff = pathpoints[i].y - pathpoints[i - 1].y;

			fTotalTime += Math.sqrt((xDiff * xDiff) + (yDiff * yDiff)) / fTotalDist;
			pathpoints[i].baseT = fTotalTime * fDuration;
		}
		
		var segment:Segment = new Segment();
		segment.points = pathpoints;
		this.segments.push(segment);
		
		RecalcTimeOffsets();
		
		return segment;
	}
	
	public function CreateSegmentFrom3PointBezierBySpeed(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, numberOfpoints:Int, speed:Float) : Segment
	{ 
		var pathpoints:Array<PathPoint> = new Array<PathPoint>();

		//sample points
		var durationCounter:Float = 0;
		var invT:Float;
		var scaledT:Float;
		
		//Set first point
		var point:PathPoint = new PathPoint();
		point.x = x1;
		point.y = y1;
		pathpoints.push(point);
		
		//add middle points
		for (i in 1 ... numberOfpoints - 1)
		{
			point = new PathPoint();
		
			scaledT = i / (numberOfpoints - 1);
			invT = 1 - scaledT;

			point.x = ((invT * invT) * x1) + 
			(2 * scaledT * invT * x2) + 
			((scaledT * scaledT) * x3);
			point.y = ((invT * invT) * y1) + 
			(2 * scaledT * invT * y2) + 
			((scaledT * scaledT) * y3);
			
			pathpoints.push(point);
		}
		
		//Set end point
		point = new PathPoint();
		point.x = x3;
		point.y = y3;
		pathpoints.push(point);

		//calc total dist
		var xDiff:Float, yDiff:Float;
		var fSectionDistance:Float;
		var fTotalTime:Float = 0;
		
		if (pathpoints.length > 0)
		{
			pathpoints[0].baseT = 0;
		}
		
		for (i in 1 ... numberOfpoints)
		{
			xDiff = pathpoints[i].x - pathpoints[i - 1].x;
			yDiff = pathpoints[i].y - pathpoints[i - 1].y;
			fSectionDistance = Math.sqrt((xDiff * xDiff) + (yDiff * yDiff));
			fTotalTime += fSectionDistance / speed;
			pathpoints[i].baseT = fTotalTime;
		}
				
		var segment:Segment = new Segment();
		segment.points = pathpoints;
		this.segments.push(segment);
		
		RecalcTimeOffsets();
		
		return segment;
	}
	
	public function CreateSegmentFrom4PointBezierBySpeed(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float, numberOfpoints:Int, speed:Float) : Segment
	{ 
		var pathpoints:Array<PathPoint> = new Array<PathPoint>();

		//sample points
		var fDurationCounter:Float = 0;
		var InvT:Float;
		var fScaledT:Float;
		
		//Set first point
		var point:PathPoint = new PathPoint();
		point.x = x1;
		point.y = y1;
		pathpoints.push(point);
		
		//add middle points
		for (i in 1 ... numberOfpoints - 1)
		{
			point = new PathPoint();
		
			fScaledT = i / (numberOfpoints - 1);
			InvT = 1 - fScaledT;
			
			point.x = ((InvT * InvT * InvT) * x1) + 
			(3 * fScaledT * (InvT * InvT) * x2) + 
			(3 * (fScaledT * fScaledT) * InvT * x3) +
			((fScaledT * fScaledT * fScaledT) * x4);
			point.y = ((InvT * InvT * InvT) * y1) + 
			(3 * fScaledT * (InvT * InvT) * y2) + 
			(3 * (fScaledT * fScaledT) * InvT * y3) +
			((fScaledT * fScaledT * fScaledT) * y4);

			
			pathpoints.push(point);
		}
		
		//Set end point
		point = new PathPoint();
		point.x = x4;
		point.y = y4;
		pathpoints.push(point);

		//calc total dist
		var xDiff:Float, yDiff:Float;
		var fSectionDistance:Float;
		var fTotalTime:Float = 0;
		
		if (pathpoints.length > 0)
		{
			pathpoints[0].baseT = 0;
		}
		
		for (i in 1 ... numberOfpoints)
		{
			xDiff = pathpoints[i].x - pathpoints[i - 1].x;
			yDiff = pathpoints[i].y - pathpoints[i - 1].y;
			fSectionDistance = Math.sqrt((xDiff * xDiff) + (yDiff * yDiff));
			fTotalTime += fSectionDistance / speed;
			pathpoints[i].baseT = fTotalTime;
		}
				
		var segment:Segment = new Segment();
		segment.points = pathpoints;
		this.segments.push(segment);
		
		RecalcTimeOffsets();
		
		return segment;
	}
	
	public function RecalcTimeOffsets():Void 
	{
		var timeCounter:Float = 0;
		var timeOffset:Float = 0;
		
		for (i in 0 ... segments.length)
		{
			timeOffset = timeCounter;
			
			for (j in 0 ... segments[i].points.length)
			{
				this.segments[i].points[j].precalculatedT = this.segments[i].points[j].baseT + timeOffset;
				timeCounter = this.segments[i].points[j].precalculatedT;
			}
		}
	}

	public function GetStartPoint() : Point
	{
		var point:Point = { x: 0, y: 0 };
	
		if(segments.length > 0)
		{
			if (segments[0].points.length > 0)
			{
				point.x = segments[0].points[0].x;
				point.y = segments[0].points[0].y;
			}
			else
			{
				point.x = 0;
				point.y = 0;
			}
		}
		else
		{
			point.x = 0;
			point.y = 0;
		}
		
		return point;
	}

	public function GetEndPoint() : Point
	{
		var point:Point = { x: 0, y: 0 };
	
		if(segments.length > 0)
		{
			if (segments[segments.length - 1].points.length > 0)
			{
				var s = segments[segments.length - 1].points;
				
				point.x = s[segments[segments.length - 1].points.length - 1].x;
				point.y = s[segments[segments.length - 1].points.length - 1].y;
			}
			else
			{
				point.x = 0;
				point.y = 0;
			}
		}
		else
		{
			point.x = 0;
			point.y = 0;
		}
		
		return point;
	}
	
	public function GetTotalPathTime() : Float
	{
		if (segments.length > 0)
		{
			var points:Array<PathPoint>  = segments[segments.length - 1].points;
			return points[points.length - 1].precalculatedT;
		}
		else
		{
			return 0;
		}
	}
}
