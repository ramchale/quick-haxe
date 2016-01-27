package;

import haxe.unit.TestCase;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import quick_haxe.Mathematics;

class MathematicsTest extends TestCase
{
	public function testDegreesToRadians()
	{
		MatcherAssert.assertThat(Mathematics.degreesToRadians(0), IsEqual.equalTo(0), '0 degrees');
		MatcherAssert.assertThat(Mathematics.degreesToRadians(90), IsEqual.equalTo(Math.PI * 0.5), '90 degrees');
		MatcherAssert.assertThat(Mathematics.degreesToRadians(180), IsEqual.equalTo(Math.PI), '180 degrees');
		MatcherAssert.assertThat(Mathematics.degreesToRadians(270), IsEqual.equalTo(Math.PI * 1.5), '270 degrees');
		MatcherAssert.assertThat(Mathematics.degreesToRadians(360), IsEqual.equalTo(Math.PI * 2.0), '360 degrees');

		currentTest.done = true;
	}

	public function testRadiansToDegrees()
	{
		MatcherAssert.assertThat(Mathematics.radiansToDegrees(0), IsEqual.equalTo(0), '0 radians');
		MatcherAssert.assertThat(Mathematics.radiansToDegrees(Math.PI * 0.5), IsEqual.equalTo(90), 'PI / 2 radians');
		MatcherAssert.assertThat(Mathematics.radiansToDegrees(Math.PI), IsEqual.equalTo(180), 'PI radians');
		MatcherAssert.assertThat(Mathematics.radiansToDegrees(Math.PI * 1.5), IsEqual.equalTo(270), '3 * PI / 2 radians');
		MatcherAssert.assertThat(Mathematics.radiansToDegrees(Math.PI * 2.0), IsEqual.equalTo(360), '2 * PI radians');

		currentTest.done = true;
	}

	public function testModularDifference()
	{
		MatcherAssert.assertThat(Mathematics.modularDifference(0, 0, 4), IsEqual.equalTo(0), '0 - 0 (mod 4)');
		MatcherAssert.assertThat(Mathematics.modularDifference(4, 0, 4), IsEqual.equalTo(0), '4 - 0 (mod 4)');
		MatcherAssert.assertThat(Mathematics.modularDifference(5, 3, 4), IsEqual.equalTo(2), '5 - 3 (mod 4)');
		MatcherAssert.assertThat(Mathematics.modularDifference(2, 3, 4), IsEqual.equalTo(3), '2 - 3 (mod 4)');

		currentTest.done = true;
	}

	public function testRandomWithPositiveRange()
	{
		for (i in 0 ... 100)
		{
			var result:Float = Mathematics.random(0, 10);
			MatcherAssert.assertThat(true, IsEqual.equalTo(result < 10 && result >= 0), '$result was outside expected range');
		}

		currentTest.done = true;
	}

	public function testRandomWithNegativeRange()
	{
		for (i in 0 ... 100)
		{
			var result:Float = Mathematics.random(-10, 0);
			MatcherAssert.assertThat(true, IsEqual.equalTo(result < 0 && result >= -10), '$result was outside expected range');
		}

		currentTest.done = true;
	}

	public function testRandomWithNegativeStartPositiveEnd()
	{
		for (i in 0 ... 100)
		{
			var result:Float = Mathematics.random(-10, 10);
			MatcherAssert.assertThat(true, IsEqual.equalTo(result < 10 && result >= -10), '$result was outside expected range');
		}

		currentTest.done = true;
	}

	public function testRandomIntWithPositiveRange()
	{
		for (i in 0 ... 100)
		{
			var result:Int = Mathematics.randomInt(0, 10);
			MatcherAssert.assertThat(true, IsEqual.equalTo(result < 10 && result >= 0), '$result was outside expected range');
		}

		currentTest.done = true;
	}

	public function testRandomIntWithNegativeRange()
	{
		for (i in 0 ... 100)
		{
			var result:Int = Mathematics.randomInt(-10, 0);
			MatcherAssert.assertThat(true, IsEqual.equalTo(result < 0 && result >= -10), '$result was outside expected range');
		}

		currentTest.done = true;
	}

	public function testRandomIntWithNegativeStartPositiveEnd()
	{
		for (i in 0 ... 100)
		{
			var result:Int = Mathematics.randomInt(-10, 10);
			MatcherAssert.assertThat(true, IsEqual.equalTo(result < 10 && result >= -10), '$result was outside expected range');
		}

		currentTest.done = true;
	}
}
