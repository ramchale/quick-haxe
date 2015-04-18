package ;

import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import quick_haxe.Interpolation;


class InterpolationTest
{

	public function new() 
	{
		
	}
	
	@Test
	public function TestLinear()
	{
		MatcherAssert.assertThat('0 to 100 at t=0', Interpolation.linear(0, 100, 0), IsEqual.equalTo(0));
		MatcherAssert.assertThat('0 to 100 at t=1', Interpolation.linear(0, 100, 1), IsEqual.equalTo(100));
		MatcherAssert.assertThat('0 to 100 at t=0.5', Interpolation.linear(0, 100, 0.5), IsEqual.equalTo(50));
		MatcherAssert.assertThat('-50 to 50 at t=0.2', Interpolation.linear(-50, 50, 0.2), IsEqual.equalTo(-30));
		MatcherAssert.assertThat('-50 to 50 at t=0.8', Interpolation.linear(-50, 50, 0.8), IsEqual.equalTo(30));
		MatcherAssert.assertThat('50 to -50 at t=0.3', Interpolation.linear(50, -50, 0.3), IsEqual.equalTo(20));
		MatcherAssert.assertThat('50 to -50 at t=0.7', Interpolation.linear(50, -50, 0.7), IsEqual.equalTo(-20));
	}
	
}