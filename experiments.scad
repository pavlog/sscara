// Author: Pavlo Gryb (psg416@gmail.com)

use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>
use <Modules/EndStoppers.scad>
use <Modules/Write.scad/Write.scad>
include <Modules/MCAD/stepper.scad>
use <Modules/HotEnds.scad>
use <Modules/Misc.scad>
use <Modules/LCD.scad>

// bed rot
translate([18,-29,50]) rotate([180,0,180])
{
translate([0,0,-20]) Pulley16Teeth();
Nema17_shaft24_Stepper();
}
// arm rot 
translate([-28,14,24]) rotate([0,0,-90])
{
translate([0,0,-20]) Pulley16Teeth();

Nema17_shaft24_Stepper();
}

plateCenterX = 10;
plateCenterY = 5;
armCenterX = -22;
armCenterY = 72;

angle1 = -50;
angleRods = -30;
//rodsOffsX = 13;
//rodsOffsY = -5;
rodsOffs = 14;
armLen = sqrt((armCenterX-plateCenterX)*(armCenterX-plateCenterX)+(armCenterY-plateCenterY)*(armCenterY-plateCenterY));
translate([armCenterX,armCenterY,0]) rotate([0,0,angle1])
{
	translate([0,0,0]) Pulley16Teeth();
color("green") translate([0,0,15]) 	cylinder(d=55,h=8);
translate([0,0,70]) rotate([180,0,-90]) color("grey") Nema17_shaft24_Stepper();
translate([0,0,90]) 	cylinder(d=6,h=100);
	difference()
	{
color("red") translate([0,0,120]) 	cylinder(r=armLen+3,h=1);
color("red") translate([0,0,120-1]) 	cylinder(r=armLen,h=3);
	}
rotate([0,0,angleRods-30+90+90]) translate([rodsOffs,0,70]) 	cylinder(d=6,h=100);
rotate([0,0,angleRods-30+90+90]) translate([rodsOffs,0,70+25]) 	BearingLM6UU();
rotate([0,0,angleRods-30-90+90]) translate([rodsOffs,0,70]) 	cylinder(d=6,h=100);
rotate([0,0,angleRods-30-90+90]) translate([rodsOffs,0,70+25]) 	BearingLM6UU();
//rotate([0,0,angleRods-30-90-90]) translate([rodsOffs,0,70]) 	cylinder(d=6,h=100);
//rotate([0,0,angleRods-30-90-90]) translate([rodsOffs,0,70+25]) 	BearingLM6UU();

color("blue") rotate([0,0,angleRods+90-30]) translate([0,0,110])  rotate([90,0,0])	cylinder(d=8,h=armLen);

color("red") rotate([0,0,angleRods-30-angle1]) translate([0,0,80])  rotate([90,0,0])	cylinder(d=10,h=20);
	
	translate([0,0,75]) color("lightgrey") Bearing625();
	translate([0,0,135]) 		color("grey") rolson_hex_nut(6);

}



// extruder
translate([-28,-29,50]) rotate([0,180,0]) rotate([0,0,90])
{
//translate([0,0,-20]) Pulley16Teeth();
Nema17_shaft24_Stepper();
}

//base size
translate([-50,-50,-35]) cube([120,150,1]);

///*
//*/
translate([60,100,5]) rotate([0,0,-180]) LCD20x4SmartController();

// bed
translate([plateCenterX,plateCenterY,0])
{
 cylinder(d=5,h=85);
color([0.5,0,0,0.3]) translate([0,0,80]) cylinder(d=110,h=5);
}
/*
translate ([10,33,20]) rotate([0,0,-90])
{
	color("lightblue") import("STL/NonPrintedParts/RAMPS1_4.STL", convexity=3);
	color([0.5,0.5,1,0.2]) translate([-72,-12,-32]) cube([125,50,62]);
}
*/
///*
translate ([25,40,-20]) rotate([90,0,90])
{
	color("lightblue") import("STL/NonPrintedParts/RAMPS1_4.STL", convexity=3);
	color([0.5,0.5,1,0.2]) translate([-72,-12,-32]) cube([125,50,62]);
}
//*/
//http://www.thingiverse.com/thing:34621
/*
translate ([40,65,75]) rotate([0,-90,0]) 
{
color("lightblue") import("STL/NonPrintedParts/RAMPS1_4.STL", convexity=3);
	color([0.5,0.5,1,0.2]) translate([-72,-13,-30]) cube([125,50,60]);
}
*/

// graphics 8.2 9.5
translate([-50,-50,-35]) cylinder(r=1,h=110);