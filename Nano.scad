// Author: Pavlo Gryb (psg416@gmail.com)

use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>
use <Modules/EndStoppers.scad>
include <Modules/MCAD/stepper.scad>
use <Modules/Belt_Generator.scad>


m5Rclearance = 0.1;
m5Hclearance = 0.2;
b625RClearance = 0.2;
b608Clearance = 0.3;
outerRad = (80*2/3.14*0.5);

drawIndex = 0;//28;//23;//19;//18;//17;//14;//4;//0;//4;//6;//5;//4;//5;//4;//4;//0;//3;//0;

// more printer friedly layout (note: not all parts are done)
printLayout = 0;


drawSteppers = 1;
drawBelts = 0;
drawSwitchesAll = 0;

isExpolode = 0;
pulley1H = 10.5;
pulley2H = 9;
//cylinder(r=4,h=30);
smallHolesDia = 1.55;

endStopArmH = 2.5;

shaftRadius = 5.1/2;
shaftsSegments = 32;
pulleysSpace = 0.5;

bottomArmH = 10;
topArmH = 10;
Arm1Len = 70;
Arm2Len = 80;



//translate([-25,110,-24]) cube([24,24,24]);
//translate([0,150,0])  Nema17_shaft24_Stepper();

xStepperX = 25;
xStepperY = 110;
xStepperZ = 32-Bearing625Height();

yStepperX = -25;
yStepperY = 110;
yStepperZ = 32-Bearing625Height();

gearRadToTeethEnd = 7.3/2;// seems like mk8
gearRad = 9.5/2;// semms like mk8
fillamentD = 1.75;
fillamentPenetration = 0.5;//mm
extruderBearingDia = Bearing623Diameter();
extruderBearingH = Bearing623Height();
extruderClearanceH = 0.2;

armsZ = 250;
armsZExtra = 15;//15;
armsExtruderExtra = 0;
extrudeMountZOffset = 0;

ArmNearestD = 8+8;
ArmNearestW = 8;

x = 0;
y = 35;// offset from axis to printed area

// extruder
if( drawIndex==23 || drawIndex==0 )
{
	aY = printLayout ? 0 : 65+90;
	aYY = printLayout ? 180 : -90;
	armX = printLayout ? 25 :0;
	armY = printLayout ? -15 : 0;
	armZ = printLayout ? 4 : 0;
	armRZ = printLayout ? 90 : 0;
	translate ([0,-37,222+armsExtruderExtra]) rotate([0,aYY,180]) rotate([0,0,aY]) mirror()//rotate([90,0,0]) 
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
				hull()
				{
					translate([-14,-14,0]) cylinder(r=7.5,h=4);
					translate([14,-14,0]) cylinder(r=7.5,h=4);
					translate([14,14,0]) cylinder(r=7.5,h=4);
					translate([-14,14,0]) cylinder(r=7.5,h=4);
					translate([24.5+extrudeMountZOffset,9,0]) cylinder(r=7.5,h=4);
				}
				extr = lookup(NemaRoundExtrusionDiameter, Nema17);
				color ("red") translate([0,0,1.5]) cylinder(d=extr+0.5,h=2.5,$fn=32);
				color ("red") translate([0,0,2]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				//extruder mount
				translate([27,10.5,-30+extrudeMountZOffset]) color("red") rotate([0,0,0]) cylinder(d=3.1,h=50,$fn=16);
				translate([25.4,3.5,-30+extrudeMountZOffset]) color("red") rotate([0,0,0]) cylinder(d=3.1,h=50,$fn=16);
			}
			difference()
			{
				color ("red")  translate([3,9.5,-armH]) cube([9,12,armH]);
				color( "blue") translate([2,16,-armH/2]) rotate([0,90,0]) cylinder(r=4,h=3,$fn=16);
			}
			difference()
			{
				color ("red")  translate([5,-12,-armH]) cube([10,14,armH]);
				color( "green") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3-1]) cylinder(d=extruderBearingDia+8,h=armH+2);

				color( "blue") translate([-50,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,-armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
				color( "blue") translate([10,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,-armH/2]) rotate([0,90,0]) cylinder(d=8.5,h=100,$fn=16);
			}
		}
		//#color ("red") translate([0,0,0]) cube([10,10,10]);
		translate([armX,armY,armZ]) rotate([0,0,armRZ]) translate([0,0,partsOffset])
		{
			difference()
			{
				union()
				{
					color( "green") hull()
					{
						color( "green") translate([-15.5,-15.5,0]) cylinder(d=11+2,h=armH);
						color( "green") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,0]) cylinder(d=extruderBearingDia+6,h=armH);
						color( "green") translate([-12,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,0]) cylinder(d=extruderBearingDia+6,h=armH);
					}
					color( "red") hull()
					{
						color( "green") translate([-15.5,-15.5,0]) cylinder(d=11+2,h=armH);
						color( "green") translate([-15.5,14.5,0]) cylinder(d=11+2,h=armH);
						//color( "green") translate([-11.5,-7.5,0]) cylinder(d=11,h=armH);
					}
					color( "blue") hull()
					{
						translate([-11.5,19,0]) cylinder(d=5,h=armH);
						translate([-11.5,12,0]) cylinder(d=5,h=armH);
						translate([-20,15.5,0]) cylinder(d=11+2,h=armH);
						translate([-15.5,5,0]) cylinder(d=11,h=armH);
						translate([-26,5.5,0]) cylinder(d=11+2,h=armH);
					}
					//color( "gold") translate([-11,16,armH/2]) rotate([0,90,0]) cylinder(r1=5,r2=4.5,h=2,$fn=16);
					//color( "gold") translate([-11,16,armH/2]) rotate([0,90,0]) cylinder(r1=3,r2=0.5,h=5,$fn=16);
				}
				color( "gold") translate([-13,16,armH/2]) rotate([0,90,0]) cylinder(r=4,h=5,$fn=16);
				color( "gold") translate([0,0,-1]) cylinder(r=gearRad+0.3,h=10+2);
				hull()
				{
					color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-extruderClearanceH]) cylinder(r=Bearing623Diameter()/2+1,h=Bearing623Height()+extruderClearanceH*2,$fn=32);
					color( "silver") translate([0,10-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-extruderClearanceH]) cylinder(r=Bearing623Diameter()/2+1,h=Bearing623Height()+extruderClearanceH*2,$fn=32);
				}
				hull()
				{
					color( "blue") translate([-50,-1-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
					color( "blue") translate([-50,1-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
					color( "blue") translate([-50,-gearRadToTeethEnd-fillamentD/2+fillamentPenetration,armH/2]) rotate([0,90,0]) cylinder(d=fillamentD+0.2,h=100,$fn=16);
				}
				color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,-5]) cylinder(d=3.1,h=20,$fn=16);
				color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2-0.5]) cylinder(d=8,h=0.5,$fn=16);
				color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,(armH-Bearing623Height())/2+Bearing623Height()]) cylinder(d=8,h=0.5,$fn=16);
				color( "silver") translate([-15.5,-15.5,-5]) cylinder(d=3.05,h=40,$fn=16);
			}
		}
		if( !printLayout )
		{
			// spring
			color( [1,1,1,0.5] ) translate([-12,16,-armH/2-3]) rotate([0,90,0]) cylinder(d=7.5,h=20,$fn=16);
		}
		translate([0,0,partsOffset])
		{
			if( !printLayout )
			{
				color( "silver") translate([0,-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,armH/4]) Bearing623();
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

l = Arm1Len;
L = Arm2Len;

l2 = l * l;
L2 = L * L;

dhalf = 0;
A = -2 * l * (x - dhalf);
B = -2 * y * l;
C = (x - dhalf) * (x - dhalf) + y * y + l2 - L2;
F = (x + dhalf) * (x + dhalf) + y * y + l2 - L2;
E = -2  * l * (x+dhalf);
Det1 = B * B - (C * C - A * A);
Det2 = B * B - (F * F - E * E);

qq11 = (-B - sqrt(Det1)) / (C - A);
q11 = 2 * atan(qq11);
qq12 = (-B + sqrt(Det1)) / (C - A);
q12 = 2 * atan(qq12);

qq21 = (-B - sqrt(Det2)) / (F - E);
q21 = 2 * atan(qq21);
qq22 = (-B + sqrt(Det2)) / (F - E);
q22 = 2 * atan(qq22);

//echo (q22);

if( drawIndex==0 )
{
	translate ([x,y,armsZ+armsZExtra-15])
	{
		color("red") cylinder(r=3,h=40);
		translate ([0,0,-6])
			color("red") cylinder(r1=1,r2=5,h=6);
		translate ([-5,-7,0])
			color("red") cube([10,20,10]);
	}
}

// bottom arm
if( drawIndex==24 || drawIndex==0 )
{
	translate ([0,0,armsZ+armsZExtra]) rotate([0,0,q22])
	{
		//cylinder(r=Bearing623Diameter()+2,h=bottomArmH+Bearing625Height());
		difference()
		{
			union()
			{
				hull()
				{
					cylinder(r=ArmNearestD/2,h=bottomArmH);
					translate([Arm1Len*0.15,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Arm1Len,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					translate([Arm1Len*0.85,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Arm1Len,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
				}
				translate([6,6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=12,$fn=12);
			}
			translate([Arm1Len,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([Arm1Len,0,-1]) cylinder(r=rolson_hex_nut_dia(3)/2,h=bottomArmH+2);
			//translate([0,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([0,0,-1]) cylinder(r=4,h=bottomArmH+2);
			translate([0,-0.5,-1]) cube([10.5,1,bottomArmH+2]);
			color("red") translate([6,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100);
			color("red") translate([6,16,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			color("red") translate([6,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
		}
	}
}

	translate ([0,0,armsZ+armsZExtra]) rotate([0,0,q22])
	{
		color("red") translate([0,0,-armsZExtra-2]) cylinder(r=ArmNearestW-0.5,h=armsZExtra+2);
	}


if( drawIndex==25 || drawIndex==0 )
{
	translate ([0,0,armsZ+bottomArmH+armsZExtra])
	{
		Bearing625();
	}
}


if( drawIndex==25 || drawIndex==0 )
{
	translate ([0,0,armsZ+bottomArmH+armsZExtra])
	{
			color("blue") hull() 
			{
				 rotate([0,0,q22]) translate([Arm1Len,0,0]) rotate([0,0,0])
				{
					color("red")cylinder(r=ArmNearestW,h=bottomArmH);
				}
				color("red") translate([x,y,0]) cylinder(r=ArmNearestW,h=bottomArmH);
			}
	}
}
// top arm
if( drawIndex==26 || drawIndex==0 )
{
	translate ([0,0,armsZ+bottomArmH+armsZExtra+Bearing625Height()]) rotate([0,0,q11])
	{
		hull()
		{
			color("red")cylinder(r=ArmNearestW,h=bottomArmH);
			color("red") translate([Arm1Len,0,0]) cylinder(r=ArmNearestW,h=bottomArmH);
		}
	}
}

if( drawIndex==27 || drawIndex==0 )
{
	translate ([0,0,armsZ+armsZExtra])
	{
			color("blue") hull() 
			{
				rotate([0,0,q11]) translate([Arm1Len,0,0]) rotate([0,0,0])
				{
					color("red")cylinder(r=ArmNearestW,h=bottomArmH);
				}
				color("red") translate([x,y,0]) cylinder(r=4+3,h=bottomArmH);
			}
	}
}

if( drawIndex==0 )
{
	translate ([0,-65,0]) cylinder(r=3,h=300);
}


if( drawIndex==0 )//|| drawIndex==5 )//) 
{
  // z stepper
  translate([0,83,49]) rotate([90,0,0])
  {
    translate( [0,0,45]) rotate([180,0,0]) Nema17_shaft24_Stepper();
    translate ([0,0,52]) Pulley16Teeth();
  }

  // x stepper
  translate([xStepperX,xStepperY,xStepperZ])
  {
		if( drawSteppers )
			rotate([0,0,-90]) Nema17_shaft24_Stepper();
    translate ([0,0,-6]) rotate([180,0,0]) Pulley16Teeth();
  }
  // y stepper
  translate([-25,110,32-Bearing625Height()])
  {
		if( drawSteppers )
			rotate([0,0,-90]) Nema17_shaft24_Stepper();
    translate ([0,0,-18]) rotate([0,0,0]) Pulley16Teeth();
  }
}
// bottom
//if( drawIndex==0 ) translate([-50,-30,-5]) color ("grey") cube([100,160,5]);

// bed
//if( drawIndex==0 ) translate([-50,25,85]) color ([1,0.5,0.5,0.3]) cube([100,100,3]);

rodOffsetX = 40;
rodOffsetY = 15;

// rods
if( drawIndex==0 ) 
	translate([rodOffsetX,rodOffsetY/*+20*/,40+isExpolode*75]) color ("silver") cylinder(r=3,h=200);

if( drawIndex==0 ) 
	translate([-rodOffsetX,rodOffsetY,40+isExpolode*75]) color ("silver") cylinder(r=3,h=200);

if( drawIndex==0 ) Bearing625();

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+isExpolode*5]) color( "Silver") hex_nut(5);

// rods bearing
if( drawIndex==0 ) translate([rodOffsetX,rodOffsetY,65]) color ("silver") cylinder(d=12,h=19);
//if( drawIndex==0 ) translate([rodOffsetX,rodOffsetY,65+19]) color ("silver") cylinder(d=12,h=19);


// belts
if( drawIndex==0 || drawBelts==1 ) 
{
  color ("black") translate([26,0,6.5]) rotate([0,0,88]) cube([110,1.5,6]);
  color ("black") translate([-20,15,6.5]) rotate([0,0,67]) cube([110,1.5,6]);
	translate([31,70,6.5]) rotate([0,0,178]) BeltClip();

  color ("black") translate([20,15,17.5]) rotate([0,0,112]) cube([110,1.5,6]);
  color ("black") translate([-26,0,17.5]) rotate([0,0,92]) cube([110,1.5,6]);
	translate([-33,60,23.5]) rotate([180,0,3]) BeltClip();
}

if( drawIndex==13 ) 
{
	translate([-7,0,9]) rotate([0,180,0]) BeltClip();
	translate([7,20,9]) rotate([0,180,180]) BeltClip();
}

// pulley1
if( drawIndex==1 || drawIndex==0 )//|| drawIndex==4 )
{
	translate([0,0,Bearing625Height()+isExpolode*10])
	{	
		ArmPulley(numBigHoles=5,retainerH=endStopArmH);
		translate([0,0,pulley1H-endStopArmH]) rotate([0,0,0])
		hull()
		{
      rotate([0, 0, 197])
          translate([outerRad+7, 0, 0])
          cylinder(r=2,h=endStopArmH);
      rotate([0, 0, 202])
          translate([outerRad, 0, 0])
          cylinder(r=2,h=endStopArmH);
      rotate([0, 0, 185])
          translate([outerRad, 0, 0])
          cylinder(r=2,h=endStopArmH);
		}
	}
}

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+pulley1H+isExpolode*15]) color( "Silver") hex_nut(5);

// pulley2
if( drawIndex==2 || drawIndex==0 )
{
	translate ([0,0,Bearing625Height()+pulley1H+pulleysSpace+isExpolode*20]) 
	{
		//color([0,1,0,0.1]) 
		color( "Goldenrod") difference()
		{
			//echo (pulley2H-(rolson_hex_nut_hi(5)+m5Hclearance));
			//echo ((rolson_hex_nut_hi(5)+m5Hclearance));
			ArmPulley(numBigHoles=3,numSmallHoles=3,smallHolesDist=12,smallHolesDia=1.55,bigHolesRadScale=0.85,bigHolesOffset=2);
			cylinder(d=rolson_hex_nut_dia(5)+1,h=pulley2H);
			translate ([0,0,rolson_hex_nut_hi(5)])
				cylinder(r=Bearing625Diameter()/2,pulley2H);
		}
		//echo(Bearing625Height());
		if( drawIndex!=2 ) translate ([0,0,rolson_hex_nut_hi(5)+isExpolode*25]) Bearing625();	
		//if( drawIndex!=2 ) color( "red") translate ([0,0,rolson_hex_nut_hi(5)+m5Hclearance+isExpolode*25]) cylinder(d=rolson_hex_nut_dia(5)+1,h=5);
	}
}

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+pulley1H+pulley2H+pulleysSpace+isExpolode*30]) color( "Silver") hex_nut(5);

if( drawIndex==0 )
{
	translate([-28,-13,11]) rotate([180,180,0]) EndSwitchBody20x11();
	translate([-28,-13,Bearing625Height()+pulley1H+pulley2H-1]) rotate([180,180,0]) EndSwitchBody20x11();
}

if( drawIndex==14 || drawIndex==0)
{
	difference()
	{
		translate([-48,-23,Bearing625Height()+pulley1H+pulley2H-7]) cube([20,10,6]);
		translate([-28,-13,11]) rotate([180,180,0]) EndSwitchBody20x11(1);
	}
}

if( drawIndex==0 ) translate([0,0,Bearing625Height()+pulley1H+pulley2H+pulleysSpace+isExpolode*45]) Bearing625();

// puter tube holder - mounted to pulley2 (top)
if( drawIndex==3 || drawIndex==0 )
{
	rotate([0,0,0])//90])
	{
    translate ([0,0,Bearing625Height()+pulley1H+pulley2H+pulleysSpace+isExpolode*55]) 
    {
        difference()
        {
          union()
          {
            difference()
            {
              cylinder(r=outerRad*0.7,h=endStopArmH);
              cylinder(d=rolson_hex_nut_dia(5)+1,h=endStopArmH+0.1);
            };
            translate([0,0,endStopArmH]) cylinder(r1=outerRad*0.7,r2=4+4,h=6);
            translate([0,0,endStopArmH+6]) cylinder(r=4+4.5,h=1);
            translate([0,0,8]) 
            {
              difference()
              {
                union()
                {
                  cylinder(r=4+4.5,h=15);
                  translate([9,0,-4]) cylinder(r=5,h=19);
                }
                translate([0,-0.25,3]) cube([20,0.5,15]);
                translate([8,10,9]) rotate([90,0,0]) cylinder(r=1.55,h=25,$fn=12);
                translate([8,-4.8,9]) rotate([90,0,0]) cylinder(r=(rolson_hex_nut_dia(3)+1)/2,h=10);
                translate([8,4.8+10,9]) rotate([90,0,0]) cylinder(r=(rolson_hex_nut_dia(3)+1)/2,h=10);
              }
            }
            translate([0,0,0]) 
            hull()
            {
              rotate([0, 0, 197])
                  translate([outerRad+7, 0, 0])
                  cylinder(r=2,h=endStopArmH+1);
              rotate([0, 0, 202])
                  translate([outerRad, 0, 0])
                  cylinder(r=2,h=endStopArmH);
              rotate([0, 0, 215])
                  translate([outerRad-10, 0, 0])
                  cylinder(r=2,h=endStopArmH+1);
              rotate([0, 0, 185])
                  translate([outerRad, 0, 0])
                  cylinder(r=2,h=endStopArmH+1);
              rotate([0, 0, 180])
                  translate([outerRad-10, 0, 0])
                  cylinder(r=2,h=endStopArmH+1);
            }
        }
        for (i = [0:3-1]) 
        {
            rotate([0, 0, (360/3)*i+60])
            translate([12, 0, 0])
            cylinder(r=smallHolesDia,h=10,$fn=16);

            rotate([0, 0, (360/3)*i+60])
            translate([12, 0, 4])
            cylinder(r=(rolson_hex_nut_dia(3)+1)/2,h=5.5,$fn=20);

        }

        translate([0,0,endStopArmH])
          cylinder(d=rolson_hex_nut_dia(5)+1,h=5);

        translate([0, 0, endStopArmH+7]) cylinder(r=4,h=200,$fn=shaftsSegments);
        translate([0, 0, 0]) cylinder(r=shaftRadius,h=200,$fn=shaftsSegments);
        translate([0, 0, 0]) cylinder(d=Bearing625Diameter()+b625RClearance,h=2,$fn=32);
      }
    }
  }
}

// center tube
if( drawIndex==0 )
{
	translate ([0,0,Bearing625Height()+pulley1H+pulley2H+9+isExpolode*140]) 
		color("silver")
	{
		difference()
		{
				cylinder(r=4,h=300);
				cylinder(r=3,h=300);
		}
	}
}

//if( drawIndex==0 ) translate([30,0,0]) cube([10,10,50]);

// bottom base for big pulleys+end stoppers mount
if( drawIndex==4 || drawIndex==0 )
{
  difference()
  {
    union()
    {
      translate([-48,-24,0]) 
        color("red") rotate([0,0,0]) scale([1,1,1])
          cube([60,24,5]);

      translate([-48,-24,0]) 
        color("blue") rotate([0,0,0]) scale([1,1,1])
          cube([20,24,11]);

			translate([13,-24,0]) 
				color("red") rotate([0,0,0]) scale([1,1,1]) cube([35,24,5]);

      hull()
      {
        height = 30;//Bearing625Height()+pulley1H+pulley2H+32;//30
        translate([0,-8,0]) color("blue") cylinder(d=30,h=height);

        translate([40,0,0]) 
        color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

        translate([-40,0,0]) 
        color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
      }
      color("blue") cylinder(d=56,h=5);


      rodsSupportH = 5;
      difference()
      {
        hull()
        {
          translate([rodOffsetX,rodOffsetY,-0]) cylinder(r=3+5,h=rodsSupportH);
          translate([40,0,0]) color("red") rotate([0,0,0]) cylinder(d=15,h=rodsSupportH,$fn=16);
        }
        translate([rodOffsetX,rodOffsetY,-0.1]) color("red") cylinder(r=1.51,h=rodsSupportH+1,$fn=12);
      }
      difference()
      {
        hull()
        {
          translate([-rodOffsetX,rodOffsetY,-0]) cylinder(r=3+5,h=rodsSupportH);
          translate([-40,0,0])color("red") rotate([0,0,0]) cylinder(d=15,h=rodsSupportH,$fn=16);
        }
          translate([-rodOffsetX,rodOffsetY,-0.1]) color("red") rotate([0,0,0]) cylinder(r=1.51,h=rodsSupportH+1,$fn=12);
      }
			// center mount
			difference()
			{
				union()
				{
					color ("magenta") 
					{
						translate([-35,0,0]) cube([70,30,5]);
						hull()
						{
							translate([-47.5,17,0]) cube([95,3,5]);
							translate([-47.5,29,0]) cube([95,5,5]);
						}
					}
					/*
					color ("green") translate([-24,30,0]) cube([48,4,20]);
					hull()
					{
						color ("green") translate([-24,27,0]) cube([4,3,20]);
						color ("green") translate([-24,25,0]) cube([4,3,20]);
					}
					//color ("green") translate([-24,27,0]) cube([7,3,28.5]);
					hull()
					{
						color ("green") translate([24-4,27,0]) cube([4,3,20]);
						color ("green") translate([24-4,25,0]) cube([4,3,1]);
					}
					color ("green") translate([-24,25,0]) cube([48,9,29]);
					*/
				}
				
				color ("red") translate([-15,28,5]) cube([30,10,20]);
				translate([0,83,49]) rotate([90,0,0])
				{
					translate( [0,0,45]) rotate([180,0,0]) Nema17_shaft24_Stepper(bSrewsOnly=1);
								color ("silver") translate([0,0,45]) cylinder(d=23,h=10,$fn=32);
				}
				translate([40,28,-0.2]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.51,h=rodsSupportH+1,$fn=16);
				translate([-40,28,-0.2]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.51,h=rodsSupportH+1,$fn=16);

			}
			// center support
			color ("red") translate([-7.5,26,5]) cube([15,8,7.8]);

			// extra
      height = 30;
			///*
			hull()
			{
				translate([rodOffsetX,rodOffsetY-11,-0]) rotate([0,0,45]) cylinder(r=3+8,h=height,$fn=4);
				translate([40,0,0]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
			}
			//*/
			///*
			hull()
			{
				translate([-rodOffsetX,rodOffsetY-11,-0]) rotate([0,0,45]) cylinder(r=3+8,h=height,$fn=4);
				translate([-40,0,0]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
			}
			//*/
		}
		translate([0,0,5]) color("green") cylinder(d=60,h=Bearing625Height()+pulley1H+pulley2H+35+5);

		color("red") translate([0,38,8.5]) rotate([90,0,0]) scale([1,1,1]) cylinder(r=1.51,h=28,$fn=16);


		color ("magenta") hull()
		{
			color("red") translate([-28,13,15]) rotate([90,0,0]) scale([1,1,1]) cylinder(d=13,h=28,$fn=16);

			color("red") translate([-28,13,27]) rotate([90,0,0]) scale([1,1,1]) cylinder(d=13,h=28,$fn=16);
		}

		mirror() color ("magenta") hull()
		{
			color("red") translate([-28,13,15]) rotate([90,0,0]) scale([1,1,1]) cylinder(d=13,h=28,$fn=16);

			color("red") translate([-28,13,27]) rotate([90,0,0]) scale([1,1,1]) cylinder(d=13,h=28,$fn=16);
		}

		translate([40,0,0-0.1]) 
		{
			color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=Bearing625Height()+pulley1H+pulley2H+35+isExpolode*45+5,$fn=16);
			color("red") translate([0,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.1,h=rolson_hex_nut_hi(3)+0.5,$fn=6);
		}
		translate([-40,0,0-0.1]) 
		{
			color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=Bearing625Height()+pulley1H+pulley2H+35+isExpolode*45+5,$fn=16);
			color("red") translate([0,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.1,h=rolson_hex_nut_hi(3)+0.5,$fn=6);
		}

		translate([-48,-13,11]) 
		color("blue") rotate([0,0,0]) scale([1,1,1])
			cube([20,5,20]);

		color("red") translate([0,0,0.5]) cylinder(d=Bearing625Diameter()+b625RClearance,h=Bearing625Height());
		color("red") translate([0,0,-0.1]) cylinder(d=5+b625RClearance,h=5);

		translate([-28,-13,0]) rotate([180,180,0]) EndSwitchBody20x11(1);

		translate([-26,-20,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.51,h=50,$fn=16);
		translate([-26,-20,5]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+0.1,h=50,$fn=6);

		translate([26,-20,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.51,h=50,$fn=16);
		translate([26,-20,5]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+0.1,h=50,$fn=6);
		translate([42,-20,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.51,h=50,$fn=16);
		translate([34,-14,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.51,h=50,$fn=16);

				// hhhh
				//#color ("silver") translate([0,0,24]) cylinder(r=outerRad+10,h=5,$fn=32);
				color ("silver") translate([0,0,13]) cylinder(r=outerRad+9.3,h=17,$fn=32);


  }
}


// upper pulley+tube support for bearing
if( drawIndex==5 || drawIndex==0 )
{
  translate([0,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*45]) 
  {
		if( drawIndex==0 || drawSwitchesAll==1)
		{
			translate([-12,18.5,-10]) rotate([-90,0,180]) EndSwitchBody20x11();
		}
    height = Bearing608Height();
    difference()
    {
      color("blue") 
      union()
      {
				difference()
				{
					translate([-33,7,-22]) cube([21,5,29]);
					translate([-12,18.5,-10]) rotate([-90,0,180]) EndSwitchBody20x11(1);
				}
        cylinder(d=Bearing608Diameter()+12,h=Bearing608Height());
        difference()
        {
          hull()
          {
            translate([0,-8,0]) color("blue") cylinder(d=30,h=height);

            translate([40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

            translate([-40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
          }
          translate([-25,-35,-0.5]) cube([50,20,height+1]);
        }
        //
        rodsSupportH = 33.5;
        color("blue") translate([0,0,-rodsSupportH+height]) 
        {
          hull()
          {
            translate([rodOffsetX,rodOffsetY,-0]) cylinder(r=3+5,h=rodsSupportH);
            translate([40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=rodsSupportH,$fn=16);
          }
          hull()
          {
            translate([-rodOffsetX,rodOffsetY,-0]) cylinder(r=3+5,h=rodsSupportH);
            translate([-40,0,0])color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=rodsSupportH,$fn=16);
          }
          /////
          difference() 
          {
            hull()
            {
              height = 30;//Bearing625Height()+pulley1H+pulley2H+32;//30
              translate([0,-8,0]) color("blue") cylinder(d=30,h=height);

              translate([40,0,0]) 
              color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

              translate([-40,0,0]) 
              color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            }
            translate([0,0,-0.1]) color("green") cylinder(d=60,h=Bearing625Height()+pulley1H+pulley2H+35+5+0.1);
          }
        }
      }
      color( "red") translate([0,0,2]) cylinder(d=Bearing608Diameter()+b608Clearance,h=Bearing608Height()+15);
      color( "red") translate([0,0,-1]) cylinder(d=9,h=Bearing608Height()+15);
      translate([-40,0,-50]) 
      color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);

      translate([40,0,-50]) 
      color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);

      // rods holes
      translate([-rodOffsetX,rodOffsetY,-23]) cylinder(r=3.2,h=35,$fn=16);

      translate([-rodOffsetX-0.5,rodOffsetY-10,-23]) cube([1,10,40]);

      translate([-rodOffsetX-10,rodOffsetY-5,-0]) rotate([0,90,0]) cylinder(d=3.2,h=35,$fn=16);
      translate([-rodOffsetX+8,rodOffsetY-5,-0]) rotate([0,90,0]) rotate([0,0,30]) cylinder(d=rolson_hex_nut_dia(3)+1,h=5,$fn=6);

      translate([-rodOffsetX+67,rodOffsetY-5,-0]) rotate([0,90,0]) rotate([0,0,30]) cylinder(d=rolson_hex_nut_dia(3)+1,h=5,$fn=6);

      // rods holes
      translate([rodOffsetX,rodOffsetY,-23]) cylinder(r=3.2,h=35,$fn=16);

      translate([rodOffsetX-0.5,rodOffsetY-10,-23]) cube([1,10,40]);

      translate([rodOffsetX-10,rodOffsetY-5,-0]) rotate([0,90,0]) cylinder(d=3.2,h=35,$fn=16);
			
			translate([-10,15.5,-0.1]) cube([20,10,40]);
			translate([-13.7,12.5,-0.1]) cube([5,5,40]);
    }
  }
}

if( drawIndex==0 ) 
	translate ([0,0,Bearing625Height()+pulley1H+pulley2H+34+isExpolode*65]) Bearing608(); 

// upper bearing mount
if( drawIndex==6 || drawIndex==0 )
{
  translate([0,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()]) 
  {
    height = 2+3;
    difference()
    {
      color("blue") 
      union()
      {
        cylinder(d=Bearing608Diameter()+12,h=height);
        difference()
        {
          hull()
          {
            translate([0,-8,0]) color("blue") cylinder(d=30,h=height);

            translate([40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

            translate([-40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
          }
          translate([-25,-35,-0.5]) cube([50,20,height+1]);
        }
      }
			// bearing hole
      color( "red") translate([0,0,-Bearing608Height()+2]) cylinder(d=Bearing608Diameter()+b608Clearance,h=Bearing608Height()+0.2);
      color( "red") translate([0,0,-1]) cylinder(d=9,h=Bearing608Height()+15);
			// mount holes
      translate([-40,0,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,0,-50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
			// end stopper fit
			translate([-10,15.5,-0.1]) cube([20,10,40]);
			translate([-13.7,12.5,-0.1]) cube([5,5,40]);
    }
  }
}

if( drawIndex==17 || drawIndex==0 )
{
	offset = drawIndex==17 ? 10 : 40;
	difference()
	{
		union()
		{
					translate([-offset,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()-2]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=15,$fn=16);
					translate([offset,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()-2]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=15,$fn=16);
		}
		// mount holes
		translate([-offset,0,50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
		translate([offset,0,50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
		// m5 nuts
		translate([-offset,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()-2-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3),$fn=6);
		translate([offset,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()-2-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3),$fn=6);
	}
}

// ramps bottom mount
if( drawIndex==18 || drawIndex==0 )
{
  translate([0,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*95+Bearing608Height()+20]) 
  {
		difference()
		{
			hull()
			{
				color("green") rotate([90,0,0]) translate([-29,12.1,3]) cylinder(d=7,h=10,$fn=12);
				color("green") rotate([90,0,0]) translate([-29,5,3]) cylinder(d=9,h=10,$fn=12);
			}
			color("red") rotate([90,0,0]) translate([-29,12.1,0]) cylinder(d=3.1,h=20,$fn=12);
		}

		difference()
		{
			hull()
			{
				color("green") rotate([90,0,0]) translate([19.5,12.1,3]) cylinder(d=7,h=10,$fn=12);
				color("green") rotate([90,0,0]) translate([19.5,5,3]) cylinder(d=9,h=10,$fn=12);
			}
			color("red") rotate([90,0,0]) translate([19.5,11,0]) cylinder(d=3.1,h=20,$fn=12);
		}
    height = 2+3;
    difference()
    {
      color("blue") 
      union()
      {
        cylinder(d=8+3,h=height);
        difference()
        {
          hull()
          {
            translate([0,-16,0]) color("blue") cylinder(d=30,h=height);

            translate([40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            translate([40,-5,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

            translate([-40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            translate([-40,-5,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
          }
          translate([-25,-35,-0.5]) cube([50,20,height+1]);
        }
      }
			// bearing hole
      //color( "red") translate([0,0,-Bearing608Height()+2]) cylinder(d=Bearing608Diameter()+b608Clearance,h=Bearing608Height()+0.2);
      color( "red") translate([0,0,-1]) cylinder(d=9,h=Bearing608Height()+15);
			// mount holes
      translate([-40,0,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,0,-50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
			// end stopper fit
			translate([-10,15.5,-0.1]) cube([20,10,40]);
			translate([-13.7,12.5,-0.1]) cube([5,5,40]);
			// ramps fit
			translate([-50,-23,-0.1]) cube([100,10,40]);
			//
			//extra holes
      translate([-40,-8,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,-8,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
    }
  }
}

// ramps middle spacer
if( drawIndex==19 || drawIndex==0 )
{
	hs = 70;
	offset = drawIndex==19 ? 7 : 40;
	offset2 = drawIndex==19 ? hs/2 : 0;
	offsetY = drawIndex==19 ? 12 : 0;
	zoffset = Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()+18;
	difference()
	{
		union()
		{
					translate([-offset,0,zoffset]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=hs/2,$fn=16);
					translate([offset,0,zoffset]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=hs/2,$fn=16);
					translate([-offset,offsetY,zoffset+hs/2-offset2]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=4,r2=4,h=hs/2,$fn=16);
					translate([offset,offsetY,zoffset+hs/2-offset2]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=4,r2=4,h=hs/2,$fn=16);
		}
		// mount holes
		translate([-offset,0,50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
		translate([offset,0,50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
		// mount holes
		translate([-offset,offsetY,50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
		translate([offset,offsetY,50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
		// m5 nuts
		translate([-offset,0,zoffset-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
		translate([offset,0,zoffset-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
	}
}


// ramps top mount
if( drawIndex==20 || drawIndex==0 )
{
  translate([0,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*95+Bearing608Height()+95]) 
  {
		difference()
		{
			hull()
			{
				color("green") rotate([90,0,0]) translate([-29,12.1,3]) cylinder(d=7,h=10,$fn=12);
				color("green") rotate([90,0,0]) translate([-29,5,3]) cylinder(d=9,h=10,$fn=12);
			}
			color("red") rotate([90,0,0]) translate([-29,12.1,0]) cylinder(d=3.1,h=20,$fn=12);
		}

		difference()
		{
			hull()
			{
				color("green") rotate([90,0,0]) translate([19.5,18.5,3]) cylinder(d=7,h=10,$fn=12);
				color("green") rotate([90,0,0]) translate([19.5,5,3]) cylinder(d=9,h=10,$fn=12);
			}
			color("red") rotate([90,0,0]) translate([19.5,18.5,0]) cylinder(d=3.1,h=20,$fn=12);
		}
    height = 2+3;
    difference()
    {
      color("blue") 
      union()
      {
        cylinder(d=8+3,h=height);
        difference()
        {
          hull()
          {
            translate([0,-16,0]) color("blue") cylinder(d=30,h=height);

            translate([40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            translate([40,-5,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

            translate([-40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            translate([-40,-5,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
          }
          translate([-25,-35,-0.5]) cube([50,20,height+1]);
        }
      }
			// bearing hole
      //color( "red") translate([0,0,-Bearing608Height()+2]) cylinder(d=Bearing608Diameter()+b608Clearance,h=Bearing608Height()+0.2);
      color( "red") translate([0,0,-1]) cylinder(d=9,h=Bearing608Height()+15);
			// mount holes
      translate([-40,0,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,0,-50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
			// end stopper fit
			translate([-10,15.5,-0.1]) cube([20,10,40]);
			translate([-13.7,12.5,-0.1]) cube([5,5,40]);
			// ramps fit
			translate([-40,-23,-0.1]) cube([80,10,40]);
			//extra holes
      translate([-40,-8,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,-8,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
    }
  }
}

// ramps 1.4 bottom mount
if( drawIndex==0 )//|| drawIndex==18 || drawIndex==19 )
{
	//http://www.thingiverse.com/thing:34621
	translate ([0,-25,135]) rotate([0,-90,180]) import("STL/NonPrintedParts/RAMPS1_4.STL", convexity=3);
}


// extruder bottom spacer
if( drawIndex==28 || drawIndex==0 )
{
	hs = 28;
	offset = drawIndex==28 ? 7 : 40;
	offsetY = drawIndex==28 ? 12 : 0;
	zoffset = Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()+18+75;
	difference()
	{
		union()
		{
					translate([-offset,0,zoffset]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=hs,$fn=16);
					translate([offset,0,zoffset]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=hs,$fn=16);
		}
		// mount holes
		translate([-offset,0,zoffset-1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=hs+2,$fn=16);
		translate([offset,0,zoffset-1])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=hs+2,$fn=16);
		// m5 nuts
		translate([-offset,0,zoffset-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
		translate([offset,0,zoffset-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
	}
}

// extruder supprt
if( drawIndex==29 || drawIndex==0 )
{
  translate([0,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*95+Bearing608Height()+95+33+armsExtruderExtra]) 
  {
    height = 2+2;
    difference()
    {
      color("green") 
      union()
      {
        cylinder(d=8+3,h=height);
        difference()
        {
          hull()
          {
            //translate([10,-10,0]) color("blue") cylinder(d=30,h=height);
            //translate([16,-16,0]) color("blue") cylinder(d=30,h=height);

            translate([40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            translate([40,-5,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

            translate([-40,0,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
            translate([-40,-5,0]) 
            color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
          }
          //translate([-25,-35,-0.5]) cube([50,20,height+1]);
        }
          hull()
          {
            translate([13,-8,0]) color("blue") cylinder(d=30,h=height);
            translate([13,-28,0]) color("blue") cylinder(d=30,h=height);
            translate([32.5,-28,0]) color("blue") cylinder(d=30,h=height);
            translate([32.5,-8,0]) color("blue") cylinder(d=30,h=height);
					}
          hull()
          {
            translate([7,-41,4]) color("blue") cylinder(d=2,h=height);
            translate([35,-41,4]) color("blue") cylinder(d=2,h=height);
            translate([7,-33,0]) color("blue") cylinder(d=2,h=height);
            translate([35,-33,0]) color("blue") cylinder(d=2,h=height);
					}
      }
			// bearing hole
      //color( "red") translate([0,0,-Bearing608Height()+2]) cylinder(d=Bearing608Diameter()+b608Clearance,h=Bearing608Height()+0.2);
      color( "red") translate([0,0,-1]) cylinder(d=9,h=Bearing608Height()+15);
			// mount holes
      translate([-40,0,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,0,-50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
			//extra holes
      translate([-40,-8,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,-8,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
    }
  }
}

// top bearing spacer
//
//WIP
if( drawIndex==30 || drawIndex==0 )
{
	hs = 28;
	offset = drawIndex==30 ? 7 : 40;
	offsetY = drawIndex==30 ? 12 : 0;
	zoffset = Bearing625Height()+pulley1H+pulley2H+32+isExpolode*85+Bearing608Height()+Bearing608Height()+18+75;
	difference()
	{
		union()
		{
					translate([-offset,0,zoffset]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=hs,$fn=16);
					translate([offset,0,zoffset]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r1=5,r2=4,h=hs,$fn=16);
		}
		// mount holes
		translate([-offset,0,zoffset-1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=hs+2,$fn=16);
		translate([offset,0,zoffset-1])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=hs+2,$fn=16);
		// m5 nuts
		translate([-offset,0,zoffset-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
		translate([offset,0,zoffset-0.1]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
	}
}


centerTubeFixerRTop = 8;
centerTubeFixerR = 10;

// upper bearing fixer
if( drawIndex==21 || drawIndex==0 )
{
  translate([0,0,armsZ-Bearing608Height()-UpperBearingMountH-3-UpperBearingMountOffset+armsExtruderExtra]) 
  {
		difference()
		{
			union()
			{
				cylinder(r=centerTubeFixerR,h=9);
				translate([0,0,9]) cylinder(r=centerTubeFixerRTop,h=13-9);
			}
			translate([0,0,-1]) cylinder(r=4,h=15+2);
			translate([-20,6,5]) rotate([0,90,0]) cylinder(d=3.1,h=45,$fn=16);
			translate([6.5,6,5]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+0.7,h=45,$fn=6);
			translate([-10,6,5]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+0.7,h=3,$fn=6);
			translate([0,0,-1]) cube([1,10,12]);
		}
	}
}

UpperBearingMountH = 2+3+5;
UpperBearingMountOffset = 2;
//echo (Bearing608Height());

// upper bearing mount
if( drawIndex==22 || drawIndex==0 )
{
	height = UpperBearingMountH;
  translate([0,0,armsZ-UpperBearingMountH-UpperBearingMountOffset+armsExtruderExtra]) 
  {
    difference()
    {
      //
      union()
      {
        difference()
        {
					color("blue") union()
					{
						cylinder(d=Bearing608Diameter()+12,h=height);
						hull()
						{
							translate([0,-8,0]) color("blue") cylinder(d=30,h=height);

							translate([40,0,0]) 
								rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);

							translate([-40,0,0]) 
								rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
						}
						hull()
						{
							translate([40,15,0]) 
								rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
							translate([40,0,0]) 
								rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
						}
						hull()
						{
							translate([-40,15,0]) 
								rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
							translate([-40,0,0]) 
								rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
						}
						translate([40,15,-3]) 
							rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height+3,$fn=16);
						translate([-40,15,-3]) 
							rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height+3,$fn=16);
					}
          translate([-25,-35,-0.5]) cube([50,20,height+1]);
					// rods holes
					color("red") translate([rodOffsetX,rodOffsetY,-3-0.1]) 
						rotate([0,0,0]) scale([1,1,1]) cylinder(d=6,h=height,$fn=16);
					color("red") translate([-rodOffsetX,rodOffsetY,-3-0.1]) 
						rotate([0,0,0]) scale([1,1,1]) cylinder(d=6,h=height,$fn=16);
					// cut 
					translate([-50,-23,-1]) cube([100,10,40]);
				}
				//
				/*
				hull()
				{
					translate([-3-2,-13,UpperBearingMountH-4/2]) color("blue") rotate([0,90,0]) cylinder(d=4,h=6);
					translate([-3-2,-13,UpperBearingMountH-4/2-20]) color("blue") rotate([0,90,0]) cylinder(d=4,h=6);
					translate([-3,-46,UpperBearingMountH-4/2]) color("blue") rotate([0,90,0]) cylinder(d=4,h=4);
					translate([-3,-49,UpperBearingMountH-4/2-3]) color("blue") rotate([0,90,0]) cylinder(d=4,h=4);
				}
				*/
				hull()
				{
					clampSize = 6;
					translate([1,-10,height/2]) color("blue") rotate([0,90,0]) cylinder(d=height,h=clampSize);
					#translate([1,-25,height/2+3.8]) color("blue") rotate([0,90,0]) cylinder(d=3,h=clampSize);
					translate([1,-15,height/2-6]) color("blue") rotate([0,90,0]) cylinder(d=3,h=clampSize);
					translate([1,-27,height/2-1]) color("blue") rotate([0,90,0]) cylinder(d=3,h=clampSize);
				}
				hull()
				{
					clampSize = 6;
					translate([-9,-10,height/2]) color("blue") rotate([0,90,0]) cylinder(d=height,h=clampSize);
					translate([-9,-25,height/2+3.8]) color("blue") rotate([0,90,0]) cylinder(d=3,h=clampSize);
					translate([-9,-15,height/2-6]) color("blue") rotate([0,90,0]) cylinder(d=3,h=clampSize);
					translate([-9,-27,height/2-1]) color("blue") rotate([0,90,0]) cylinder(d=3,h=clampSize);
				}
				translate([12.5,7.5,-8]) cube([20,5,18]);
      }
			// bearing hole
      color( "red") translate([0,0,height-Bearing608Height()]) cylinder(d=Bearing608Diameter()+b608Clearance,h=Bearing608Height()+5);
      color( "red") translate([0,0,-1]) cylinder(r=centerTubeFixerRTop+0.5,h=Bearing608Height()+15);
			// mount holes
      translate([-40,0,-50]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
      translate([40,0,-50])  color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=100,$fn=16);
			// end stopper fit
			translate([-10,15.5,-0.1]) cube([20,10,40]);
			//translate([-13.7,12.5,-0.1]) cube([5,5,40]);
			//extruder mount
      translate([-20,-23,5.5]) color("red") rotate([0,90,0]) cylinder(d=3.1,h=50,$fn=16);
      translate([-20,-16,4]) color("red") rotate([0,90,0]) cylinder(d=3.1,h=50,$fn=16);
			// min switch
			translate([12,17.5,-8]) rotate([-90,180,180]) EndSwitchBody20x11(1);
			// belt rope axis
      color( "red") translate([0,5,2+height-Bearing608Height()]) rotate([-90,0,0]) cylinder(d=3.05,h=50,$fn=12);
      color( "red") translate([0,8,2+height-Bearing608Height()]) rotate([-90,0,0]) cylinder(r=3,h=3,$fn=12);
      color( "red") translate([0,10.8,2+height-Bearing608Height()]) rotate([-90,0,0]) cylinder(r1=2.5,r2=1.5,h=2,$fn=12);
			//
      color( "red") translate([17,3.5,-1]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.1,h=4,$fn=6);
      color( "red") translate([26,3.5,-1]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.1,h=4,$fn=6);
    }
  }
}

if( drawIndex==0 || drawSwitchesAll==1)
{
	translate([12,17.5,230]) rotate([-90,180,180]) EndSwitchBody20x11();
}

if( drawIndex==0 )
	translate ([0,0,armsZ-Bearing608Height()-UpperBearingMountOffset+armsExtruderExtra]) Bearing608(); 

if( drawIndex==0 )
{
		translate ([0,20,1+armsZ-Bearing608Height()-UpperBearingMountOffset+1]) rotate([90,0,0])
		{		
				Bearing623(); 
				translate ([0,0,-4])Bearing623(); 
			}
}

// m3 threaded rods
if( drawIndex==0 ) translate([-40,0,0]) color("silver") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=300,$fn=16);
if( drawIndex==0 ) translate([40,0,0])  color("silver") rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=300,$fn=16);

// x stepper plaform
if( drawIndex==7 || drawIndex==0 )
{
	translate([xStepperX,xStepperY,xStepperZ])
	{
		difference()
		{
			union()
			{
				translate([0,0,-1]) cube([42,42,4],center=true);
				holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
				translate([-holeDist,holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				translate([holeDist,-holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				translate([holeDist,holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				//translate([-holeDist,-holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				translate([-xStepperX+3,0,-xStepperZ+5+(xStepperZ-4)/2]) cube([6,42,xStepperZ-4],center=true);
			}
			rotate([0,0,-90]) Nema17_shaft24_Stepper(bSrewsOnly=1);
			extr = lookup(NemaRoundExtrusionDiameter, Nema17);
			color ("silver") translate([0,0,-3.01]) cylinder(d=extr,h=6,$fn=32);
			color ("silver") translate([-xStepperX+10,7,-xStepperZ/2+3])rotate([0,-90,0]) cylinder(d=3.1,h=20,$fn=32);
			color ("silver") translate([-xStepperX+10,-8,-xStepperZ/2+3])rotate([0,-90,0]) cylinder(d=3.1,h=20,$fn=32);
		}
	}
}
// y stepper plaform
if( drawIndex==8 || drawIndex==0 )
{
	translate([yStepperX,yStepperY,yStepperZ])
	{
		difference()
		{
			union()
			{
				translate([0,0,-1]) cube([42,42,4],center=true);
				holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
				translate([-holeDist,holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				//translate([holeDist,-holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				translate([holeDist,holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				translate([-holeDist,-holeDist,-xStepperZ+5]) cylinder(r=1.51+3,h=xStepperZ-5);
				translate([-(-xStepperX+3),0,-xStepperZ+5+(xStepperZ-4)/2]) cube([6,42,xStepperZ-4],center=true);
				}
				rotate([0,0,-90]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				extr = lookup(NemaRoundExtrusionDiameter, Nema17);
				color ("silver") translate([0,0,-3.01]) cylinder(d=extr,h=6,$fn=32);
				color ("silver") translate([-(-xStepperX-10),7,-xStepperZ/2+3])rotate([0,-90,0]) cylinder(d=3.1,h=20,$fn=32);
				color ("silver") translate([-(-xStepperX-10),-8,-xStepperZ/2+3])rotate([0,-90,0]) cylinder(d=3.1,h=20,$fn=32);
			}
	}
}

// base for xy steppers
if( drawIndex==9 || drawIndex==0 )
{
	difference()
	{
		color ("orange") 
		{
			//translate([-35,0,0]) cube([70,47,5]);
			hull()
			{
				translate([-47.5,85+3,0]) cube([95,3,5]);
				translate([-47.5,123,0]) cube([95,8,5]);
			}
		}
		translate([xStepperX,xStepperY,xStepperZ])
		{
				rotate([0,0,-90]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				translate([xStepperX-10,0,-xStepperZ-0.1]) cylinder(r=1.51,h=10,$fn=12);
				translate([0,15,-xStepperZ-0.1]) cylinder(r=1.51,h=10,$fn=12);
				translate([0,-15,-xStepperZ-0.1]) cylinder(r=1.51,h=10,$fn=12);
				translate([0,0,-xStepperZ+0.5]) cylinder(d=Bearing625Diameter()+b625RClearance,h=10,$fn=12);
				translate([0,0,-xStepperZ-0.1]) cylinder(d=5.2,h=10,$fn=12);
		}
		translate([yStepperX,yStepperY,yStepperZ])
		{
				rotate([0,0,-90]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				translate([-(xStepperX-10),0,-xStepperZ]) cylinder(r=1.51,h=10,$fn=12);
				translate([0,15,-xStepperZ]) cylinder(r=1.51,h=10,$fn=12);
				translate([0,-15,-xStepperZ]) cylinder(r=1.51,h=10,$fn=12);
				translate([0,0,-xStepperZ+0.5]) cylinder(d=Bearing625Diameter()+b625RClearance,h=10,$fn=12);
				translate([0,0,-xStepperZ-0.1]) cylinder(d=5.1,h=10,$fn=12);
		}
	}
	translate([22.5,82,0]) cube([6,6,6]);
	translate([-22.5-6,82,0]) cube([6,6,6]);
}


if( drawIndex==0 ) 
	translate([xStepperX,xStepperY,0.5]) Bearing625();
if( drawIndex==0 ) 
	translate([yStepperX,yStepperY,0.5]) Bearing625();



// base for z stepper
if( drawIndex==10 || drawIndex==0 )
{
	//color ("blue") 
	{
		//translate([-35,0,0]) cube([70,47,5]);
		difference()
		{
			color ("blue") union()
			{
				hull() 
				{
					translate([-47.5,85,0]) cube([95,3,5]);
					translate([-47.5,34,0]) cube([95,8,5]);
				}
				color ("blue") difference()
				{
					color ("green") translate([-24,34,0]) cube([48,5,70]);
					color ("red") translate([-20,33,5]) cube([40,10,20]);
				}
				hull()
				{
					color ("red") translate([-7.5,34,5]) cube([15,1,20]);
					color ("red") translate([-2.5,40,5]) cube([5,1,20]);
				}
				color ("green") translate([11.3,45,0]) cube([13,25,28]);
				color ("green") translate([-24.2,45,0]) cube([13,25,28]);

				color ("green") translate([-24.3,39,0]) cube([3,10,70]);
				color ("green") translate([24.3-3,39,0]) cube([3,10,70]);

				color ("green") translate([-24.3,65,24]) rotate([30,0,0]) cube([3,5,45]);
				color ("green") mirror() translate([-24.3,65,24]) rotate([30,0,0]) cube([3,5,45]);

			}
			translate([40,40,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			translate([-40,40,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			//
			translate([40,80,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			translate([-40,80,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			//
			translate([40,60,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			translate([-40,60,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			//
			translate([0,80,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			translate([0,45,-0.2]) color("red") cylinder(r=1.51,h=10,$fn=16);
			translate([0,63,-0.2]) color("red") cylinder(r=5,h=10,$fn=12);
			//
			translate([22.5,82,-0.2]) cube([6,6,10]);
			translate([-22.5-6,82,-0.2]) cube([6,6,10]);
			//
			color("red") translate([0,48,8.5]) rotate([90,0,0]) scale([1,1,1]) cylinder(r=1.51,h=38,$fn=16);
			translate([0,83,49]) rotate([90,0,0])
			{
				translate( [0,0,45]) rotate([180,0,0]) Nema17_shaft24_Stepper(bSrewsOnly=1);
				color ("silver") translate([0,0,43]) cylinder(d=23,h=12,$fn=32);
			}
			color ("silver") translate([0,0,13]) cylinder(r=outerRad+9.3,h=17,$fn=32);

		}
	}
}

/*
difference()
{
	color("green") translate([-48,-64,0]) cube([96,40,5]);
	color("blue") cylinder(d=56,h=5);
}
*/

module XYto10Clip()
{
	union()
	{
		difference()
		{
			union()
			{
				translate([xStepperX,xStepperY,0])
				{
					holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
					translate([holeDist,-holeDist,5]) hull()
					{
						translate([0,16,0]) cylinder(r=1.51+3,h=5);
						translate([2.5,16,0]) cylinder(r=1.51+3,h=5);
						translate([0,-15,0]) cylinder(r=1.51+3,h=5);
						translate([2.5,-15,0]) cylinder(r=1.51+3,h=5);
						//translate([40,94.5,5]) scale([0.6,1,1]) cylinder(r=8,h=5);
					}
				}
				translate([42.5,82.5,5]) cube([5,25,10]);
			}
			translate([xStepperX,xStepperY,0])
			{
						holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
						translate([holeDist,-holeDist,-1]) cylinder(r=1.51+3,h=35);
			}
			translate([40,80,0]) cylinder(r=1.51,h=18,$fn=16);
			translate([40,110,0]) cylinder(r=1.51,h=18,$fn=16);
		}
	}
}

if( drawIndex==11 || drawIndex==0 )
{
	XYto10Clip();
}
if( drawIndex==12 || drawIndex==0 )
{
	mirror() XYto10Clip();
}


module PulleysToZClip()
{
	union()
	{
		difference()
		{
			color( "red") union()
			{
				translate([xStepperX,50,0])
				{
					holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
					translate([holeDist,-holeDist,5]) hull()
					{
						translate([-1,13,0]) cylinder(r=1.51+3,h=5);
						translate([2.5,13,0]) cylinder(r=1.51+3,h=5);
						//translate([-2.5,-13,0]) cylinder(r=1.51+3,h=5);
						//translate([2.5,-13,0]) cylinder(r=1.51+3,h=5);
						translate([-5,-22.7,0]) cube([12,10,15]);
					}
				}
			}
			translate([40,40,0]) cylinder(r=1.51,h=18,$fn=16);
			translate([40,28,0]) cylinder(r=1.51,h=18,$fn=16);
			translate([40,15,0]) cylinder(r=1.51,h=38,$fn=16);
			// nut place
			color("green") translate([40,40,12]) cylinder(d=rolson_hex_nut_dia(5)+3,h=18,$fn=16);
			color("green") translate([40,28,16]) cylinder(d=rolson_hex_nut_dia(5)+3,h=18,$fn=16);
		}
	}
}

if( drawIndex==15 || drawIndex==0 )
{
	PulleysToZClip();
}
if( drawIndex==16 || drawIndex==0 )
{
	mirror() PulleysToZClip();
}

//#translate ([-50,-60,0]) cube([100,200,300]);


module ArmPulley(numBigHoles=0,numSmallHoles=0,smallHolesDist=10,smallHolesDia=1.5,bigHolesRadScale=1,bigHolesOffset=0,idlerH=1,retainerH=1)
{
	difference()
	{
		Pulley(
			teeth = 80,			// Number of teeth, standard Mendel T5 belt = 8, gives Outside Diameter of 11.88mm
			profile = 12,		// 1=MXL 2=40DP 3=XL 4=H 5=T2.5 6=T5 7=T10 8=AT5 9=HTD_3mm 10=HTD_5mm 11=HTD_8mm 12=GT2_2mm 13=GT2_3mm 14=GT2_5mm

			motor_shaft = 5.2,	// NEMA17 motor shaft exact diameter = 5
			m3_dia = 3.2,		// 3mm hole diameter
			m3_nut_hex = 1,		// 1 for hex, 0 for square nut
			m3_nut_flats = 5.7,	// normal M3 hex nut exact width = 5.5
			m3_nut_depth = 2.7,	// normal M3 hex nut exact depth = 2.4, nyloc = 4

			retainer = 1,		// Belt retainer above teeth, 0 = No, 1 = Yes
			retainer_ht = retainerH,	// height of retainer flange over pulley, standard = 1.5
			idler = 1,			// Belt retainer below teeth, 0 = No, 1 = Yes
			idler_ht = idlerH,		// height of idler flange over pulley, standard = 1.5

			pulley_t_ht = 7,	// length of toothed part of pulley, standard = 12
			pulley_b_ht = 0,		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.
			pulley_b_dia = 20,	// pulley base diameter, standard = 20
			no_of_nuts = 1,		// number of captive nuts required, standard = 1
			nut_angle = 90,		// angle between nuts, standard = 90
			nut_shaft_distance = 1.2,	// distance between inner face of nut and shaft, can be negative.


			//	********************************
			//	** Scaling tooth for good fit **
			//	********************************
			//	To improve fit of belt to pulley, set the following constant. Decrease or increase by 0.1mm at a time. We are modelling the *BELT* tooth here, not the tooth on the pulley. Increasing the number will *decrease* the pulley tooth size. Increasing the tooth width will also scale proportionately the tooth depth, to maintain the shape of the tooth, and increase how far into the pulley the tooth is indented. Can be negative


			additional_tooth_width = 0.2, //mm

			//	If you need more tooth depth than this provides, adjust the following constant. However, this will cause the shape of the tooth to change.
			additional_tooth_depth = 0 //mm
		);
		cylinder(r = rolson_hex_nut_dia(5)/2+m5Rclearance,h = rolson_hex_nut_hi(5)+m5Hclearance, $fn=6);

		//echo(bigHoleRad);
		if( numBigHoles )
		{
			//echo(outerRad);
			bigHoleRad = (outerRad-5)*0.32;
			for (i = [0:numBigHoles-1]) 
			{
				rotate([0, 0, (360/numBigHoles)*i])
				translate([bigHoleRad/2+5+6+bigHolesOffset, 0, 0])
				cylinder(r=bigHoleRad*bigHolesRadScale,h=10+retainerH,$fn=16);
			}
		}

		//numSmallHoles = 3;
		if( numSmallHoles )
		{
			for (i = [0:numSmallHoles-1]) 
			{
				rotate([0, 0, (360/numSmallHoles)*i+60])
				translate([smallHolesDist, 0, 0])
				cylinder(r=smallHolesDia,h=10+retainerH,$fn=16);
			}
		}
	}
}


module Pulley16Teeth()
{
	Pulley(
		teeth = 16,			// Number of teeth, standard Mendel T5 belt = 8, gives Outside Diameter of 11.88mm
		profile = 12,		// 1=MXL 2=40DP 3=XL 4=H 5=T2.5 6=T5 7=T10 8=AT5 9=HTD_3mm 10=HTD_5mm 11=HTD_8mm 12=GT2_2mm 13=GT2_3mm 14=GT2_5mm

		motor_shaft = 5.2,	// NEMA17 motor shaft exact diameter = 5
		m3_dia = 3.2,		// 3mm hole diameter
		m3_nut_hex = 1,		// 1 for hex, 0 for square nut
		m3_nut_flats = 5.7,	// normal M3 hex nut exact width = 5.5
		m3_nut_depth = 2.7,	// normal M3 hex nut exact depth = 2.4, nyloc = 4

		retainer = 1,		// Belt retainer above teeth, 0 = No, 1 = Yes
		retainer_ht = 1,	// height of retainer flange over pulley, standard = 1.5
		idler = 1,			// Belt retainer below teeth, 0 = No, 1 = Yes
		idler_ht = 0,		// height of idler flange over pulley, standard = 1.5

		pulley_t_ht = 7,	// length of toothed part of pulley, standard = 12
		pulley_b_ht = 8,		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.
		pulley_b_dia = 18,	// pulley base diameter, standard = 20
		no_of_nuts = 1,		// number of captive nuts required, standard = 1
		nut_angle = 90,		// angle between nuts, standard = 90
		nut_shaft_distance = 1.2,	// distance between inner face of nut and shaft, can be negative.


		//	********************************
		//	** Scaling tooth for good fit **
		//	********************************
		//	To improve fit of belt to pulley, set the following constant. Decrease or increase by 0.1mm at a time. We are modelling the *BELT* tooth here, not the tooth on the pulley. Increasing the number will *decrease* the pulley tooth size. Increasing the tooth width will also scale proportionately the tooth depth, to maintain the shape of the tooth, and increase how far into the pulley the tooth is indented. Can be negative


		additional_tooth_width = 0.2, //mm

		//	If you need more tooth depth than this provides, adjust the following constant. However, this will cause the shape of the tooth to change.
		additional_tooth_depth = 0 //mm
		);
}

module BeltClip()
{
	difference()
	{
		translate ([-2.9,0,0]) cube([6.1,20,9]);
			rotate([0,0,90]) scale([1,1.3,1])belting("straight","GT2_2mm", belt_length = 60, belting_width = 7 );	// 13 seconds
		translate ([0,9.5,0]) cube([12,1,7]);
		//translate ([-11.3,-5,0]) rotate([0,0,10])  cube([10,10,10]);
		//translate ([-13,15,0]) rotate([0,0,-10])  cube([10,10,10]);
	}
	//translate ([-11,-5,0]) rotate([0,0,10])  cube([10,10,10]);
	//translate ([-13,15,0]) rotate([0,0,-10])  cube([10,10,10]);
}

// MY NEMA with 24mm length shafts
module Nema17_shaft24_Stepper(bSrewsOnly=0)
{
	if( !bSrewsOnly )
	{
		color ("silver")
		{		
			motor(Nema17,NemaLengthLong);
			translate([0,0,-40+16]) cylinder(r=2.5,h=8,$fn=32);
		}
		color ("gold") translate([21,-5,41.5]) cube ([5,10,5]);
	}
	else
	{
		holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
		color ("silver") translate([holeDist,holeDist,-30]) cylinder(r=1.51,h=35,$fn=32);
		color ("silver") translate([-holeDist,holeDist,-30]) cylinder(r=1.51,h=35,$fn=32);
		color ("silver") translate([holeDist,-holeDist,-30]) cylinder(r=1.51,h=35,$fn=32);
		color ("silver") translate([-holeDist,-holeDist,-30]) cylinder(r=1.51,h=35,$fn=32);
		color ("silver") translate([0,0,-20]) cylinder(r=2.6,h=25,$fn=32);
		extr = lookup(NemaRoundExtrusionDiameter, Nema17);
		color ("silver") translate([0,0,.01]) cylinder(d=extr,h=2,$fn=32);
	}
}
