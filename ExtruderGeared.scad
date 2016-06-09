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
include <Modules/dimlines.scad>
include <Modules/TextGenerator.scad>
use <ExtruderGearsHelical.scad>


gap = 29.884; //distance between centres of gears 
height = 10;
bPrint = 1;
partIndex = -1;

module Gear()
{
		cylinder(d=8.5,h=11,$fn=32);
		cylinder(d=10,h=7,$fn=32);
}

module ExtruderStepperPanel(h=4)
{
	hull()
	{
		translate([-14,-14,0]) cylinder(r=7,h=h);
		translate([14,-14,0]) cylinder(r=7,h=h);
		translate([14,14,0]) cylinder(r=7,h=h);
		translate([-14,14,0]) cylinder(r=7,h=h);
		//translate([24.5+extrudeMountZOffset,9,0]) cylinder(r=7.5,h=4);
	}

}

module GearedExtruder(partIndex)
{
	if( partIndex==-1 || partIndex==5 )
	{
		translate([10+6,0,gap]) rotate([0,-90,0]) difference() 
		{
			if( bPrint==1 )
			{
				bigGear();
			}
			else
			{
				translate([0,0,-5]) cylinder(d=42,h=10,$fn=32);
			}
				
			translate([0,0,-10]) cylinder(d=5,h=20,$fn=32);
			difference() 
			{  //top bevel
				cylinder(30,30,0);
				cylinder(28,28,0);
			}
			mirror([0,0,180]) 
			translate([0,0,0]) 
			difference() 
			{ //bottom bevel
				cylinder(30,30,0);
				cylinder(28,28,0);
			}
		}
	}

	if( partIndex==-1 || partIndex==4 )
	{
		shaft5dia = 5.5;
		translate([10+6,0,0]) rotate([0,-90,0]) difference() 
		{
			union() 
			{
				if( bPrint )
				{
					translate([0,0,0]) rotate([180,0,0])
					{
							smallGear();
							translate([0,0,-height/2-2]) cylinder(d=shaft5dia,h=height+2,$fn=32);
					}
				}
				else
				{
					translate([0,0,-5]) cylinder(d=15,h=10,$fn=32);
				}
				//offset = -10;
				difference() 
				{
					union()
					{
						translate([0,0,+1]) difference()
						{
							rotate([180,0,3.8]) smallGear();
							translate([0,0,-height/2-0.1]) cylinder(d=20,h=9,$fn=32);
							translate([0,0,-height/2-1]) cylinder(d=shaft5dia,h=height+2,$fn=32);
						}

						//translate([0,0,-height/2-1]) cylinder(d=11,h=1,$fn=32);
						translate([0,0,-height/2+11]) cylinder(d=18,h=9,$fn=32);
					}
					hull()
					{
						translate([-4,0,height/2+5]) rotate([0,-90,0]) cylinder(d=7,h=2.7,$fn=6);
						translate([-4,0,height/2+5+20]) rotate([0,-90,0]) cylinder(d=7,h=2.7,$fn=6);
					}
					translate([0,0,height/2+5]) rotate([0,-90,0]) cylinder(d=3,h=20,$fn=24);
				}
			}
			difference()
			{
				translate([0,0,-20]) cylinder(d=shaft5dia,h=40,$fn=32);
				translate([0-3,-3,-10 ]) cube([.8,6,height+20]); //hole flat
			}
			
			//top bevel
			//translate([0,0,0]) difference() 
			//{  
	//			cylinder(14,14,0);
				//cylinder(12.8,12.8,0);
			//}

			//top bevel
			mirror([0,0,180]) translate([0,0,0]) difference() 
			{ 
				cylinder(14,14,0);
				cylinder(12.8,12.8,0);
			}
		}
	}

	translate([10,0,gap]) rotate([0,-90,0]) 
	{
			if( partIndex==-1 )
			{
				color("silver") translate([0,0,2]) cylinder(d=rolson_hex_nut_dia(5),h=rolson_hex_nut_hi(5),$fn=6);

				color("green") translate([0,0,-15]) cylinder(d=5,h=50,$fn=32);
				color("silver") translate([0,0,6]) Bearing625();
				color("gold") translate([0,0,16]) Gear();
				color("silver") translate([0,0,27]) Bearing625();
			}
		
			if( partIndex==-1 || partIndex==1 )
			{
				difference()
				{
					color("green") hull()
					{
							translate([-8.8,-15,5]) cube([2,30,6]);
							translate([4,0,5]) cylinder(d=20,h=6,$fn=32);
							color("silver") translate([12,8,5]) cylinder(d=6,h=6,$fn=32);
							color("silver") translate([12,-8,5]) cylinder(d=6,h=6,$fn=32);
					}
					color("silver") translate([0,0,5]) cylinder(d=13,h=10,$fn=32);
					color("silver") translate([0,0,6]) cylinder(d=17,h=10,$fn=32);
					color("silver") translate([-5,10,0]) cylinder(d=3,h=40,$fn=32);
					color("silver") translate([-5,-10,0]) cylinder(d=3,h=40,$fn=32);
					color("silver") translate([12,8,0]) cylinder(d=3,h=40,$fn=32);
					color("silver") translate([12,-8,0]) cylinder(d=3,h=40,$fn=32);
				}
			}
			
			if( partIndex==-1 || partIndex==2 )
			{
				color("magenta") translate([0,0,5]) difference()
				{
						difference()
						{
								union()
								{
				color("blue") hull()
				{
						translate([-8.8,-15,6]) cube([2,30,11+5]);
						translate([4,0,6]) cylinder(d=20,h=11+5,$fn=32);
						color("silver") translate([12,8,6]) cylinder(d=6,h=11+5,$fn=32);
						color("silver") translate([12,-8,6]) cylinder(d=6,h=11+5,$fn=32);
				}
				 //translate([5,0,9+5]) rotate([90,0,0]) cylinder(d=16,h=7.1+5+1,$fn=32);
				 translate([-3,0,6]) rotate([90,0,0]) cube([16,16,13]);
				hull()
				{
					translate([10,-5,6]) rotate([90,0,0]) cube([4.9,16,8]);
					//translate([15+1,-12-1,6]) rotate([90,0,-60]) cube([4,16,2]);
					//#translate([15,-12,6]) rotate([90,0,0]) cube([4,16,2]);
					translate([15+1,-12-1,6]) rotate([0,0,0]) cylinder(r=3,h=16,$fn=32);//([4,16,2]);
				}
				//translate([14.5,-13.5,9.0+5]) rotate([-90,0,-44]) cylinder(d=7,h=5,$fn=16);
			}

						//translate([5,-15,6+5]) cube([20,20,11]);
						//translate([7,-15,6+5]) cube([20,20,11]);
					difference()
			{
						hull()
						{
										translate([5,0,6]) cylinder(d=10,h=11.2+5);
										translate([15,0,6]) cylinder(d=11,h=11.2+5);
						}
						//translate([10,0,12]) rotate([0,0,0]) cylinder(d=11,h=20+1,$fn=32);
						difference()
						{
						color("silver") translate([5,-6,6]) rotate([0,0,45]) cylinder(d=5,h=20+1,$fn=32);
						translate([10,0,6]) rotate([0,0,0])  cylinder(d=11.5,h=20+1,$fn=32);
						}
					}
						color("silver") translate([12,8,6-0.1]) cylinder(d=10,h=11.2+5,$fn=32);
				}
				
				// fillamant
				#translate([5,20,9.0+5]) rotate([90,0,0]) cylinder(d=1.75,h=50,$fn=16);
				
				#translate([5,-3.5,9.0+5]) rotate([90,0,0]) cylinder(r1=4/2,r2=1.75/2,h=2,$fn=16);

				 translate([5,-8,9+5]) rotate([90,0,0]) cylinder(d=9,h=5,$fn=32);
				 translate([-3,-13,6-0.1]) rotate([90,0,0]) cube([15,16.2,20]);
				 translate([-3,-15.5,0]) scale([1,1,1]) cylinder(d=5,h=40,$fn=32);
				 translate([12,-15.5,0]) scale([1,1,1]) cylinder(d=5,h=40,$fn=32);
				 //#translate([5,-13,9+5]) rotate([90,0,0]) cylinder(d=16,h=7+2,$fn=32);

				//color("silver") translate([0,0,6-0.1]) cylinder(d=16.2,h=5+1.2,$fn=32);
		//		difference()
				{
					color("silver") translate([0,0,6-0.1]) cylinder(d=12,h=20+1,$fn=32);
						translate([10,0,6]) rotate([0,0,0])  cylinder(d=11.5,h=20+1,$fn=32);
				}
				color("silver") translate([-5,10,0]) cylinder(d=3,h=40,$fn=32);
				color("silver") translate([-5,-10,0]) cylinder(d=3,h=40,$fn=32);
				color("silver") translate([12,8,0]) cylinder(d=3,h=40,$fn=32);
				color("silver") translate([12,-8,0]) cylinder(d=3,h=40,$fn=32);

				//color("silver") translate([0,0,6+5]) cylinder(d=9.2,h=11+1,$fn=32);
				#translate([10,0,12]) rotate([0,0,0]) Bearing623();
				#color("silver") translate([0,0,6-0.1]) cylinder(d=10,h=20+1,$fn=32);

			hull()
			{
				translate([12-1,-15.5,9.0+5]) rotate([-90,0,-44]) cylinder(d=3,h=50,$fn=16);
			 //translate([12,-15.5,9.0+5]) rotate([-90,0,-50]) cylinder(d=3,h=50,$fn=16);
			}
				}
				//   color("red") 
		//    difference()
				//{
						//translate([5,-3,19]) rotate([90,0,0]) cylinder(d=16.5,h=17,$fn=32);
						//translate([5,-13,19]) rotate([90,0,0]) cylinder(d=10,h=7.1,$fn=16);
				//}

			}

			if( partIndex==-1 || partIndex==3 )
			{

			translate([0,0,21]) difference()
			{
			color("green") hull()
			{
					translate([-8.8,-15,6]) cube([2,30,5]);
					translate([4,0,6]) cylinder(d=20,h=5,$fn=32);
					color("silver") translate([12,8,6]) cylinder(d=6,h=5,$fn=32);
					color("silver") translate([12,-8,6]) cylinder(d=6,h=5,$fn=32);
			}
			color("silver") translate([0,0,6]) cylinder(d=16.2,h=10,$fn=32);
			color("silver") translate([-5,10,0]) cylinder(d=3,h=40,$fn=32);
			color("silver") translate([-5,-10,0]) cylinder(d=3,h=40,$fn=32);
			color("silver") translate([12,8,0]) cylinder(d=3,h=40,$fn=32);
			color("silver") translate([12,-8,0]) cylinder(d=3,h=40,$fn=32);
			}
			//hull()
			{
			 //   color("blue") translate([-8.8,-15,6]) cube([5,30,10]);
			}
			}

			if( partIndex==-1 || partIndex==6 )//|| partIndex==2 )
			{

			difference()
			{
			union()
			{
			hull()
			{
				color("silver") translate([12,8,6+5]) cylinder(d=8,h=11+5,$fn=32);
				color("silver") translate([12,8-8,6+5]) cylinder(d=8,h=11+5,$fn=32);
			}
			hull()
			{
				color("silver") translate([12,8-8.5,6+5]) cylinder(d=8,h=11+5,$fn=32);
				color("silver") translate([12-2,8-8,6+5]) cylinder(d=10,h=11+5,$fn=32);
			}
			hull()
			{
				color("silver") translate([12,8,6+5]) cylinder(d=8,h=11+5,$fn=32);
				#color("silver") translate([12+9+2,8-18,6+5]) cylinder(d=6,h=11+5,$fn=32);
			}

			#translate([10,0,5+6+6]) rotate([0,0,0]) Bearing623();
			}
			translate([10,0,6+5+5.5]) rotate([0,0,0]) cylinder(d=11.5,h=5);
			translate([10,0,6]) rotate([0,0,0]) cylinder(d=3,h=25,$fn=32);
			translate([10,0,6+2+2]) rotate([0,0,1800]) cylinder(d=rolson_hex_nut_dia(3),h=3,$fn=6);
			translate([10,0,6+5+5+5+4]) rotate([0,0,0]) cylinder(d=rolson_hex_nut_dia(3),h=3,$fn=15);
			color("silver") translate([12,8,0]) cylinder(d=3,h=40,$fn=32);
			hull()
			{
			translate([12,-15.5,9.0+5+5]) rotate([-90,0,-44]) cylinder(d=3,h=50,$fn=16);
			translate([12,-15.5-20,9.0+5+5]) rotate([-90,0,-50]) cylinder(d=3,h=50,$fn=16);
			}
			}
			}
	}
	if( partIndex==-1 || partIndex==1 )
	{
		difference()
		{
			translate([5,0,0]) rotate([0,-90,0]) ExtruderStepperPanel(6);
			rotate([90,0,0]) rotate([0,-90,0]) Nema17_shaft24_Stepper(bSrewsOnly=1,NemaSize=NemaLengthMedium);
			translate([5,0,0]) rotate([0,-90,0]) cylinder(d=23,h=45,$fn=32);
		}
	}

	if( partIndex==-1  )
	{
		rotate([90,0,0]) rotate([0,-90,0]) Nema17_shaft24_Stepper(bSrewsOnly=0,NemaSize=NemaLengthMedium);
	}
}


module extruder()
{
	GearedExtruder(-1);
}

extruder();