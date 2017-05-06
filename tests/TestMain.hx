class TestMain
{
	static function main(){
        var r = new haxe.unit.TestRunner();
        
		r.add(new InterpolationTest());
		r.add(new MathematicsTest());
		r.add(new ColourTest());
		r.add(new Geometry2DTest());
		
        r.run();
    }
}
