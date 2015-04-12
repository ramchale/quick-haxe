package;

import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import quick_haxe.Mathematics;

class MathematicsTest
{

	public function new() 
	{
		
	}

	@Test
	public function TestDegreesToRadians()
	{
		MatcherAssert.assertThat('0 degrees', Mathematics.degreesToRadians(0), IsEqual.equalTo(0));
		MatcherAssert.assertThat('90 degrees', Mathematics.degreesToRadians(90), IsEqual.equalTo(Math.PI * 0.5));
		MatcherAssert.assertThat('180 degrees', Mathematics.degreesToRadians(180), IsEqual.equalTo(Math.PI));
		MatcherAssert.assertThat('270 degrees', Mathematics.degreesToRadians(270), IsEqual.equalTo(Math.PI * 1.5));
		MatcherAssert.assertThat('360 degrees', Mathematics.degreesToRadians(360), IsEqual.equalTo(Math.PI * 2.0));
	}
	
	@Test
	public function TestRadiansToDegrees()
	{
		MatcherAssert.assertThat('0 radians', Mathematics.radiansToDegrees(0), IsEqual.equalTo(0));
		MatcherAssert.assertThat('PI / 2 radians', Mathematics.radiansToDegrees(Math.PI * 0.5), IsEqual.equalTo(90));
		MatcherAssert.assertThat('PI radians', Mathematics.radiansToDegrees(Math.PI), IsEqual.equalTo(180));
		MatcherAssert.assertThat('3 * PI / 2 radians', Mathematics.radiansToDegrees(Math.PI * 1.5), IsEqual.equalTo(270));
		MatcherAssert.assertThat('2 * PI radians', Mathematics.radiansToDegrees(Math.PI * 2.0), IsEqual.equalTo(360));
	}
	
	@Test
	public function ModularDifference()
	{
		MatcherAssert.assertThat('0 - 0 (mod 4)', Mathematics.modularDifference(0, 0, 4), IsEqual.equalTo(0));
		MatcherAssert.assertThat('4 - 0 (mod 4)', Mathematics.modularDifference(4, 0, 4), IsEqual.equalTo(0));
		MatcherAssert.assertThat('5 - 3 (mod 4)', Mathematics.modularDifference(5, 3, 4), IsEqual.equalTo(2));
		MatcherAssert.assertThat('2 - 3 (mod 4)', Mathematics.modularDifference(2, 3, 4), IsEqual.equalTo(3));
	}
}