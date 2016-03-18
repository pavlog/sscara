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
use <Modules/RAMPS.scad>
include <Modules/dimlines.scad>
include <Modules/TextGenerator.scad>

gearRadToTeethEnd = 10.0/2;//7.3/2;// seems like mk8
gearRad = 11.5/2;// semms like mk8
fillamentD = 1.75;
fillamentPenetration = 0.5;//mm
extruderBearingDia = Bearing623Diameter();
extruderBearingH = Bearing623Height();
extruderClearanceH = 0.2;

printLayout = 0;

module ExtruderStepperPanel()
{
					hull()
				{
					translate([-14,-14,0]) cylinder(r=7.2,h=4,$fn=32);
					translate([14,-14,0]) cylinder(r=7.2,h=4,$fn=32);
					translate([14,14,0]) cylinder(r=7.2,h=4,$fn=32);
					translate([-14,14,0]) cylinder(r=7.2,h=4,$fn=32);
					//translate([24.5+extrudeMountZOffset,9,0]) cylinder(r=7.5,h=4);
				}

}

// extruder
//if( drawArray==[] || search(11,drawArray)!=[] )
{
	//printLayout = 1;
	aY = printLayout ? 0 : 90;
	aYY = printLayout ? 180 : -90;
	armX = printLayout ? 12 :0;
	armY = printLayout ? -38 : 0;
	armZ = printLayout ? -24.75 : 0;
	armRZ = printLayout ? 196.69 : 0;
	armRX = printLayout ? 90 : 0;
	armTX = printLayout ? 10 : 0;
	translate ([0,0,0]) rotate([0,aYY,0]) rotate([0,0,aY]) mirror()//rotate([90,0,0]) 
	{
		armH = extruderBearingH+3+3;
		partsOffset = -13;
		if( !printLayout )
		{
			rotate([0,0,90]) Nema17_shaft24_Stepper();
		}
		translate([0,0,-3])
		{
			difference()
			{
				//cube([36,36,4]);
				ExtruderStepperPanel();
				extr = lookup(NemaRoundExtrusionDiameter, Nema17);
				color ("red") translate([0,0,1.5]) cylinder(d=extr+0.5,h=2.5,$fn=32);
				color ("red") translate([0,0,2]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				//extruder mount
				//translate([27,10.5,-30+extrudeMountZOffset]) color("red") rotate([0,0,0]) cylinder(d=3.1,h=50,$fn=16);
				//translate([25.4,3.5,-30+extrudeMountZOffset]) color("red") rotate([0,0,0]) cylinder(d=3.1,h=50,$fn=16);
			}
			difference()
			{
				union()
				{
					color ("red")  translate([gearRadToTeethEnd-1,-12,-armH]) cube([11+3,14,armH]);
					color ("red")  translate([gearRadToTeethEnd+8,-12-1,-armH]) cube([5,3,armH]);
				}
				color( "green") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3-2]) cylinder(d=extruderBearingDia+3,h=armH+2);
				color( "green") translate([0,0,partsOffset+3-2]) cylinder(d=gearRad*2+1,h=armH+2);

				// cone
				color( "red") translate([3.9,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,-armH/2]) rotate([0,90,0]) cylinder(r2=fillamentD/2-0.2,r1=fillamentD/2+1.5,h=2,$fn=16);
				
				// fillamant
				color( "blue") translate([-50,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,-armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
				color( "blue") translate([10+3,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,-armH/2]) rotate([0,90,0]) cylinder(d=9,h=100,$fn=16);
				//
			}
			difference()
			{
				union()
				{
					color( "green") hull()
					{
						translate([15.5,-4-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) cylinder(d=6,h=armH+4);
						translate([20.5,-6-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) rotate([0,0,25])  cylinder(d=6,h=armH+4,$fn=16);
						translate([15.5,-5.5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) cylinder(d=6,h=armH+4);
					}
					//color("blue") translate([25,-4.5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3+4-13]) rotate([0,0,90+70])  cube([5,6.5,23]);
					//color("red") translate([26,-1.8-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3+4-13]) rotate([0,0,aY])  cube([5,11,10]);
					color( "green") hull()
					{
						translate([15.5,-4.5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) cylinder(d=8,h=armH+4);
						translate([9,-1-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) cylinder(d=4.5,h=armH+4);
					}
				}
				color ("red") translate([0,0,2]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				//M3 HOLE
				color( "magenta") translate([27,0,-armH/2]) rotate([90,0,0]) rotate([0,-25,0])  cylinder(d=4,h=100,$fn=16);
				color( "magenta") translate([14,-15,-armH/2-10]) rotate([0,90,90+70+180])  cylinder(d=3,h=100,$fn=16);
			}
			difference()
			{
				color ("red")  translate([-gearRadToTeethEnd-15,-12,-armH]) cube([15,14,armH+1]);
				color( "green") translate([0,0,partsOffset+3-2]) cylinder(d=gearRad*2+1,h=armH+2);
				color( "blue") hull()
				{
						translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3-2]) cylinder(d=extruderBearingDia+3,h=armH+2);
						translate([0,-5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3-2]) cylinder(d=extruderBearingDia+3,h=armH);
						translate([-3,-5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3-2]) cylinder(d=extruderBearingDia+4,h=armH);
				}
				color( "blue") hull()
				{
					 translate([-15.5,-15.5,partsOffset+3-2]) cylinder(d=11+3,h=armH+2);
					 translate([-11.5,-15.5,partsOffset+3-2]) cylinder(d=11+3,h=armH+2);
				}
				// fillamant
				color( "red") translate([-50,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,-armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
			}
		}
		//#color ("red") translate([0,0,0]) cube([10,10,10]);
		translate([armX,armY,armZ]) rotate([armRX,0,0])  rotate([0,0,armRZ]) translate([0,0,partsOffset])
		{
			difference()
			{
				union()
				{
					color( "green") hull()
					{
						color( "green") translate([-15.5,-15.5,0]) cylinder(d=11+2,h=armH);
						//#color( "green") translate([-12,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,0]) cylinder(d=extruderBearingDia+6,h=armH);
					}
					color( "magenta") hull()
					{
						translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,0]) cylinder(d=extruderBearingDia+2,h=armH);
						translate([0,-5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,0]) cylinder(d=extruderBearingDia+3,h=armH);
						translate([-3,-5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,0]) cylinder(d=extruderBearingDia+3,h=armH);
					}
					color( "green") hull()
					{
						translate([-15.5,-15.5,0]) cylinder(d=11+2,h=armH);
						translate([15,-27,0]) rotate([0,0,23]) cylinder(d=11,h=armH,$fn=4);
					}
				}
				// bearing hole
				color( "silver")hull()
				{
					translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-extruderClearanceH]) cylinder(r=Bearing623Diameter()/2+1.5,h=Bearing623Height()+extruderClearanceH*2,$fn=32);
					translate([0,10-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-extruderClearanceH]) cylinder(r=Bearing623Diameter()/2+1.5,h=Bearing623Height()+extruderClearanceH*2,$fn=32);
				}
				// fillamant hole
				color( "blue") translate([-50,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
				// bearing shaft
				color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,-5]) cylinder(d=3.1,h=20,$fn=16);
				//
				color( "silver") hull()
				{
					translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-0.5-0.1]) cylinder(d=8,h=0.5,$fn=16);
					translate([0,10-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-0.5-0.1]) cylinder(d=8,h=0.5,$fn=16);
				}
				//
				color( "silver") hull()
			{
				translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2+Bearing623Height()+0.1]) cylinder(d=8,h=0.5,$fn=16);
				translate([0,10-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2+Bearing623Height()+0.1]) cylinder(d=8,h=0.5,$fn=16);
			}
				color( "silver") translate([-15.5,-15.5,-5]) cylinder(d=3.05,h=40,$fn=16);
			// gear hole
			color( "green") translate([0,0,-1]) cylinder(d=gearRad*2+1,h=armH+2);
			// M3 HOLE
			color( "blue") translate([27,0,armH/2]) rotate([90,0,0]) rotate([0,-25,0])  cylinder(d=4,h=100,$fn=16);
			//color( "blue") translate([27,0,armH/2]) rotate([90,0,0]) rotate([0,-25,0])  cylinder(d=4,h=100,$fn=16);

			}
		}
		// mount to top part
		armRZ2 = printLayout ? 110 : 0;
		armRX2 = printLayout ? 90 : 0;
		armTX2 = printLayout ? 37 : 0;
		armTY2 = printLayout ? 40 : 0;
		armTZ2 = printLayout ? -2.85 : 0;
		
		translate([armX+armTX2,armY+armTY2,armZ+armTZ2]) rotate([armRX2,0,0])  rotate([0,0,armRZ2]) translate([0,0,0+partsOffset])
		{
			difference()
			{
				union()
				{
					color( "green") hull()
					{
						color( "green") translate([15.5,15.5,5]) cylinder(d=11+0.2,h=5);
						color( "green") translate([-15.5,15.5,5]) cylinder(d=11+0.2,h=5);
						color( "red") rotate([0,0,0]) translate([-21,18,5]) cube([42,3,5]);
					}
					hull()
					{
					color( "red") rotate([0,0,0]) translate([-13,18,5]) cube([26,3,5]);
					color( "red") rotate([0,0,0]) translate([-12,18,-2]) cube([24,3,5]);
					}
				hull()
				{
				color( "red") rotate([0,0,0]) translate([-2,18,-2]) cube([4,3,7]);
				color( "red") rotate([0,0,0]) translate([-1,10,5]) cube([2,1,1]);
				}
				}
				// mount hole
				color( "red") translate([15.5,15.5,-3]) cylinder(d=3,h=armH+5,$fn=32);
				//color( "red") translate([15.5,15.5,-5]) cylinder(d=rolson_hex_nut_dia(3),h=10,$fn=32);
				color( "red") translate([-15.5,15.5,-3]) cylinder(d=3,h=armH+5,$fn=32);
				translate([0,0,10]) scale([1.01,1.01,1.5]) ExtruderStepperPanel();
				//
				color( "magenta") translate([8,25,1]) rotate([90,0,0])  cylinder(d=3,h=100,$fn=16);
				color( "magenta") translate([-8,25,1]) rotate([90,0,0])  cylinder(d=3,h=100,$fn=16);
			}
		}
		translate([0,0,partsOffset])
		{
			if( !printLayout )
			{
				color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,armH/4-0.5]) Bearing623();
			}
			if( !printLayout )
			{
				// gear
				color( "black") translate([0,0,0]) cylinder(r=gearRad,h=10);
			}
				// fillament
			if( !printLayout )
			{
				color( "blue") translate([-50,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,armH/2]) rotate([0,90,0]) cylinder(d=fillamentD,h=100,$fn=16);
			}
		}
	}
}
