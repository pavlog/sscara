// 2004 smart lcd controller
module LCD20x4SmartController(holesOnly=0)
{
	if( holesOnly==0 )
	{
		difference()
		{
			color("brown") cube([2,150,55]);//+5]);
			// holes
			color("red") translate([-3,3,55-49-3]) rotate([0,90,0]) cylinder(d=3,h=50,$fn=12);
			color("red") translate([-3,150-3,55-49-3]) rotate([0,90,0]) cylinder(d=3,h=50,$fn=12);
			color("red") translate([-3,150-3,55-(55-49-3)]) rotate([0,90,0]) cylinder(d=3,h=50,$fn=12);
			color("red") translate([-3,3,55-(55-49-3)]) rotate([0,90,0]) cylinder(d=3,h=50,$fn=12);
		}
		translate([-(2+2),38,-8]) color("green") cube([2,98,60]);
		translate([-13,38.5,3]) color("blue") cube([9,98,40]);
		translate([0,61,24]) color("white") cube([25,45,10]);
		translate([2,135,24]) color("white") cube([8,8,8]);
		// tripot
		translate([0,15,25]) color("green") rotate([0,-90,0]) cylinder(d=3,h=23,$fn=12);
	}
	else
	{
		// holes
		color("red") translate([-30,3,55-49-3]) rotate([0,90,0]) cylinder(d=3,h=150,$fn=12);
		color("red") translate([-30,150-3,55-49-3]) rotate([0,90,0]) cylinder(d=3,h=150,$fn=12);
		color("red") translate([-30,150-3,55-(55-49-3)]) rotate([0,90,0]) cylinder(d=3,h=150,$fn=12);
		color("red") translate([-30,3,55-(55-49-3)]) rotate([0,90,0]) cylinder(d=3,h=150,$fn=12);
	}
}
LCD20x4SmartController();