// Author: Pavlo Gryb (psg416@gmail.com)

use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>
use <Modules/EndStoppers.scad>
use <Modules/Write.scad/Write.scad>
include <Modules/MCAD/stepper.scad>
use <Modules/HotEnds.scad>
use <Modules/Misc.scad>

translate([-25,-30,24])
{
translate([0,0,-20]) Pulley16Teeth();

Nema17_shaft24_Stepper();
}
translate([24,-30,24])
{
translate([0,0,-20]) Pulley16Teeth();
Nema17_shaft24_Stepper();
}
translate([0,60,24])
{
translate([0,0,-20]) Pulley16Teeth();
Nema17_shaft24_Stepper();
	cylinder(d=5,h=100);
}
translate([0,0,80]) cylinder(d=100,h=10);
translate([0,0,0]) cylinder(d=5,h=80);

translate([-50,-50,0]) cube([100,130,1]);
