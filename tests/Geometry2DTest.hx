package ;

import haxe.unit.TestCase;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import quick_haxe.Geometry2D;

class Geometry2DTest extends TestCase
{
	public function testDistanceSquaredNoDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(0, 0, 0, 0), IsEqual.equalTo(0));

		currentTest.done = true;
	}
	
	public function testDistanceSquaredPositiveHorizontalDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(1, 0, 3, 0), IsEqual.equalTo(4));

		currentTest.done = true;
	}
	
	public function testDistanceSquaredNegativeHorizontalDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(-1, 0, -4, 0), IsEqual.equalTo(9));

		currentTest.done = true;
	}
	
	public function testDistanceSquaredPositiveVerticalDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(0, 1, 0, 5), IsEqual.equalTo(16));

		currentTest.done = true;
	}
	
	public function testDistanceSquaredNegativeVerticalDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(0, -1, 0, -6), IsEqual.equalTo(25));

		currentTest.done = true;
	}
	
	public function testDistanceSquaredPositiveHorizontalAndVerticalDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(-1, 1, 4, 6), IsEqual.equalTo(50));

		currentTest.done = true;
	}
	
	public function testDistanceSquaredNegativeHorizontalAndVerticalDistance()
	{
		MatcherAssert.assertThat(Geometry2D.distanceSquared(1, -1, -5, -7), IsEqual.equalTo(72));

		currentTest.done = true;
	}
}
