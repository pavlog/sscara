// derived from http://www.thingiverse.com/thing:179563
module heatsinkE3DV5(tol=0.0, res=20)  //with tolerance of 0.3. Meaning, that the disks are 0.3 higher than in reality and the diameter of the disks change by 0.6.
{
	union()
	{
		//center-section
		cylinder(r=4.5+tol, h=50.1, $fn=res);
		translate([0,0,33.1])cylinder(r=7.5+tol, h=17, $fn=res);

		translate([0,0,29.7])cylinder(r=6.5+tol, h=17+tol, $fn=res);
		for(i=[0:9])
		translate([0,0,50.1-3.4*i-(1.2+tol/2)])cylinder(r=12.5+tol, h=1.2+tol, $fn=res);

		//head-section
		translate([0,0,-tol/2])cylinder(r=8+tol, h=3.7+tol, $fn=res);
		translate([0,0,3.7-tol/2])cylinder(r=6+tol, h=5.6+tol, $fn=res);
		translate([0,0,9.3-tol/2])cylinder(r=8+tol, h=3+tol, $fn=res);
		translate([0,0,14.6-tol/2])cylinder(r=8+tol, h=2.2+tol, $fn=res);

		//heatbrake, heatblock, nozzle
		//careful the heatblock is the one from ultimaker not the original one from e3d. The original one is a bit smaller.
		//The nozzle also isn't exactly like the original one, but you will not need to make a model that fits tightly to the nozzle.
		translate([0,0,50.1])cylinder(r=2, h=2.1, $fn=res);
		translate([0,3,50.1+2.1+6])cube([16,16,12],center=true);
		translate([0,0,52.3+12])cylinder(r1=5.6, r2=1, h=5, $fn=res);
	}
}
