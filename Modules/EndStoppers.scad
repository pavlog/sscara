module EndSwitchBody20x11(boltOnly=0)
{
	if( !boltOnly )
	{
		color( "black") cube([20,10,6.5]);
		color ("Silver") translate([2,10,1.5/2]) cube([0.3,4,5]);
		color ("Silver") translate([9,10,1.5/2]) cube([0.3,4,5]);
		color ("Silver") translate([17.5,10,1.5/2]) cube([0.3,4,5]);
		color ("Silver") translate([20,-1,1.5/2]) rotate([0,0,0+90]) cube([0.3,23,5]);
		color ("Silver") translate([19,0,1.5/2]) rotate([0,0,0+90]) cylinder(r=1.0,h=5);
		color ("red") translate([12.5,0,1.5/2]) rotate([0,0,0+90]) cylinder(r=1.0,h=5);
		color ("red") translate([5,7,-1]) cylinder(r=1.0,h=8.5,$fn=16);
		color ("red") translate([5,7,-1]) cylinder(r=1.25,h=8.5,$fn=16);
		color ("red") translate([14,7,-1]) cylinder(r=1.25,h=8.5,$fn=16);
		color ("Silver") translate([1,-4,-1]) difference()
		{
			translate([0,0,2.25]) cylinder(r=4,h=4,$fn=16);
			translate([0,0,-1]) cylinder(r=4-0.3,h=10,$fn=16);
			translate([-10,0,-1]) cube([20,20,10]);
		}
	}
	else
	{
		color ("red") translate([5,7,-10]) cylinder(r=1.25,h=10+6.5+10,$fn=16);
		color ("red") translate([14,7,-10]) cylinder(r=1.25,h=10+6.5+10,$fn=16);
	}
	//translate([-3,-3,0])  cube([3,3,5]);
}
EndSwitchBody20x11();