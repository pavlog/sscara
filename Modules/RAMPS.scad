// ramps 1.4
module RAMPS(bHolesOnly=0)
{
	if( bHolesOnly )
	{
		color("red") 
		{
			translate([-54.8+15.24,28.9,-50]) cylinder(d=3,h=100,$fn=16);
			translate([-54.8+13.97,28.9-(53.3-2.5*2),-50]) cylinder(d=3,h=100,$fn=16);
			translate([-54.8+(96.52),28.9-(53.3-2.5*2),-50]) cylinder(d=3,h=100,$fn=16);
		}
	}
	else
	{
		//http://www.thingiverse.com/thing:34621
		translate([0,0,13]) rotate([90,0,0])import("RAMPS1_4.STL", convexity=3);
	}
}

RAMPS(0);
RAMPS(1);



