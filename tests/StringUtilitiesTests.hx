package;

import haxe.unit.TestCase;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;
import quick_haxe.StringUtilities;

class StringUtilitiesTests extends TestCase
{
	public function testToStringFloatWholeNumber()
	{
		MatcherAssert.assertThat(StringUtilities.toString(100.0, 2), IsEqual.equalTo("100.00"));

		currentTest.done = true;
	}
	
	public function testToStringFloatLessPlacesThanRequired()
	{
		MatcherAssert.assertThat(StringUtilities.toString(1000.17, 3), IsEqual.equalTo("1000.170"));

		currentTest.done = true;
	}
	
	public function testToStringFloatMorePlacesThanRequired()
	{
		MatcherAssert.assertThat(StringUtilities.toString(10000.10007, 4), IsEqual.equalTo("10000.1000"));

		currentTest.done = true;
	}
	
	public function testToStringFloatZeroPlacesRequiredWholeNumber()
	{
		MatcherAssert.assertThat(StringUtilities.toString(10000, 0), IsEqual.equalTo("10000"));

		currentTest.done = true;
	}
	
	public function testToStringFloatZeroPlacesRequiredDecimalNumber()
	{
		MatcherAssert.assertThat(StringUtilities.toString(10000.10007, 0), IsEqual.equalTo("10000"));

		currentTest.done = true;
	}
}