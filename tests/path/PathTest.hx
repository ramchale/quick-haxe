package ;

import haxe.unit.TestCase;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;
import quick_haxe.path.PathPoint;
import quick_haxe.path.Segment;

import quick_haxe.path.Path;

class ColourTest extends TestCase
{
	public function testGetPosition()
	{
		var points:Array<PathPoint> = new Array<PathPoint>();
		
		var p1:PathPoint = new PathPoint();
		p1.baseT = 0;
		p1.precalculatedT = 0;
		p1.x = 100;
		p1.y = 100;
		
		
		var p2:PathPoint = new PathPoint();
		p2.baseT = 1;
		p2.precalculatedT = 1;
		p2.x = 200;
		p2.y = 200;
		
		var segment1:Segment = new Segment();
		segment1.points = new Array<PathPoint>();
		
		
		
		
		var path:Path = new Path();
		path.segments
		
		MatcherAssert.assertThat(Colour.getRed(0x102030), IsEqual.equalTo(16));

		currentTest.done = true;
	}
}
