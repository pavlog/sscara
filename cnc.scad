// Author: Pavlo Gryb (psg416@gmail.com)

use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>
use <Modules/EndStoppers.scad>
use <Modules/Write.scad/Write.scad>
include <Modules/MCAD/stepper.scad>
use <Modules/HotEnds.scad>
use <Modules/LCD.scad>
use <Modules/Misc.scad>
use <Modules/Profiles.scad>

CProfilrLen = 250;
YRodsLen = 300;
XRodsDist = 220;
//
x = 50;
y = 0;
z = 0;
//
ySideOffsets = -30;
//
module Alu14x10(len)
{
	difference()
	{
		cube([14,len,10]);
		translate([(14-6.4)/2,-1,2]) cube([6.4,len+2,10]);
		translate([2,-1,2]) cube([10,len+2,6]);
	}
}
module portalLeftSide()
{
	color("green") hull()
	{
		translate([-XRodsDist/2-20,15,40]) rotate([0,90,0]) cylinder(r=3,h=3);
		// up
		translate([-XRodsDist/2-20,15+ySideOffsets,160]) rotate([0,90,0]) cylinder(r=3,h=3);
		// front
		translate([-XRodsDist/2-20,15+y+60,40]) rotate([0,90,0]) cylinder(r=3,h=3);
		// up front
		translate([-XRodsDist/2-20,15+y+60+ySideOffsets,160]) rotate([0,90,0]) cylinder(r=3,h=3);
	}
}
// y
translate([-CProfilrLen/2,0,0]) rotate([0,-90,-90]) CProfile(23,55,2.5,CProfilrLen);
translate([-CProfilrLen/2,YRodsLen,55]) rotate([0,90,-90]) CProfile(23,55,2.5,CProfilrLen);

color("silver") translate([-7,0,55]) Alu14x10(YRodsLen);
color("grey") translate([-7-14,0,55]) Alu14x10(YRodsLen);
color("grey") translate([-7+14,0,55]) Alu14x10(YRodsLen);
color("silver") translate([-7-14*2,0,55]) Alu14x10(YRodsLen);
color("silver") translate([-7+14*2,0,55]) Alu14x10(YRodsLen);
color("grey") translate([-7-14*3,0,55]) Alu14x10(YRodsLen);
color("grey") translate([-7+14*3,0,55]) Alu14x10(YRodsLen);
color("silver") translate([-7-14*4,0,55]) Alu14x10(YRodsLen);
color("silver") translate([-7+14*4,0,55]) Alu14x10(YRodsLen);
color("grey") translate([-7-14*5,0,55]) Alu14x10(YRodsLen);
color("grey") translate([-7+14*5,0,55]) Alu14x10(YRodsLen);
//
translate([0,y,0])
{
	translate([-XRodsDist/2,0,30]) rotate([-90,0,0]) cylinder(d=8,h=YRodsLen);
	translate([-XRodsDist/2,15,30]) rotate([0,180,0]) SCS8UU();
	translate([-XRodsDist/2,15+30,30]) rotate([0,180,0]) SCS8UU();
	//
	translate([XRodsDist/2,0,30]) rotate([-90,0,0]) cylinder(d=8,h=YRodsLen);
	translate([XRodsDist/2,15,30]) rotate([0,180,0]) SCS8UU();
	translate([XRodsDist/2,15+30+y,30]) rotate([0,180,0]) SCS8UU();
	//
	portalLeftSide();
	mirror() portalLeftSide();
}
//
//x
translate([0,0,100] )
{
	translate([XRodsDist/2+20,40+ySideOffsets,50]) rotate([0,-90,0])
	{
		cylinder(d=8,h=XRodsDist+40);
		translate([0,0,20+x])  rotate([90,0,0]) SCS8UU();
		translate([0,0,20+30+x])  rotate([90,0,0]) SCS8UU();
	}
	translate([XRodsDist/2+20,40+ySideOffsets,0]) rotate([0,-90,0])
	{
		cylinder(d=8,h=XRodsDist+40);
		translate([0,0,20+x])  rotate([90,0,0]) SCS8UU();
		translate([0,0,20+30+x])  rotate([90,0,0]) SCS8UU();
	}

	translate([XRodsDist/2+20,40+ySideOffsets,25]) rotate([0,-90,0])
	{
		color("silver") cylinder(d=8,h=XRodsDist+40);
	}

	translate([XRodsDist/2-x,ySideOffsets,0]) rotate([0,0,0]) color("green") hull()
	{
		translate([0,53,70]) rotate([90,0,0]) cylinder(r=3,h=3);
		translate([-60,53,70]) rotate([90,0,0]) cylinder(r=3,h=3);
		translate([0,53,220]) rotate([90,0,0]) cylinder(r=3,h=3);
		translate([-60,53,220]) rotate([90,0,0]) cylinder(r=3,h=3);
	}
	// z
	translate([XRodsDist/2-5-x,65+ySideOffsets,-20]) rotate([0,0,0])
	{
		cylinder(d=8,h=XRodsDist+40);
		translate([0,0,10+z])  rotate([90,0,0]) SCS8UU();
		translate([0,0,10+30+z])  rotate([90,0,0]) SCS8UU();
	}

	translate([XRodsDist/2-55-x,65+ySideOffsets,-20]) rotate([0,0,0])
	{
		cylinder(d=8,h=XRodsDist+40);
		translate([0,0,10+z])  rotate([90,0,0]) SCS8UU();
		translate([0,0,10+30+z])  rotate([90,0,0]) SCS8UU();
	}

	translate([XRodsDist/2-30-x,65+ySideOffsets,-20]) rotate([0,0,0])
	{
		color("silver") cylinder(d=8,h=XRodsDist+40);
	}

	translate([XRodsDist/2-30-x,110+ySideOffsets,-70]) rotate([0,0,0])
	{
		color("silver") cylinder(d=25,h=48);
		translate([0,0,48]) color("silver") cylinder(d=52,h=175-48);
	}
}
