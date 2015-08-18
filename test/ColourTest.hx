package ;

import haxe.unit.TestCase;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import quick_haxe.Colour;

class ColourTest extends TestCase
{
	public function testGetRed()
	{
		MatcherAssert.assertThat(Colour.GetRed(0x102030), IsEqual.equalTo(16));
		
		currentTest.done = true;
	}
	
	public function testGetGreen()
	{
		MatcherAssert.assertThat(Colour.GetRed(0x102030), IsEqual.equalTo(32));
		
		currentTest.done = true;
	}
	
	public function testGetBlue()
	{
		MatcherAssert.assertThat(Colour.GetRed(0x102030), IsEqual.equalTo(48));
		
		currentTest.done = true;
	}
}