package ;

import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import quick_haxe.Interpolation;


class InterpolationTest extends haxe.unit.TestCase
{
	public function testLinearInterpolationAtStart()
	{
		MatcherAssert.assertThat(Interpolation.linear(0, 100, 0), IsEqual.equalTo(0), '0 to 100 at t=0');
		
		//For haxe unit
		currentTest.done = true;
	}
	
	public function testLinearInterpolationAtEnd()
	{
		MatcherAssert.assertThat(Interpolation.linear(0, 100, 1), IsEqual.equalTo(100), '0 to 100 at t=1');
		
		//For haxe unit
		currentTest.done = true;
	}
	
	public function testLinearInterpolationAtMidPoint()
	{
		MatcherAssert.assertThat(Interpolation.linear(0, 100, 0.5), IsEqual.equalTo(50), '0 to 100 at t=0.5');
		
		//For haxe unit
		currentTest.done = true;
	}
	
	public function testLinearInterpolationNegativeStartNearStart()
	{
		MatcherAssert.assertThat(Interpolation.linear(-50, 50, 0.2), IsEqual.equalTo(-30), '-50 to 50 at t=0.2');
		
		//For haxe unit
		currentTest.done = true;
	}
	
	public function testLinearInterpolationNegativeStartNearEnd()
	{
		MatcherAssert.assertThat(Interpolation.linear(-50, 50, 0.8), IsEqual.equalTo(30), '-50 to 50 at t=0.8');
		
		//For haxe unit
		currentTest.done = true;
	}
	
	public function testLinearInterpolationNegativeEndNearStart()
	{
		MatcherAssert.assertThat(Interpolation.linear(50, -50, 0.3), IsEqual.equalTo(20), '50 to -50 at t=0.3');
		
		//For haxe unit
		currentTest.done = true;
	}
	
	public function testLinearInterpolationNegativeEndNearEnd()
	{
		MatcherAssert.assertThat(Interpolation.linear(50, -50, 0.7), IsEqual.equalTo( -20), '50 to -50 at t=0.7');
		
		//For haxe unit
		currentTest.done = true;
	}
}