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
YRodsDist = 220;
//
translate([-CProfilrLen/2,0,0]) rotate([0,-90,-90]) CProfile(23,55,2.5,CProfilrLen);
translate([-CProfilrLen/2,300,55]) rotate([0,90,-90]) CProfile(23,55,2.5,CProfilrLen);
//
translate([-YRodsDist/2,0,30]) rotate([-90,0,0]) cylinder(d=8,h=300);
//
translate([-YRodsDist/2,50,30]) rotate([0,180,0]) SCS8UU();