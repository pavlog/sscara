// Author: Pavlo Gryb (psg416@gmail.com)

use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>
use <Modules/EndStoppers.scad>
use <Modules/Write.scad/Write.scad>
include <Modules/MCAD/stepper.scad>
use <Modules/HotEnds.scad>
use <Modules/Misc.scad>
use <Modules/Profiles.scad>
include <Modules/dimlines.scad>
include <Modules/TextGenerator.scad>
use <ExtruderGeared.scad>


//ex = 70;
//ey = 130;
// almost parralel
ex = -100;
ey = 100;
// small angle
//ex = 10;
//ey = 30;
// middle 
//ex = 0;
//ey = 130;
//
//ex = 0;
//ey = 160;
//
z = 0;//125;
//z = 140;


Linkage_1 = 100;
Linkage_2 = 100;
//
BedSizeX = 200;
BedSizeY = 200;
BedYOffset = 20;
BedXOffset = -150;
//
m5Rclearance = 0.1;
m5Hclearance = 0.2;
b625RClearance = 0.2;
b608Clearance = 0.3;
b6800Clearance = 0.3;
BearingRClearance = 0.3;
outerRad = (80*2/3.14*0.5);

//drawArray = [4,5,6,7,9,10,11,12,13];//[1,2,3,4,5];//[1,7,8];
//drawArray = [2,4,5];//[1,2,3,4,5];//[1,7,8];
drawArray = [11,12];//[1,2,3,4,5];//[1,7,8];
//drawArray = [];//[1,2,3,4,5];//[1,7,8];
// 1 - bottom arm pulley (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells,no supports)
// 2 - bottom arm pulley (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells,no supports)

// 7 - zmin endstopper mount
// 8 - endstop mount top
// 9 - endstop mount bottom
// 10 - nut holder
// 11 - top cap
// 12 - extruder rotation mount



// more printer friedly layout (note: implemented not for all parts)
printLayout = 0;


drawSteppers = 1;//1;
drawZStepper = 1;
drawBelts = 1;
drawZBelts = 1;
drawSwitchesAll = 1;
drawMetall = 1;
drawZAxis = 1;
drawRods = 1;
drawBed = 1;//1;
drawHotEnd = 1;
drawSpool = 1;
drawExtruder = 1;



isExpolode = 0;
// arms pulleys
pulleysH = 10;
ArmNumTeethRatio = 4;
ArmNumTeeth = 16*ArmNumTeethRatio;
ArmPulleyDia = (ArmNumTeeth*2)/3.1415;
//cylinder(r=4,h=30);
smallHolesDia = 1.55;

shaftRadius = 5.1/2;
shaftsSegments = 32;
pulleysSpace = 1;
smallHolesDist = 11;

bottomArmH = 7;
topArmH = 10;

NemaSize = NemaLengthMedium;//NemaLengthLong;//NemaLengthMedium;
Nema17Len = lookup(NemaSize, Nema17);
//echo(Nema17Len);
//if( NemaSize ==NemaLengthMedium )
//{
//}

xStepperX = -33;
xStepperY = 0;
xStepperRZ = 0;
xStepperZ = 78+5+15+3;


yStepperX = -33;
yStepperY = 0;
yStepperRZ = 0;
yStepperZ = 41;
yStepperZPlane = 44;

part1ZBase = yStepperZPlane+3;
part2ZBase = part1ZBase+21+5;



alumXOffset = 60;

gearRadToTeethEnd = 10.0/2;//7.3/2;// seems like mk8
gearRad = 11.5/2;// semms like mk8
fillamentD = 1.75;
fillamentPenetration = 0.5;//mm
extruderBearingDia = Bearing623Diameter();
extruderBearingH = Bearing623Height();
extruderClearanceH = 0.2;

armsZ = 270;
armsZExtra = 15;//15;
armsExtruderExtra = 15;
extrudeMountZOffset = 0;

ArmNearestD = 8+9;
ArmNearestW = 14;

zminZCoord = 230;

BedZOffset = BearingLM6UUHeight()+15;

LCDX = -68;
LCDY = -55;
LCDZ = 15;

RampsX = -10+26+4;

rodOffsetX = 30;
rodOffsetY = 0;

centerTubeFixerRTop = 8;
centerTubeFixerR = 10;

UpperBearingMountH = 2+3+5;
UpperBearingMountOffset = 2;

DIM_LINE_WIDTH = 1;
DIM_HEIGHT = 0.1;
DIM_TEXT_RENDER = 1;


module LProfileWithDimensions(x=10,y=10,w=1.5,len=200)
{
LProfile(x,y,4,len);
color("black") translate([0,-10,0]) 
{
	rotate([0,0,90]) line(length=15, width=DIM_LINE_WIDTH/2, height=DIM_HEIGHT,
		left_arrow=false, right_arrow=false);
	rotate([0,0,90]) translate([0,-y,0]) line(length=15, width=DIM_LINE_WIDTH/2, height=DIM_HEIGHT,
		left_arrow=false, right_arrow=false);	
	dimensions(y, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
	rotate([0,-90,180]) dimensions(x, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
}
	color("black") translate([-10,0,5]) rotate([0,0,90]) dimensions(len, DIM_LINE_WIDTH/2, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
}


module CProfileWithDimensions(x=10,y=10,w=1.5,len=200)
{
CProfile(x,y,4,len);
color("black") translate([0,-10,0]) 
{
	rotate([0,0,90]) line(length=15, width=DIM_LINE_WIDTH/2, height=DIM_HEIGHT,
		left_arrow=false, right_arrow=false);
	rotate([0,0,90]) translate([0,-y,0]) line(length=15, width=DIM_LINE_WIDTH/2, height=DIM_HEIGHT,
		left_arrow=false, right_arrow=false);	
	dimensions(y, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
	rotate([0,-90,180]) dimensions(x, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
}
	color("black") translate([-10,0,5]) rotate([0,0,90]) dimensions(len, DIM_LINE_WIDTH/2, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
}


l2 = Linkage_1 * Linkage_1;
L2 = Linkage_2 * Linkage_2;
//echo(EX);
//echo(EY);
//echo(LH3);


l = Linkage_1;
L = Linkage_2;

x = ex;
y = ey;
//x = 0;
//y = 60;// offset from axis to printed area

//echo("xy");
//echo(x);
//echo(y);

//color("red") translate([x,y,200]) cylinder(r=5,h=100);



  SCARA_C2 =   ( (x*x) + (y*y) - l2 - L2 ) / (2*l*L);
  
  SCARA_S2 = sqrt( 1 - (SCARA_C2*SCARA_C2) );
  
  SCARA_K1 = l + L * SCARA_C2;
  SCARA_K2 = L * SCARA_S2;
  
  SCARA_theta = ( atan2(x,y)-atan2(SCARA_K1, SCARA_K2) ) * -1;
  SCARA_psi   =   atan2(SCARA_S2,SCARA_C2);
  
  q11 = SCARA_theta;
  q22a = (SCARA_theta + SCARA_psi);

  q22=q22a-180;


//echo("q22,q11");
//echo(q22Pos);
echo(q11);
echo(q22);

angle22 = (q22<=0 && q22>-180) ? q22 : (360+q22);//q22<=0 && q22>-180 ? q22 : (q22>=0 && q22<=180)  
echo(angle22);
//echo(q22 < 0 ? 2*3.145+q22 : q22);

//xd = l * cos(q22);
//yd = l * sin(q22);

//xb = l * cos(q11);
//yb = l * sin(q11);


// forward kinematic
xp = cos(q11)*Linkage_1+cos(q22+180)*Linkage_2;
yp = sin(q11)*Linkage_1+sin(q22+180)*Linkage_2;
//echo("xf,yf");
//echo(xf);
//echo(yf);
//translate([xf,yf,0]) cylinder(r=5,h=10);

WIP = 1;


module fillet(r, h)
{
    translate([r / 2, r / 2, 0])
       difference() 
			{
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}



module gt2_segment(ht=10)
{
	GT2_2mm(ht-2);
	translate([-1,-0.5,0]) cube([2,0.5,ht]);
}

beltMountW = 8;
module beltMount()
{
	wi = beltMountW;
	hei = 7;
	depth = 10;
	difference()
	{
		union()
		{
			translate([-wi/2,0,-hei/2]) cube([wi,depth,7]);
			translate([-wi/2-3.25,+10,-hei/2]) cube([wi+6.5,5,7]);
			translate([-wi/2-3.25,+10,-hei/2-1.5]) cube([wi+6.5,5,1.5]);
			translate([-wi/2-3.25,+10,hei/2]) cube([wi+6.5,5,1.5]);
		}
		translate([wi/2-0.5,0,-hei/2]) rotate([0,0,90]) scale([1,1.2,1]) gt2_segment(7);
		translate([wi/2-0.5,2,-hei/2]) rotate([0,0,90]) scale([1,1.2,1]) gt2_segment(7);
		translate([wi/2-0.5,4,-hei/2]) rotate([0,0,90]) scale([1,1.2,1]) gt2_segment(7);
		translate([wi/2-0.5,6,-hei/2]) rotate([0,0,90]) scale([1,1.2,1]) gt2_segment(7);
		translate([wi/2-0.5,8,-hei/2]) rotate([0,0,90]) scale([1,1.2,1]) gt2_segment(7);
		translate([wi/2-0.5,10,-hei/2]) rotate([0,0,90]) scale([1,1.2,1]) gt2_segment(7);
		translate([(wi/2-0.5),10.2,-hei/2]) rotate([0,0,45]) scale([1,1.2,1])  cylinder(d=2,h=hei,$fn=12);
		///#translate([wi/2,+10-0.5,-hei/2-0.1]) cube([wi/2,1,10]);
		//translate([(wi/2-0.5),10.5,-hei/2-0.1]) rotate([0,0,0]) scale([1,1.2,1]) gt2_segment(10);
		translate([(wi/2-0.5)+2,10.5,-hei/2]) rotate([0,0,0]) scale([1,1.2,1]) gt2_segment(7);
		translate([(wi/2-0.5)+4,10.5,-hei/2]) rotate([0,0,0]) scale([1,1.2,1]) gt2_segment(7);
		//
		translate([-(wi/2-0.5),0,-hei/2]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(7);
		translate([-(wi/2-0.5),2,-hei/2]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(7);
		translate([-(wi/2-0.5),4,-hei/2]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(7);
		translate([-(wi/2-0.5),6,-hei/2]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(7);
		translate([-(wi/2-0.5),8,-hei/2]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(7);
		translate([-(wi/2-0.5),10,-hei/2]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(7);
		// bolt
		translate([0,0,0]) rotate([-90,0,0])   cylinder(d=3,h=20,$fn=32);
		//translate([-wi/2-3.25,+10-0.5,-hei/2-0.1]) cube([wi/2,1,10]);
		//#translate([-(wi/2-0.5),10.5,-hei/2-0.1]) rotate([0,0,-90]) scale([1,1.2,1]) gt2_segment(10);
		translate([-(wi/2-0.5),10.2,-hei/2]) rotate([0,0,-45]) scale([1,1.2,1])  cylinder(d=2,h=hei,$fn=12);
		translate([-(wi/2-0.5)-2,10.5,-hei/2]) rotate([0,0,0]) scale([1,1.2,1]) gt2_segment(7);
		translate([-(wi/2-0.5)-4,10.5,-hei/2]) rotate([0,0,0]) scale([1,1.2,1]) gt2_segment(7);
	}
}

module gearPulleyBase()
{
	difference()
	{
		union()
		{
			cylinder(d=ArmPulleyDia,h=pulleysH,$fn=180);
			cylinder(r1=ArmPulleyDia/2+1.2,r2=ArmPulleyDia/2,h=1.5,$fn=180);
			translate([0,0,pulleysH-1.5]) cylinder(r1=ArmPulleyDia/2,r2=ArmPulleyDia/2+1.2,h=1.5,$fn=180);
		}
		color("red") 
		{
			// belt mount hole
			translate([0,0,0])
			{
				translate([-beltMountW/2-0.5,ArmPulleyDia/2-13,pulleysH/2-3.5]) cube([beltMountW+0.8,20,7]);
				hull()
				{
					translate([-2.5,ArmPulleyDia/2-13,pulleysH/2-3.5]) rotate([0,0,-180-50]) cube([2,14,7]);
					translate([-2.5,ArmPulleyDia/2-12,pulleysH/2-3.5]) rotate([0,0,-180-30]) cube([2,5,7]);
				}
				mirror()
				{
					hull()
					{
						translate([-2.5,ArmPulleyDia/2-13,pulleysH/2-3.5]) rotate([0,0,-180-50]) cube([2,14,7]);
						translate([-2.5,ArmPulleyDia/2-12,pulleysH/2-3.5]) rotate([0,0,-180-30]) cube([2,5,7]);
					}
				}
			}
			// m3 hole
			translate([0,ArmPulleyDia/2-27,pulleysH/2]) rotate([-90,0,0]) cylinder(d=3,h=50,$fn=12);
			// m5 center hole
			cylinder(d=5,h=50,$fn=32);
			// m3 nut place
			translate([0,ArmPulleyDia/2-20,0]) hull()
			{
				translate([0,0,(rolson_hex_nut_dia(3)+0.3)/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.3,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
				translate([0,0,pulleysH/2+20]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.3,h=rolson_hex_nut_hi(3)+0.7,$fn=6);
			}
			//
			bigHoleRad = ArmPulleyDia/7;
			numBigHoles = 3;
			bigHolesOffset = ArmPulleyDia/2/1.8;
			for (i = [0:numBigHoles-1]) 
			{
				rotate([0, 0, (360/numBigHoles)*i+180])
				translate([0, bigHolesOffset, -1])
				cylinder(r=bigHoleRad,h=pulleysH+2,$fn=32);
			}

		}
	}
}


firtstNumZ = -1;
firstBearingZ = firtstNumZ+rolson_hex_nut_hi(5)+1;
if( !printLayout && (drawArray==[] || drawMetall) )
{
	translate ([0,0,firtstNumZ-5]) color( "grey") cylinder(d=5,h=400);
	translate ([0,0,firtstNumZ]) color( "Silver") hex_nut(5);
	translate ([0,0,firstBearingZ]) Bearing625();
}


// pulley1
//intersection()
//{
pulley1Z = firstBearingZ+Bearing625Height();


	hole608Size = 22+0.5;

module idlerMountHoles()
{
		rotate([0,0,-35])   translate([15,0,-1]) cylinder(d=3,h=50,$fn=16);
		rotate([0,0,35])   translate([15,0,-1]) cylinder(d=3,h=50,$fn=16);
		rotate([0,0,-35+180])   translate([15,0,-1]) cylinder(d=3,h=50,$fn=16);
		rotate([0,0,35+180])   translate([15,0,-1]) cylinder(d=3,h=50,$fn=16);
}

part1idlerW = 38;
module part1Idler_full()
{
		difference()
		{
			union()
			{
				translate([0,0,0]) cylinder(d=42,h=7);
				rotate([0,0,-90]) translate([-38/2,0,0]) cube([part1idlerW,21,7]);
				rotate([0,0,-90]) translate([-38/2,-15,0]) cube([part1idlerW,20,7]);
			}
			translate([0,0,-1]) cylinder(d=hole608Size,h=9,$fn=64);
			translate([0,0,(7-4)/2+2]) rotate([0,0,90]) rotate([90,0,0]) translate([(22/2+3),0,-18]) cylinder(d=rolson_hex_nut_dia(4)+1,h=3,$fn=6);
			translate([0,0,(7-4)/2+2]) rotate([0,0,90]) rotate([90,0,0]) translate([-(22/2+3),0,-18]) cylinder(d=rolson_hex_nut_dia(4)+1,h=3,$fn=6);
			translate([0,0,(7-4)/2+2]) rotate([0,0,90]) rotate([90,0,0]) translate([-22/2-3,0,-19]) cylinder(d=4,h=200,$fn=16);
			translate([0,0,(7-4)/2+2]) rotate([0,0,90]) rotate([90,0,0]) translate([(22/2+3),0,-19]) cylinder(d=4,h=200,$fn=16);
			idlerMountHoles();
		}
}

module part1Idler(printLayout)
{
	if( printLayout==1 )
	{
		intersection()
		{
			part1Idler_full();
			translate([0,-50,0]) cube([100,100,100]);
		}
	}
	else if( printLayout==2 )
	{
		intersection()
		{
			part1Idler_full();
			translate([0,50,0]) rotate([0,0,180]) cube([100,100,100]);
		}
	}
	else
	{
		part1Idler_full();
	}
}

if( drawArray==[] || search(1,drawArray)!=[] )
{
	//printLayout = 1;
	rotAngle = printLayout ? 0 : q11;
	translate([0,0,part1ZBase]) rotate([0,0,rotAngle]) 
	{
		if( printLayout )
		{
			part1Idler(1);
			translate([-5,0,0]) part1Idler(2);
		}
		else
		{
			part1Idler();
		}
		pulleyOffsX = printLayout ? -5 : 0;
		pulleyOffsY = printLayout ? 45 : 0;
		pulleyOffsZ = printLayout ? 0 : 7;
		translate([pulleyOffsX,pulleyOffsY,pulleyOffsZ]) difference()
		{
			color("magenta")
			Pulley(
				teeth = 64,			// Number of teeth, standard Mendel T5 belt = 8, gives Outside Diameter of 11.88mm
				profile = 12,		// 1=MXL 2=40DP 3=XL 4=H 5=T2.5 6=T5 7=T10 8=AT5 9=HTD_3mm 10=HTD_5mm 11=HTD_8mm 12=GT2_2mm 13=GT2_3mm 14=GT2_5mm
			// use 608 bearing
				motor_shaft = 12,	// NEMA17 motor shaft exact diameter = 5
				m3_dia = 3.2,		// 3mm hole diameter
				m3_nut_hex = 1,		// 1 for hex, 0 for square nut
				m3_nut_flats = 5.7,	// normal M3 hex nut exact width = 5.5
				m3_nut_depth = 2.7,	// normal M3 hex nut exact depth = 2.4, nyloc = 4

				retainer = 1,		// Belt retainer above teeth, 0 = No, 1 = Yes
				retainer_ht = 0,	// height of retainer flange over pulley, standard = 1.5
				idler = 1,			// Belt retainer below teeth, 0 = No, 1 = Yes
				idler_ht = 0,		// height of idler flange over pulley, standard = 1.5

				pulley_t_ht = 7,	// length of toothed part of pulley, standard = 12
				pulley_b_ht = 0,		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.
				pulley_b_dia = 25,	// pulley base diameter, standard = 20
				no_of_nuts = 0,		// number of captive nuts required, standard = 1
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
			idlerMountHoles();
		}
		topIdlerOffsetZ = printLayout ? 0 : 14;
		translate([0,0,topIdlerOffsetZ])
		{
		if( printLayout )
		{
			translate([25,0,0]) part1Idler(1);
			translate([-25,0,0]) part1Idler(2);
		}
		else
		{
			part1Idler();
		}
		}
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([-22/2-3,0,-19]) cylinder(d=4,h=200,$fn=16);
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([(22/2+3),0,-19]) cylinder(d=4,h=200,$fn=16);
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([(22/2+3),0,-18]) hex_nut(4);
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([-(22/2+3),0,-18]) hex_nut(4);
	}
}

// part2
if( drawArray==[] || search(2,drawArray)!=[] )
{
	//printLayout = 1;
	//xd = l * cos(q11);
  //yd = l * sin(q11);
//	a = printLayout ? 0 : atan2((y-yd),(x-xd));
	a = printLayout ? 0 : q22;//atan((y-yd)/(x-xd));
	echo(a);

	rotAngle = printLayout ? 0 : a;
	translate([0,0,part2ZBase]) rotate([0,0,rotAngle]) 
	{
		if( printLayout )
		{
			part1Idler(1);
			translate([-5,0,0]) part1Idler(2);
		}
		else
		{
			part1Idler();
		}
		pulleyOffsX = printLayout ? -5 : 0;
		pulleyOffsY = printLayout ? 45 : 0;
		pulleyOffsZ = printLayout ? 0 : 7;
		translate([pulleyOffsX,pulleyOffsY,pulleyOffsZ]) difference()
		{
			color("magenta")
			Pulley(
				teeth = 64,			// Number of teeth, standard Mendel T5 belt = 8, gives Outside Diameter of 11.88mm
				profile = 12,		// 1=MXL 2=40DP 3=XL 4=H 5=T2.5 6=T5 7=T10 8=AT5 9=HTD_3mm 10=HTD_5mm 11=HTD_8mm 12=GT2_2mm 13=GT2_3mm 14=GT2_5mm
			// use 608 bearing
				motor_shaft = 12,	// NEMA17 motor shaft exact diameter = 5
				m3_dia = 3.2,		// 3mm hole diameter
				m3_nut_hex = 1,		// 1 for hex, 0 for square nut
				m3_nut_flats = 5.7,	// normal M3 hex nut exact width = 5.5
				m3_nut_depth = 2.7,	// normal M3 hex nut exact depth = 2.4, nyloc = 4

				retainer = 1,		// Belt retainer above teeth, 0 = No, 1 = Yes
				retainer_ht = 0,	// height of retainer flange over pulley, standard = 1.5
				idler = 1,			// Belt retainer below teeth, 0 = No, 1 = Yes
				idler_ht = 0,		// height of idler flange over pulley, standard = 1.5

				pulley_t_ht = 7,	// length of toothed part of pulley, standard = 12
				pulley_b_ht = 0,		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.
				pulley_b_dia = 25,	// pulley base diameter, standard = 20
				no_of_nuts = 0,		// number of captive nuts required, standard = 1
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
			idlerMountHoles();
		}
		topIdlerOffsetZ = printLayout ? 0 : 14;
		translate([0,0,topIdlerOffsetZ])
		{
		if( printLayout )
		{
			translate([25,0,0]) part1Idler(1);
			translate([-25,0,0]) part1Idler(2);
		}
		else
		{
			part1Idler();
		}
		}
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([-22/2-3,0,-19]) cylinder(d=4,h=200,$fn=16);
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([(22/2+3),0,-19]) cylinder(d=4,h=200,$fn=16);
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([(22/2+3),0,-18]) hex_nut(4);
		//translate([0,0,(7-4)/2+2]) rotate([0,0,q11+90]) rotate([90,0,0]) translate([-(22/2+3),0,-18]) hex_nut(4);

		// subpart 4
		translate([printLayout ? -30 : 21,printLayout ? 60 : 0,printLayout ? 24 : 0])
		rotate([0,printLayout ? 0 : 0,printLayout ? 0 : 0]) 
		color("magenta")
		{
			translate([printLayout ? 20 : 0,0,printLayout ? -20 : 0])  rotate([0,printLayout ? -90 : 0,printLayout ? 0 : 0]) intersection()
			{
				difference()
				{	
					armsEndEffector();
					translate([20,0,7]) scale([1,1,1]) cylinder(d=33,h=7);
				}
				translate([0,-25,0])
				{	
					cube([20,50,25]);
					//cube([10,50,50]);
					//translate([0,0,14])cube([20,50,7]);
				}
			}
			translate([printLayout ? 13 : 0,0,printLayout ? -13 : 0]) rotate([0,printLayout ? 180 : 0,printLayout ? 0 : 0]) intersection()
			{
				armsEndEffector();
				translate([20,-25,0]) cube([20,50,7]);
			}
			///*
			translate([printLayout ? 6 : 0,0,printLayout ? -34 : 0]) rotate([0,printLayout ? 0 : 0,printLayout ? 0 : 0]) intersection()
			{
				armsEndEffector();
				translate([20,-25,14]) cube([20,50,7]);
			}
			//*/
		}
		rotate([0,90,0]) cylinder(r=4,h=40);

	}



}




module armsRods(d=4+0.2,h=100,fn=24,rot=0)
{
			color("red") translate([0,14,3.5]) rotate([0,90,0]) rotate([0,0,rot]) cylinder(d=d,h=h,$fn=fn);
			color("red") translate([0,-14,3.5]) rotate([0,90,0]) rotate([0,0,rot]) cylinder(d=d,h=h,$fn=fn);
			color("red") translate([0,14,3.5+14]) rotate([0,90,0]) rotate([0,0,rot]) cylinder(d=d,h=h,$fn=fn);
			color("red") translate([0,-14,3.5+14]) rotate([0,90,0]) rotate([0,0,rot]) cylinder(d=d,h=h,$fn=fn);
}

module armsEndEffector()
{
	difference()
	{
			hull()
			{
				translate([0,0,0]) armsRods(d=rolson_hex_nut_dia(4)-1,h=32);
			}
			translate([-0.1,0,0]) armsRods(d=4+0.2,h=100);
			//color("red") translate([-0.1,0,10.5]) rotate([0,90,0]) scale([1,15,1]) cylinder(d=7,h=21,$fn=32);
			translate([-0.1,0,0]) armsRods(d=rolson_hex_nut_dia(4)+0.5,h=rolson_hex_nut_hi(4)+0.3,fn=6,rot=30);
			color("red") translate([20,0,-0.1]) rotate([0,0,0]) cylinder(d=Bearing624Diameter(),h=Bearing624Height()+0.1,$fn=32);
			color("red") translate([20,0,0.0+14+2]) rotate([0,0,0]) cylinder(d=Bearing624Diameter(),h=Bearing624Height()+0.1,$fn=32);
			color("red") translate([20,0,-0.1]) rotate([0,0,0]) cylinder(d=rolson_hex_nut_dia(4)+1,h=100,$fn=32);
	}
}
// 
if( drawArray==[] || search(3,drawArray)!=[] )
{
	printLayout = 0;

	a = printLayout ? 0 : q11;
	ax = printLayout ? 0 : 0;

	translate ([0,0,part1ZBase]) rotate([ax,0,a])
	{
		// subpart 1
		translate([printLayout ? 0 : 21,printLayout ? 60 : 0,printLayout ? 3 : 0])
		rotate([0,printLayout ? 90 : 0,printLayout ? 0 : 0]) 
		color("blue") difference()
		{
			hull()
			{
				translate([0,0,0]) armsRods(d=rolson_hex_nut_dia(4)-1,h=19);
			}
			translate([-0.1,0,0]) armsRods(d=4+0.2,h=100);
			//color("red") translate([-0.1,0,10.5]) rotate([0,90,0]) scale([1,1.5,1]) cylinder(d=15,h=100,$fn=32);
			color("red") translate([-0.1,0,10.5]) rotate([0,90,0]) scale([1,1.5,1]) cylinder(d=15,h=100,$fn=32);
			//color("red") translate([-0.1,0,10.5]) rotate([0,90,0]) cylinder(d=8,h=100,$fn=32);
			//color("red") translate([-0.1,10,10.5]) rotate([0,90,0]) cylinder(d=5,h=100,$fn=32);
			//color("red") translate([-0.1,0,10.5-5]) rotate([0,90,0]) cylinder(d=8,h=100,$fn=32);
			//color("red") translate([-0.1,-9,10.5]) rotate([0,90,0]) cylinder(d=8,h=100,$fn=32);
			//color("red") translate([-0.1,9,10.5]) rotate([0,90,0]) cylinder(d=8,h=100,$fn=32);
			translate([-0.1,0,0]) armsRods(d=rolson_hex_nut_dia(4)+0.5,h=rolson_hex_nut_hi(4)+0.3,fn=6,rot=30);
			//color("red") translate([-0.1,10,10.5]) rotate([90,0,0]) cylinder(d=8,h=70,$fn=32);
		}
		// subpart 2
		translate([printLayout ? -30 : 21+19,printLayout ? 60 : 0,printLayout ? 24 : 0])
		rotate([0,printLayout ? 90 : 0,printLayout ? 0 : 0]) 
		color("green") difference()
		{
			hull()
			{
				translate([0,0,0]) armsRods(d=rolson_hex_nut_dia(4)-1,h=40);
			}
			translate([-0.1,0,0]) armsRods(d=4+0.2,h=100);
			color("red") translate([-0.1,0,10.5]) rotate([0,90,0]) scale([1,1.5,1]) cylinder(d=15,h=100,$fn=32);
			translate([-0.1,0,0]) armsRods(d=rolson_hex_nut_dia(4)+0.5,h=rolson_hex_nut_hi(4)+0.3,fn=6,rot=30);
		}
		// subpart 3
		translate([printLayout ? -30 : 21+19+40,printLayout ? 60 : 0,printLayout ? 24 : 0])
		rotate([0,printLayout ? 0 : 0,printLayout ? 0 : 0]) 
		color("magenta")
		{
			translate([printLayout ? 20 : 0,0,printLayout ? -20 : 0])  rotate([0,printLayout ? 270 : 0,printLayout ? 0 : 0]) intersection()
			{
				difference()
				{	
					armsEndEffector();
					translate([20,0,7]) scale([1,1,1]) cylinder(d=33,h=7);
				}
				translate([0,-25,0])
				{	
					cube([20,50,25]);
					//cube([10,50,50]);
					//translate([0,0,14])cube([20,50,7]);
				}
			}
			translate([printLayout ? 15 : 0,0,printLayout ? -13 : 0]) rotate([0,printLayout ? 180 : 0,printLayout ? 0 : 0]) intersection()
			{
				armsEndEffector();
				translate([20,-25,0]) cube([20,50,7]);
			}
			translate([printLayout ? 6 : 0,0,printLayout ? -34 : 0]) rotate([0,printLayout ? 0 : 0,printLayout ? 0 : 0]) intersection()
			{
				armsEndEffector();
				translate([20,-25,14]) cube([20,50,7]);
			}
		}
	}
	//translate ([0,0,part1ZBase+21/2]) rotate([90,0,q11+90]) cylinder(d=30,h=40);
}
	smallArmLen = 41;

module part4(printLayout,drawArraySubpart)
{		
  xd = l * cos(q11);
  yd = l * sin(q11);
	a = printLayout ? 0 : q22;//atan((y-yd)/(x-xd));
	//echo (a);
	difference()
	{
		translate ([xd,yd,part1ZBase+7])
			rotate([0,0,a+180]) 
		{
			difference()
			{
				union()
				{
					if( drawArraySubpart==[] || search(1,drawArraySubpart)!=[] )
					{
						difference()
						{
							union()
							{
						color("gray") 
						cylinder(r=15,h=bottomArmH);
						color("blue") 
						hull()
						{
							translate([0,0,0]) cylinder(r=5,h=bottomArmH);
							translate([-0,-25,0]) cylinder(r=5,h=bottomArmH);
						}

						color("green") 
						difference()
						{
							hull()
							{
								translate([0,-15,0]) cylinder(r=7,h=bottomArmH);
								translate([0,-25,0]) cylinder(r=7,h=bottomArmH);
							}
							hull()
							{
								color("red") translate([8,-16,-1]) cylinder(d=6,h=30,$fn=32);
								color("red") translate([10,-27,-1]) cylinder(d=5,h=30,$fn=32);
							}
						}
						
						difference()
						{
							color("red") translate([5.5,-16.5,0]) cylinder(d=3,h=7,$fn=32);
							color("red") translate([6.4,-15.25,-1]) cylinder(d=2.5,h=30,$fn=32);
						}

						color("blue") 
						hull() 
						{
							translate([0,-27.1,0]) scale([0.8,1,1]) cylinder(r=9,h=bottomArmH);
							translate([Linkage_2-30,-10,0]) cylinder(r=8,h=bottomArmH);
						}
						color("blue") 
						hull() 
						{
							//translate([Linkage_2-20,-10,0]) cylinder(r=8,h=bottomArmH);
							//translate([Linkage_2*0.85,0,0]) cylinder(r=8,h=bottomArmH);
						}
					}
									
					color("red") translate([0,0,-1]) cylinder(d=4,h=30,$fn=32);
					hull()
					{
						color("red") translate([-8,-16,-1]) cylinder(d=6,h=30,$fn=32);
						color("red") translate([-10,-27.2,-1]) cylinder(d=5,h=30,$fn=32);
					}
				}
					}
					/*
					*/
					if( drawArraySubpart==[] || search(2,drawArraySubpart)!=[] )
					{
						color("green") 
						{
							hull() 
							{
								translate([Linkage_2-57,-16.5,7]) scale([0.8,1,1]) cylinder(r=8,h=bottomArmH);
								translate([Linkage_2-30,-10,7]) cylinder(r=8,h=bottomArmH);
							}
							hull()
							{
								//translate([Linkage_2,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
								translate([Linkage_2,0,7]) cylinder(r=8+4,h=bottomArmH);
								translate([Linkage_2-30,-10,7]) cylinder(r=8,h=bottomArmH);
								translate([Linkage_2-30,-10,7]) cylinder(r=8,h=bottomArmH);
							}
							translate([Linkage_2,0,7]) cylinder(r=8+4,h=10);

						}
						translate([Linkage_2,0,7]) rotate([0,0,-50]) translate([0,-4,0]) cube([16,8,10]);
					}
					if( drawArraySubpart==[] || search(3,drawArraySubpart)!=[] )
					{
						armH = 10;
						difference()
						{
							union()
							{
								color("yellow") 
								{
									hull() 
									{
										translate([Linkage_2-100,-29,7]) scale([1,1,1]) cylinder(r=12,h=armH);
										translate([Linkage_2-72,-20,7]) cylinder(r=9,h=armH);
									}
									hull() 
									{
										translate([Linkage_2-100,-29,7]) scale([1,1,1]) cylinder(r=12,h=armH);
										translate([Linkage_2-120,-28,7]) cylinder(r=12,h=armH);
									}
									hull() 
									{
										translate([Linkage_2-120,-28,7]) cylinder(r=12,h=armH);
										translate([Linkage_2-134,-20,7]) scale([1,1,1]) cylinder(r=12,h=armH);
									}
								}
								//translate([Linkage_2,0,7]) rotate([0,0,-50]) translate([0,-4,0]) cube([16,8,10]);
							}
							translate([0,0,7-1]) cylinder(r=23,h=armH+2);
						}
					}
					if( drawArraySubpart==[] || search(4,drawArraySubpart)!=[] )
					{
						armH = 10;
						difference()
						{
							union()
							{
								color("green") 
								{
									hull() 
									{
										translate([Linkage_2-120,-28,7+8]) cylinder(r=12,h=9);
										translate([Linkage_2-134,-20,7+8]) scale([1,1,1]) cylinder(r=12,h=9);
									}
									hull() 
									{
										translate([Linkage_2-134,-20,7+8]) scale([1,1,1]) cylinder(r=12,h=9);
										translate([Linkage_2-140,0,7+8]) cylinder(r=14,h=9);
									}
								}
								//translate([Linkage_2,0,7]) rotate([0,0,-50]) translate([0,-4,0]) cube([16,8,10]);
							}
							translate([0,0,7-1]) cylinder(r=23,h=armH+2);
						}
					}
				}
				// hot end mount hole
				if( drawArraySubpart==[] || search(2,drawArraySubpart)!=[] )
				{
					translate([Linkage_2,0,-1]) rotate([0,0,-50]) translate([0,-0.5,0]) cube([20,1,20]);
					translate([Linkage_2,0,7+10/2]) rotate([0,0,-50]) translate([12,10,0]) rotate([90,0,0])   cylinder(d=rolson_hex_nut_dia(3),h=3+3,$fn=12);
					translate([Linkage_2,0,7+10/2]) rotate([0,0,-50])  translate([12,-4,0]) rotate([90,0,0])  cylinder(d=rolson_hex_nut_dia(3),h=3+3,$fn=12);
					translate([Linkage_2,0,7+10/2]) rotate([0,0,-50]) translate([12,20,0]) rotate([90,0,0])   cylinder(d=3,h=40,$fn=12);
					color("red") translate([Linkage_2,0,-1]) cylinder(r=8+0.1,h=30,$fn=32);
				}

				if( drawArraySubpart==[] ||
					search(1,drawArraySubpart)!=[] || 
					search(2,drawArraySubpart)!=[] ||
					search(3,drawArraySubpart)!=[] )
				{
					color("red") translate([Linkage_2-30,-10,-1]) rotate([0,0,-166])
					{
						color("red") translate([0,0,0]) cylinder(d=3,h=30,$fn=32);
						color("red") translate([14,0,0]) cylinder(d=3,h=30,$fn=32);
						color("red") translate([14*2,0,0]) cylinder(d=3,h=30,$fn=32);
						color("red") translate([14*3,0,0]) cylinder(d=3,h=30,$fn=32);
						color("red") translate([14*4,0,0]) cylinder(d=3,h=30,$fn=32);
						color("red") translate([14*5,0,0]) cylinder(d=3,h=30,$fn=32);
					}
				}
				if( drawArraySubpart==[] ||
					search(4,drawArraySubpart)!=[] ||
					search(4,drawArraySubpart)!=[] )
				{
													hull() 
									{
										translate([Linkage_2-120,-28,7+8]) cylinder(d=3,h=9);
										translate([Linkage_2-134,-20,7+8]) scale([1,1,1]) cylinder(r=12,h=9);
									}
									hull() 
									{
										translate([Linkage_2-134,-20,7+8]) scale([1,1,1]) cylinder(r=12,h=9);
										translate([Linkage_2-140,0,7+8]) cylinder(r=14,h=9);
									}
								}

			}
			//color("red") translate([Linkage_2,0,15]) rotate([0,180,0])  heatsinkE3DV5(0,100);
			if( drawArray==[] )
			{
				translate([0,0,1]) Bearing623();
				translate([0,0,1+Bearing623Height()]) Bearing623();
			}
		}
	}
}

if( drawArray==[] || search(4,drawArray)!=[] )
{
	
	//printLayout = 1;
	drawArraySubpart = [1,2,3,4];//[1,2,3,4];//[1,2,3];//[1,2,3,4,5];//[1,7,8];
	difference()
	{
		part4(printLayout,drawArraySubpart);
		union() 
		{
			q11 = printLayout ? 0 : q11;
			xd = l * cos(q11);
			yd = l * sin(q11);
			a = printLayout ? 0 : atan2((y-yd)/(x-xd));
			a2 = printLayout ? 0 : atan2(yd,xd);
			rotAngle = printLayout ? 0 : a;
			rotAngle2 = printLayout ? 0 : -rotAngle+a2;
			hull()
			{
				rotAngle = printLayout ? 0 : a;
				translate ([xd,yd,part1ZBase])
					rotate([0,0,a+180]) 
				{
						translate([-smallArmLen,0,0]) cylinder(d=4,h=50,$fn=16);
				}
			}
		}
	}
}

module part5(printLayout)
{
	q11 = printLayout ? 0 : q11;
	xd = l * cos(q11);
  yd = l * sin(q11);
	a = printLayout ? 0 : q22;// atan((y-yd)/(x-xd));
	a2 = printLayout ? 0 : atan2(yd,xd);
	
	/*
	hull()
	{
		rotAngle = printLayout ? 0 : a;
		translate([0,0,part2ZBase+7+7/2]) rotate([0,0,rotAngle]) 
		{
			// subpart 4
			translate([printLayout ? -30 : smallArmLen,printLayout ? 60 : 0,printLayout ? 24 : 0])
			rotate([0,printLayout ? 0 : 0,printLayout ? 0 : 0]) 
			color("magenta")
			{
				sphere(r=3);
			}
		}

		translate ([xd,yd,part2ZBase+7+7/2])
			rotate([0,0,a+180]) 
		{
				translate([-smallArmLen,0,0]) sphere(r=0.1);
		}
	}
	*/
	rotAngle = printLayout ? 0 : a;
	rotAngle2 = printLayout ? 0 : -rotAngle+a2;
	translate([0,0,part2ZBase+7]) rotate([0,0,rotAngle]) 
	{
		translate([smallArmLen,0,0]) rotate(rotAngle2)
		difference()
		{
			union()
			{
				cylinder(r=15,h=bottomArmH);
				color("blue") 
				{
					hull()
					{
						translate([0,-10,0]) cylinder(r=5,h=7);
						rotate([0,0,-90]) translate([22,0,0]) cylinder(r=5,h=7);
					}
					hull()
					{
						rotate([0,0,-90]) translate([22,0,0]) cylinder(r=5,h=7);
						rotate([0,0,-90]) translate([25,0,0]) cylinder(r=5,h=7);
						translate([50,-23,0]) cube([10,10,7]);
					}
					difference()
					{
						translate([0,-13,0]) scale([1.4,1,1]) cylinder(r=5,h=7);
						hull()
						{
						translate([-8,-16.1,-1]) scale([1.0,1,1]) cylinder(r=3,h=7+2,$fn=32);
						translate([-8,-40,-1]) scale([1.0,1,1]) cylinder(r=3,h=7+2,$fn=32);
						}
						translate([8,-16,-1]) scale([1.0,1,1]) cylinder(r=3,h=7+2,$fn=32);
					}
					translate([5,-17,0]) scale([1,1,1]) cylinder(r=3,h=7);
					//difference()
					//{
					//	translate([5,-17,0]) scale([1.2,1,1]) cylinder(r=3,h=7);
					//	translate([7.3,-15,-1]) scale([1.3,1,1]) cylinder(r=1.5,h=7+2,$fn=32);
					//}
				}
//				translate([28,-25,7/2])  rotate([90,0,-90]) cylinder(r=6,h=19);
			}
			color("red") translate([0,0,-1]) cylinder(d=3,h=30,$fn=32);
			translate([-30,-26,7/2])  rotate([90,0,90+7]) cylinder(d=4,h=170,$fn=32);
				
						hull()
						{
							translate([6.9,-14.9,-1]) scale([1.0,1,1]) cylinder(r=1.5,h=7+2,$fn=32);
							translate([10,-14.6,-1]) scale([1.0,1,1]) cylinder(r=1.5,h=7+2,$fn=32);
							//translate([7.3,-15,-1]) scale([1.3,1,1]) cylinder(r=1.5,h=7+2,$fn=32);
						}
		}
	}

	translate([xd,yd,part2ZBase+7]) rotate([0,0,rotAngle]) 
	{
		translate([smallArmLen,0,0]) rotate(rotAngle2)
		difference()
		{
			union()
			{
				//cylinder(r=15,h=bottomArmH);
				//translate([-40,-25,0]) cube([50,40,7]);
				color("blue") 
				hull()
				{
					translate([-20,-15,0]) cube([35,30,7]);
					translate([-50,-27+5,0]) cube([20,20,7]);
					//translate([0,-10,0]) cylinder(r=5,h=7);
					//rotate([0,0,-90]) translate([22,0,0]) cylinder(r=5,h=7);
				}
				color("green") hull()
				{
					translate([-50,-22,0]) cube([20,14,7]);
					translate([-85,-26.3,0]) cube([20,10,7]);
					//translate([0,-10,0]) cylinder(r=5,h=7);
					//rotate([0,0,-90]) translate([22,0,0]) cylinder(r=5,h=7);
				}
//				translate([28,-25,7/2])  rotate([90,0,-90]) cylinder(r=6,h=19);
			}
			color("red") translate([0,0,2]) cylinder(d=Bearing624Diameter(),h=7,$fn=32);
			color("red") translate([0,0,-1]) cylinder(d=rolson_hex_nut_dia(4)+1,h=15,$fn=32);
			hull()
			{
				translate([-35,5,-0.5]) cube([15,10,8]);
				translate([-51,-8,-0.5]) cube([1,10,8]);
			}
			#translate([-120,-25,7/2])  rotate([90,0,90+7]) cylinder(d=4,h=170,$fn=32);
			translate([-120,10,7/2])  rotate([90,0,90]) cylinder(d=4,h=170,$fn=32);
//			translate([28,-25,0])  rotate([90,0,-90]) cylinder(d=4,h=19);
		}
	}
}

if( drawArray==[] || search(5,drawArray)!=[] )
{
	//printLayout = 1;
	// subpart 1
	intersection()
	{
		part5(printLayout);
	
		smallArmLen = 41;
		q11 = printLayout ? 0 : q11;
		xd = l * cos(q11);
		yd = l * sin(q11);
		a = printLayout ? 0 : q22;//atan((y-yd)/(x-xd));
		a2 = printLayout ? 0 : atan2(yd,xd);
		rotAngle = printLayout ? 0 : a;
		rotAngle2 = printLayout ? 0 : -rotAngle+a2;
		translate([xd,yd,part2ZBase+7]) rotate([0,0,rotAngle]) 
		{
			translate([smallArmLen,0,0]) rotate(rotAngle2)
			{
				translate([-120,0,7/2])  rotate([90,0,90]) cylinder(d=100,h=120,$fn=32);
			}
		}
	}
	// subpart 2
	intersection()
	{
		part5(printLayout);
	
		smallArmLen = 41;
		q11 = printLayout ? 0 : q11;
		xd = l * cos(q11);
		yd = l * sin(q11);
		a = printLayout ? 0 : atan((y-yd)/(x-xd));
		a2 = printLayout ? 0 : atan2(yd,xd);
		rotAngle = printLayout ? 0 : a;
		rotAngle2 = printLayout ? 0 : -rotAngle+a2;
		translate([xd,yd,part2ZBase+7]) rotate([0,0,rotAngle]) 
		{
			translate([smallArmLen,0,0]) rotate(rotAngle2)
			{
				translate([-120+120,0,7/2])  rotate([90,0,90]) cylinder(d=100,h=120,$fn=32);
			}
		}
	}
}

	nemaPlateSize = 50;
	nemaPlateSizeY = 44;
	nemaPlate2SizeX = 20;
	sideSize = lookup(NemaSideSize, Nema17)+0.5;

module part6(printLayout)
{
	//color("green") translate([-60,-20,yStepperZPlane-4]) cube([10,10,52]);
	difference()
	{
		union()
		{
			translate([yStepperX-nemaPlateSize/2-2,-nemaPlateSizeY/2,yStepperZPlane-4]) cube([nemaPlateSize+24,nemaPlateSizeY,4]);
			translate([yStepperX-nemaPlateSize/2-2,-sideSize/2-3,yStepperZPlane-7]) cube([nemaPlateSize+24,3,7]);
			translate([yStepperX-nemaPlateSize/2-2,+sideSize/2,yStepperZPlane-7]) cube([nemaPlateSize+24,3,7]);
			color("blue") translate([-nemaPlate2SizeX/2,-nemaPlateSizeY/2,nemaPlateSizeY-11]) cube([nemaPlate2SizeX+4,nemaPlateSizeY,7]);
			if( printLayout==0 )
			{
				color("green") translate([0,0,yStepperZPlane-13-7]) rotate([0,0,-90]) shf8();
			}
		}
		cylinder(d=8,h=100);
		hull()
		{
			translate([yStepperX,yStepperY,yStepperZPlane-5]) cylinder(d=23,h=3);
			translate([yStepperX-5,yStepperY,yStepperZPlane-5]) cylinder(d=23,h=3);
		}
		translate([yStepperX,yStepperY,yStepperZPlane-5]) cylinder(d=5,h=20);
		color("green") translate([0,0,yStepperZPlane-13]) rotate([0,0,-90]) shf8(1);
		translate([xStepperX,xStepperY,yStepperZPlane])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
		translate([xStepperX-1,xStepperY,yStepperZPlane])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
		translate([xStepperX-2,xStepperY,yStepperZPlane])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
		translate([xStepperX-3,xStepperY,yStepperZPlane])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
		translate([xStepperX-4,xStepperY,yStepperZPlane])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
		translate([xStepperX-5,xStepperY,yStepperZPlane])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
		translate([-30,11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4,h=50,$fn=12);
		translate([-10,11,yStepperZPlane-7.5]) rotate([0,90,0])rotate([0,0,30]) cylinder(d=rolson_hex_nut_dia(4),h=rolson_hex_nut_hi(4),$fn=6);
		translate([-30,-11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4,h=50,$fn=12);
		translate([-10,-11,yStepperZPlane-7.5]) rotate([0,90,0])rotate([0,0,30]) cylinder(d=rolson_hex_nut_dia(4),h=rolson_hex_nut_hi(4),$fn=6);
	}
	
}

if( drawArray==[] || search(6,drawArray)!=[] )
{
	printLayout = 1;
	// subpart 1
	part6(printLayout);
	// subpart 2
	translate([0,0,139]) mirror([0,0,1]) part6(printLayout);
	// subpart 3 (2 times)
	color("blue") translate([0,0,yStepperZPlane]) difference()
	{
		cylinder(d=12,h=5,$fn=32);
		cylinder(d=8,h=6,$fn=32);
	}
	// subpart 4
	color("blue") translate([0,0,yStepperZPlane+23]) difference()
	{
		cylinder(d=12,h=3,$fn=32);
		cylinder(d=8,h=6,$fn=32);
	}
	// subpart 5
	difference()
	{
		color("orange") translate([-nemaPlate2SizeX/2-2,-nemaPlateSizeY/2+1,nemaPlateSizeY-11]) cube([2,nemaPlateSizeY-2,7]);
		translate([-11,11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4.2,h=50,$fn=12);
		translate([-11,-11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4.2,h=50,$fn=12);
	}
	// subpart 6
	translate([0,0,139]) mirror([0,0,1]) difference()
	{
		color("orange") translate([-nemaPlate2SizeX/2-2,-nemaPlateSizeY/2+1,nemaPlateSizeY-11]) cube([2,nemaPlateSizeY-2,7]);
		translate([-11,11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4.2,h=50,$fn=12);
		translate([-11,-11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4.2,h=50,$fn=12);
	}
	// 
	//color("blue") translate([-60,-20,yStepperZPlane]) cube([10,10,51]);
	// 
	//color("green") translate([-60,-sideSize/2-3,yStepperZPlane]) cube([16,sideSize+6,5]);
}


union()
{
translate([-64+1.5,42/2,nemaPlateSizeY-2]) rotate([0,0,180]) rotate([0,-90,0]) CProfileWithDimensions(23,55,2.5,42);

color("yellow") translate([-118.5+1,42/2,nemaPlateSizeY-16]) rotate([90,0,0]) rotate([0,0,0]) CProfileWithDimensions(21,55,2.5,85);
}

module nutHolder()
{
	difference()
	{
	color("blue") translate([zStepperX,zStepperY,49-baseOffset+50]) translate([-13,-18.5,29]) cube([26,37,20]);
color("red") translate([zStepperX,zStepperY,49-baseOffset+64])
	rotate([0,0,45]) T8Nut(1);	
		translate([zStepperX,zStepperY,49-baseOffset]) cylinder(d=10.2,h=100,$fn=32);
	
		
		translate([zStepperX+4+4,zStepperY+50,49-baseOffset+94]) rotate([90,0,0]) cylinder(d=3,h=100,$fn=32);
		translate([zStepperX+4+4,zStepperY+50,49-baseOffset+84]) rotate([90,0,0]) cylinder(d=3,h=100,$fn=32);
		translate([zStepperX-2,zStepperY+50,49-baseOffset+84]) rotate([90,0,0]) cylinder(d=3,h=100,$fn=32);
		translate([zStepperX-2,zStepperY+50,49-baseOffset+94]) rotate([90,0,0]) cylinder(d=3,h=100,$fn=32);

		hull() 
		{
		translate([zStepperX-2,zStepperY-10,49-baseOffset+84+20]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		translate([zStepperX-2,zStepperY-10,49-baseOffset+84-0.7]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		}

		mirror([0,1,0]) hull() 
		{
		translate([zStepperX-2,zStepperY-10,49-baseOffset+84+20]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		translate([zStepperX-2,zStepperY-10,49-baseOffset+84-0.7]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		}

		//#translate([0,30,0]) 
		hull() 
		{
		translate([zStepperX+4+4,zStepperY+13,49-baseOffset+84-0.7]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		translate([zStepperX+4+4,zStepperY+13,49-baseOffset+84+20]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		}

		hull() 
		{
		translate([zStepperX+4+4,zStepperY-10,49-baseOffset+84-0.7]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		translate([zStepperX+4+4,zStepperY-10,49-baseOffset+84+20]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.4,h=3,$fn=6);
		}


		//#translate([0,0,30]) 
		///*
		hull() 
		{
		translate([zStepperX-4-5.5-3.5,zStepperY-12,49-baseOffset+61]) cylinder(d=rolson_hex_nut_dia(4)+4,h=6,$fn=12);
		translate([zStepperX-4-5.5-3.5,zStepperY-12,49-baseOffset+61+40]) cylinder(d=rolson_hex_nut_dia(4)+4,h=6,$fn=12);
		}

		hull() 
		{
		translate([zStepperX-4-5.5-3.5,zStepperY+12,49-baseOffset+61]) cylinder(d=rolson_hex_nut_dia(4)+4,h=6,$fn=12);
		translate([zStepperX-4-5.5-3.5,zStepperY+12,49-baseOffset+61+40]) cylinder(d=rolson_hex_nut_dia(4)+4,h=6,$fn=12);
		}
//*/
	}
}

// nut holder
if( drawArray==[] || search(10,drawArray)!=[] )
{
union()
{


intersection()
{
nutHolder();
	translate([zStepperX-50,zStepperY-50,49-baseOffset+79]) cube([100,100,10]);
}
}
}

bearingZOffset = -16;
bearingZ2Offset = 53-16;
rodsZ = 16;
baseOffset = 35;
rodsDist = 52;
rodsLen = 250;
T8Len = 200;
//z = 120;
shfX1 = -74.5-3;
shfY1 = 0;
shfX2 = -74.5-3-rodsDist;
shfY2 = 0;

zStepperX = -106-5-1.5+10;
zStepperY = 0;
zStepperZ = 49-35;

plateZ2 = 245;

kfl08_rot = -33;
shf81_rot = -7;

if( drawRods || drawZAxis || drawMetall)
{
	color("blue") translate([-74.5-3,0,rodsZ]) cylinder(d=8,h=rodsLen);
	color("red") translate([shfX1,shfY1,rodsZ]) rotate([0,0,90])  shf8();
	color("blue") translate([-74.5-3-rodsDist,0,rodsZ]) cylinder(d=8,h=rodsLen);
	color("red") translate([shfX2,shfY2,rodsZ]) rotate([0,0,-90])  shf8();

color("red") translate([shfX1,shfY1,plateZ2-10]) rotate([0,0,-90])  shf8();
color("red") translate([shfX2,shfY2,plateZ2-10]) rotate([0,0,-90+shf81_rot])  shf8();
color("red") translate([zStepperX,zStepperY,plateZ2]) rotate([180,0,90+kfl08_rot])  kfl08();
}

if( drawMetall || drawZAxis )
{

color("green") translate([zStepperX,zStepperY,rodsZ+20]) cylinder(d=8,h=T8Len);

color("red") translate([-74.5-3,0,nemaPlateSizeY+bearingZOffset+z]) rotate([0,0,-90]) rotate([90,0,0]) 
{
	SCS8UU();
	SCS8UU(1);
}

color("red") translate([-74.5-rodsDist-3,0,nemaPlateSizeY+bearingZOffset+z]) rotate([0,0,-90]) rotate([90,0,0]) 
{
	SCS8UU();
	SCS8UU(1);
}

color("green") translate([-74.5-3,0,nemaPlateSizeY+bearingZ2Offset+z]) rotate([0,0,-90]) rotate([90,0,0]) 
{
	SCS8UU();
	SCS8UU(1);
}

color("green") translate([-74.5-rodsDist-3,0,nemaPlateSizeY+bearingZ2Offset+z]) rotate([0,0,-90]) rotate([90,0,0]) 
{
	SCS8UU();
	SCS8UU(1);
}
}
//color("magenta") translate([-120,-20,-baseOffset+63]) cube([20,40,6+18]);

if( drawMetall )
{
color("magenta") translate([-120,-20,-baseOffset+63])	rotate([90,-90,0])dimensions(6+18, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);

color("magenta") translate([-120,-20,-baseOffset+63])	rotate([90,-90,0])dimensions(6+18+35, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);

color("magenta") translate([-120,-20,-baseOffset+63])	rotate([90,-90,0])dimensions(6+18+35+18, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);

color("magenta") translate([-65,-20,-baseOffset+63+14])	rotate([90,-90,0])dimensions(10, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);

color("magenta") translate([-65,-20,-baseOffset+63+14])	rotate([90,-90,0])dimensions(10+35, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
}

// tower back panel
if( drawMetall )
{
	translate([-143,-22,-baseOffset]) cube([2,44,300]);
}
//translate([-81,-20,-baseOffset]) cube([20,40,48]);

//translate([-161,-20,-baseOffset]) cube([20,40,300]);
//translate([-81,-20,-baseOffset]) cube([20,40,48]);

if( drawZStepper || drawZAxis )
{
	translate([zStepperX,zStepperY,zStepperZ]) rotate([180,0,0]) Nema17_shaft24_Stepper();
}


if( drawMetall )
{
color("brown") translate([zStepperX,zStepperY,49-baseOffset+7])
difference()
{
	cylinder(d=20,h=25);
	translate([0,0,-1]) cylinder(d=8,h=35);
}
}

module T8Nut(bHolesOnly=0)
{
		difference()
		{
			union()
			{
				cylinder(d=10.2,h=10+3.5+1.5);
				translate([0,0,10]) cylinder(d=22,h=3.5);
		}
		translate([0,0,-1]) cylinder(d=8,h=33);
		translate([8,0,5]) cylinder(d=3.3,h=10,$fn=12);
		translate([-8,0,5]) cylinder(d=3.3,h=10,$fn=12);
		translate([0,8,5]) cylinder(d=3.3,h=10,$fn=12);
		translate([0,-8,5]) cylinder(d=3.3,h=10,$fn=12);
	}
	if( bHolesOnly )
	{
		translate([8,0,0]) cylinder(d=3.3,h=50,$fn=12);
		translate([-8,0,0]) cylinder(d=3.3,h=50,$fn=12);
		translate([0,8,0]) cylinder(d=3.3,h=50,$fn=12);
		translate([0,-8,0]) cylinder(d=3.3,h=50,$fn=12);
	}
}

if( drawMetall )
{
color("red") translate([zStepperX,zStepperY,49-baseOffset+90]) rotate([180,0,0]) 
	T8Nut();
}


if( drawMetall )
{
	// z stepper and rods plate
	union()
	{
		w = 80;
		h = 46;
		difference()
		{
			translate([-85-rodsDist-3,-23,13]) cube([w,h,3]);
			color("red") translate([shfX1,shfY1,rodsZ-10]) rotate([0,0,90])  shf8(2);
			color("red") translate([shfX2,shfY2,rodsZ-10]) rotate([0,0,90])  shf8(2);
			translate([zStepperX,zStepperY,zStepperZ]) rotate([180,0,0]) Nema17_shaft24_Stepper(1);//0,NemaSize);
			translate([zStepperX,zStepperY,zStepperZ-5]) cylinder(d=25,h=10);
		}
		color("magenta") translate([-85-rodsDist-3,23,-baseOffset+55])	dimensions(w, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("magenta") translate([-85-rodsDist-3,-16,-baseOffset+55])	dimensions(10.5, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("magenta") translate([-85-rodsDist-3,-16,-baseOffset+55])	dimensions(10.5+52, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([shfX1,-23,-baseOffset+55])	rotate([0,0,90]) dimensions(7, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([shfX1,-23,-baseOffset+55])	rotate([0,0,90]) dimensions(7+32, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([shfX1-35,-23,-baseOffset+55])	rotate([0,0,90]) dimensions(h, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		// stepper
		color("green") translate([zStepperX-15.5,-23,-baseOffset+55])	rotate([0,0,90]) dimensions(7.5, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([zStepperX+31/2,-23,-baseOffset+55])	rotate([0,0,90]) dimensions(7.5+31, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("magenta") translate([-85-rodsDist-3,15.5,-baseOffset+55])	dimensions(22, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([-85-rodsDist-3,15.5,-baseOffset+55])	dimensions(22+31, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("magenta") translate([-85-rodsDist-3,0,-baseOffset+55])	dimensions(22+31/2, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
	}
}
if( drawMetall )
{
	// rods mount top plate
	union()
	{
		w = 80;
		h = 46;
		difference()
		{
			viewType = 2;//2;
			translate([-85-rodsDist-3,-23,plateZ2]) cube([w,h,3]);
			color("red") translate([shfX1,shfY1,plateZ2-10]) rotate([0,0,-90])  shf8(viewType);
			color("red") translate([shfX2,shfY2,plateZ2-10]) rotate([0,0,-90+shf81_rot])  shf8(viewType);
			color("green")  translate([zStepperX,zStepperY,plateZ2]) rotate([-180,0,90+kfl08_rot]) kfl08(viewType);
		}
		//color("red") translate([-85-rodsDist-3+25,-23,plateZ2]) cube([20,2,50]);
		color("magenta") translate([-85-rodsDist-3,23,plateZ2+5])	dimensions(w, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("magenta") translate([-85-rodsDist-3,-16,plateZ2+5])	dimensions(10.5-2, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_LEFT);
		color("green") translate([-85-rodsDist-3+8.5,-23,plateZ2+5])	rotate([0,0,90]) dimensions(23-15.9, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_LEFT);
	//	color("red") translate([-85-rodsDist-3+8.5,-15.9,plateZ2]) cylinder(d=5,$fn=24);

		//color("red") translate([-85-rodsDist-3+12.5,15.9,plateZ2]) cylinder(d=5,$fn=24);
		color("magenta") translate([-85-rodsDist-3,16,plateZ2+5])	dimensions(12.5, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_LEFT);
		color("green") translate([-85-rodsDist-3+12.5,-23,plateZ2+5])	rotate([0,0,90]) dimensions(20+18.9, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);

		
		color("magenta") translate([-85-rodsDist-3,-16,plateZ2+5])	dimensions(10.5+52, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_RIGHT);
		color("green") translate([shfX1,-23,plateZ2+5])	rotate([0,0,90]) dimensions(7, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([shfX1-12+12,-23,plateZ2+5])	rotate([0,0,90]) dimensions(7+32, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("green") translate([shfX1-35+50,-23,plateZ2+5])	rotate([0,0,90]) dimensions(h, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		// stepper
		color("magenta") translate([-85-rodsDist-3,-15.5-5,plateZ2+5])	dimensions(10.5+17, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_LEFT);
		color("green") translate([-85-rodsDist-3+27.5,-23,plateZ2+5])	rotate([0,0,90]) dimensions(7.5, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_LEFT);
		color("green") translate([-85-rodsDist-3+47.5,-23,plateZ2+5])	rotate([0,0,90]) dimensions(4+34, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		color("magenta") translate([-85-rodsDist-3,21,plateZ2+5])	dimensions(10.5+37, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		//color("magenta") translate([-85-rodsDist-3,15.5,plateZ2+5])	dimensions(22, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		//color("green") translate([-85-rodsDist-3,15.5,plateZ2+5])	dimensions(22+31, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
		//color("magenta") translate([-85-rodsDist-3,0,plateZ2+5])	dimensions(22+31/2, DIM_LINE_WIDTH, height=DIM_HEIGHT, loc=DIM_OUTSIDE);
	}
}
//*/
m3PlatesRad = rolson_hex_nut_dia(3)/2+0.9;

module switchXMount()
{
			translate([-alumXOffset+4.5-3,switchX_oy,15-1.5]) 
        color("blue") rotate([0,0,0]) scale([1,1,1])
          cube([3.5+3,20,19]);
}


// zmin endstopper mount
if( drawArray==[] || search(7,drawArray)!=[] )
{
//zmin
translate([-30,0,-5]) union()
{
	translate([0,0,5])
	difference()
	{
	translate([0,-11,-15]) cube([8,22,10]);

			translate([0,-10,-5]) rotate([-90,0,90]) EndSwitchBody20x11(1);
		translate([4,0,-30]) cylinder(d=3,h=50,$fn=32);
		translate([4,0,-30]) rotate([0,0,-90]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=17,$fn=6);
		translate([4,-11,-30]) cylinder(d=7,h=50,$fn=4);
		translate([4,11,-30]) cylinder(d=7,h=50,$fn=4);
}
	translate([0,0,5])
			translate([0,-10,-5]) rotate([-90,0,90]) EndSwitchBody20x11(0);

color("green") 
{
	difference()
	{
	union()
	{
	union()
	{
	translate([-1,-22.5+2,-30]) cube([10,11.5-2,30]);
		translate([4,-11,-30]) cylinder(d=7,h=30,$fn=4);
	}
	mirror([0,1,0]) union()
	{
	translate([-1,-22.5+2,-30]) cube([10,11.5-2,30]);
		translate([4,-11,-30]) cylinder(d=7,h=30,$fn=4);
	}
	hull()
	{
	translate([-2,-22.5+2,-30]) cube([12,45-4,6]);
	translate([-1,-22.5+2,-22]) cube([10,45-4,1]);
	}
}
translate([4,-25,-5]) rotate([-90,0,0]) cylinder(d=3,h=15,$fn=16);
mirror([0,1,0])translate([4,-25,-5]) rotate([-90,0,0]) cylinder(d=3,h=15,$fn=16);
//translate([40,-22.5,-30]) rotate([0,0,90]) LProfile(20,20,2,150-6);
//mirror([0,1,0]) #translate([40,-22.5,-30]) rotate([0,0,90]) LProfile(40,40,2,150-6);

hull()
{
translate([4,-18,-5]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=3,$fn=6);
translate([4,-18,5]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=3,$fn=6);
}

mirror([0,1,0]) hull()
{
translate([4,-18,-5]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=3,$fn=6);
translate([4,-18,5]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=3,$fn=6);
}

		translate([4,0,-30]) cylinder(d=3,h=50,$fn=32);

translate([-25,-25,-30.1]) cube([50,50,2]);

}
}

}
}


module part8()
{
		difference()
	{
		union()
		{
//		hull()
		{
			translate([-37,-20,z+73+7+5]) rotate([0,0,90]) cube([18,10,23-5]);
		}
		hull()
		{
			translate([-44,-20,z+73+2+23]) rotate([0,0,90]) cube([10,13,5]);
			translate([-49,-14,z+73+2+23]) rotate([0,0,90]) cube([33,8,5]);
		}
		}	
			translate([xStepperX,xStepperY,z+73+7]) cylinder(d=19,h=50);
			translate([-35-1,-20,z+74]) rotate([0,0,90]) EndSwitchBody20x11(1);
			translate([-35-1,-20,z+90]) rotate([0,0,90]) EndSwitchBody20x11(1);
		translate([yStepperX-5,yStepperY,z+73+30])
		{
			rotate([0,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
	}
			translate([-35-1,-20,z+74+5]) rotate([0,0,90]) EndSwitchBody20x11();
}

// endstop mount top
if( drawArray==[] || search(8,drawArray)!=[] )
{
	part8();
}

// endstop mount bottom
if( drawArray==[] || search(9,drawArray)!=[] )
{
		difference()
	{
		union()
		{
//		hull()
		{
			translate([-26,-24,z+45]) rotate([0,0,90]) cube([15,8,23-7.5]);
		}
		//hull()
		{
			translate([-29,-24,z+45]) rotate([0,0,90]) cube([10,23,5]);
			translate([-44,-14,z+45]) rotate([0,0,90]) cube([33,8,5]);
			translate([-29,-24,z+45]) rotate([0,0,90]) cube([13,23,5]);
		}
		}	
			translate([xStepperX,xStepperY,z+40]) cylinder(d=18.5,h=50,$fn=32);
			translate([-23,-25.5,z+45]) rotate([0,0,90]) EndSwitchBody20x11(1);
			translate([-23,-25.5,z+50]) rotate([0,0,90]) EndSwitchBody20x11(1);
		translate([yStepperX,yStepperY,z+45])
		{
			rotate([0,0,0]) rotate([180,0,0]) Nema17_shaft22_Stepper(1,NemaSize);
		}
	}
		translate([-23,-25.5,z+45+18]) rotate([0,0,90]) EndSwitchBody20x11();

	//!mirror([0,0,1]) transform([0,0,0]) 
	//!mirror([0,0,1]) translate([0,0,-148])  part8();
}


module panelHolder()
{
difference()
{
	union()
	{
		translate([100-11-4,-26+6,-35]) cube([11,6,15]);
		translate([100-4-2,-26+10,-35]) cube([6,8,10]);
	}
	translate([79.9,-50/2,-35]) cube([20-4,2+3,22]);
	translate([70,-46/2,-35]) cube([30,46,3]);
	//translate([70,-30/2,-35]) cube([30,30,16]);
	//#translate([70,-36/2,-35]) cube([30,46-4-4-2,16]);
	translate([100-10,-(46-6)/2,-35+11]) rotate([-90,0,0]) cylinder(d=3,h=20,$fn=16);
	translate([100-10,-(46-6)/2,-35+11]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3)+2.5,$fn=16);
	translate([100-10,-(46-22)/2,-35+6]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=16);
	hull()
	{
	translate([100-5,-(46-22)/2,-35+6.5]) rotate([0,90,0]) rotate([0,0,30])  cylinder(d=rolson_hex_nut_dia(3)+0.8,h=rolson_hex_nut_hi(3)+0.5,$fn=6);
	translate([100-5,-(46-22)/2,-35]) rotate([0,90,0]) rotate([0,0,30])   cylinder(d=rolson_hex_nut_dia(3)+0.8,h=rolson_hex_nut_hi(3)+0.5,$fn=6);
	}
}}

// sockets plugs panel
if( drawArray==[] || search(10,drawArray)!=[] )
{

union()
{

difference()
{
	union()
	{
		translate([100-4,-50/2,-35]) cube([4+4,46+4,75+3]);
//		translate([85,-50/2,-35]) cube([15,46+4,16]);
//		translate([85,-50/2,-35+62]) cube([15,46+4,15]);
	}
translate([79.9,-50/2,-35]) cube([20,2,75]);
mirror([0,1,0]) translate([79.9,-50/2,-35]) cube([20,2,75]);
translate([79.9,-50/2,-35]) cube([20,2+3,22]);
mirror([0,1,0]) translate([79.9,-50/2,-35]) cube([20,2+3,22]);
//translate([99.9,-48/2,-35]) cube([4,48,74]);
	translate([70,-46/2,-35]) cube([30,46,3]);
	translate([70,-30/2,-35]) cube([30,30,16]);
	translate([70,-36/2,-35]) cube([30,46-4-4-2,74]);
	translate([100-10,-(46-22)/2,-35+6]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=16);
	mirror([0,1,0]) translate([100-10,-(46-22)/2,-35+6]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=16);

	translate([100-10,-(46-7)/2,-35+74-2]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=16);
	mirror([0,1,0]) translate([100-10,-(46-7)/2,-35+74-2]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=16);

	//translate([100-10,-50,-35+11]) rotate([-90,0,0]) cylinder(d=3,h=100,$fn=16);
/*
hull()
	{
	translate([100-10,-36/2,-35+11]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=2,$fn=6);
	translate([100-10,-36/2,-35+21]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=2,$fn=6);
	}
mirror([0,1,0]) hull()
	{
	translate([100-10,-36/2,-35+11]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=2,$fn=6);
	translate([100-10,-36/2,-35+21]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=2,$fn=6);
	}
	*/
	// x stepper
	translate([100-10,11,-35+74-9])
{	
	rotate([0,90,0]) cylinder(d=16,h=20);
	rotate([0,90,0]) cylinder(d=21,h=10);
}
	
// y stepper
	translate([100-10,-11,-35+74-9])
{
	rotate([0,90,0]) cylinder(d=16,h=20);
	rotate([0,90,0]) cylinder(d=21,h=10);
}
	
	// z stepper
	translate([100-10,11,-35+74-9-21])
{	
	rotate([0,90,0]) cylinder(d=16,h=20);
	rotate([0,90,0]) cylinder(d=21,h=10);
}
	
// e stepper
	translate([100-10,-11,-35+74-9-21])
{
	rotate([0,90,0]) cylinder(d=16,h=20);
	rotate([0,90,0]) cylinder(d=21,h=10);
}

	// stppers
	translate([100-10,11,-35+74-9-21-21])
{	
	rotate([0,90,0]) cylinder(d=16,h=20);
	rotate([0,90,0]) cylinder(d=21,h=10);
}

// extruder stuff
	translate([100-10,-11,-35+74-9-21-21])
{
	rotate([0,90,0]) cylinder(d=16,h=20);
	rotate([0,90,0]) cylinder(d=21,h=10);
}


}

union()
{
color ("blue") panelHolder();
mirror([0,1,0]) color ("blue") panelHolder();
}


}
}

// top cap
bMountsOnly = 4;
if( drawArray==[] || search(11,drawArray)!=[] )
{
translate([-147,-49/2,250]) union()
{
	difference()
	{
	union()
	{
			if( bMountsOnly==0 || bMountsOnly==4 )
			{
		difference()
		{
			cube([88,49,14]);
			//translate([8,0,-0.1])  cube([80,4,9]);
			translate([8,0,-0.1])  cube([80,49,9]);
			translate([8,3.5,-0.1])  cube([80,49-7,11]);
			translate([8,15,-0.1])  cube([81,17,9]);
			//translate([8,49-4,-0.1])  cube([80,4,9]);
			translate([3,4.5,-0.1])  cube([8,40,9]);
			//translate([8,4.5,-0.1])  cube([80,40,9]);
			translate([88-8,49/2-7.5,5])  cube([8,15,9]);
			}
		}
		union()
		{
			if( bMountsOnly==0 || bMountsOnly==1 || bMountsOnly==3 )
			{
			translate([88-43-5,49-3.5-12,0]) cube([10,12,11]);
			translate([88-43-5+1,49-3.5-12,0]) cube([10,12,11]);
			translate([88-43-5,3.5,0]) cube([10,12,11]);
			translate([88-43-5+1,3.5,0]) cube([10,12,11]);
			}
			if( bMountsOnly==0 || bMountsOnly==1 || bMountsOnly==2 )
			{
			translate([88-12,49-3.5-12,-0.1]) cube([12,12,11]);
			translate([88-12,3.5,-0.1]) cube([12,12,11]);
			}
		}
	}
		translate([88-43,-20,3]) rotate([-90,0,0]) cylinder(d=3,h=100,$fn=12);
		translate([88-4,-20,3]) rotate([-90,0,0]) cylinder(d=3,h=100,$fn=12);
		//
		translate([88-4,3,3]) rotate([-90,0,0]) cylinder(d=6.5,h=4.5,$fn=6);
	  translate([88-4,49-3-4.5,3]) rotate([-90,0,0]) cylinder(d=6.5,h=4.5,$fn=6);
		translate([88-43,3,3]) rotate([-90,0,0]) cylinder(d=6.5,h=4,$fn=6);
		translate([88-43,49-3-4.5,3]) rotate([-90,0,0]) cylinder(d=6.5,h=4,$fn=6);
		//translate([88-4,0,3]) rotate([-90,0,0]) cylinder(d=6.5,h=4.5,$fn=6);
		//#translate([88-63,49/2-15,3]) rotate([0,0,0]) cylinder(d=3,h=100,$fn=12);
		//#translate([88-63,49/2+15,3]) rotate([0,0,0]) cylinder(d=3,h=100,$fn=12);
		//#translate([88-23,49/2-15,3]) rotate([0,0,0]) cylinder(d=3,h=100,$fn=12);
		//#translate([88-23,49/2+15,3]) rotate([0,0,0]) cylinder(d=3,h=100,$fn=12);

		hull()
		{
			translate([88-6-2.5,9+2,14-10]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
			translate([88-25,9+2,14-10]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
		}
		translate([88-6-2.5,9+2,-1]) rotate([0,0,0]) cylinder(d=3,h=30,$fn=12);
		
		hull()
		{
			translate([88-6-2.5,49-(9+2),14-10]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
			translate([88-25,49-(9+2),14-10]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
		}
		translate([88-6-2.5,49-(9+2),-1]) rotate([0,0,0]) cylinder(d=3,h=30,$fn=12);


		hull()
		{
			translate([88-43-3,9,14-8]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
			translate([88-43+25,9,14-8]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
		}
		translate([88-43-3,9,-1]) rotate([0,0,0]) cylinder(d=3,h=30,$fn=12);

		hull()
		{
			translate([88-43-3,49-(9),14-8]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
			translate([88-43+25,49-(9),14-8]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
		}
		translate([88-43-3,49-(9),-1]) rotate([0,0,0]) cylinder(d=3,h=30,$fn=12);

}
}
}

if( drawArray==[] || search(12,drawArray)!=[] )
{
	
	translate([-105,0,264])
	{
		if( drawMetall )
		{
			//Bearing608();
		}

	difference()
	{
		union()
		{
			translate([0,0,0]) rotate([0,0,0]) cylinder(d=Bearing608Diameter()+10,h=9,$fn=12);
			hull()
			{
				translate([0,-49/2+(9),0]) rotate([0,0,0]) cylinder(d=10,h=9,$fn=12);
				translate([0,49/2-(9),0]) rotate([0,0,0]) cylinder(d=10,h=9,$fn=12);
			}
			/*
			hull()
			{
				translate([0,-49/2+(9),0]) rotate([0,0,0]) cylinder(d=9,h=8,$fn=12);
				translate([0,49/2-(9),0]) rotate([0,0,0]) cylinder(d=9,h=8,$fn=12);
				translate([20,0,0]) rotate([0,0,0]) cylinder(d=3,h=8,$fn=12);
				translate([0,49/2-(9),0]) rotate([0,0,0]) cylinder(d=3,h=8,$fn=12);
			}
			*/
		}
		translate([0,0,0]) rotate([0,0,0]) cylinder(d=15,h=18,$fn=12);
		translate([0,0,0]) rotate([0,0,0]) cylinder(d=Bearing608Diameter()+1,h=Bearing608Height()+0.7,$fn=64);
		translate([0,-49/2+(9),0]) rotate([0,0,0]) cylinder(d=3,h=19,$fn=12);
		translate([0,49/2-(9),0]) rotate([0,0,0]) cylinder(d=3,h=19,$fn=12);
	}
}

}


// hot end
if( !printLayout && (drawArray==[] || drawHotEnd!=0) )
{
	translate ([xp,yp,part1ZBase+25])
	{
		rotate([180,0,0]) color("silver") heatsinkE3DV5(0,100);
	}
}

module ZStepper(bHolesOnly)
{
  translate([zStepperX,zStepperY,zStepperZ]) rotate([-90,0,0]) 
  {
    translate( [0,0,0]) Nema17_shaft24_Stepper(bHolesOnly);
		if( !bHolesOnly )
		{
			translate ([0,0,-1]) rotate([180,0,0]) Pulley16TeethAlu();
		}
  }
}

if( !printLayout && (drawArray==[] || drawSteppers) )
{
  // x stepper
  translate([xStepperX,xStepperY,xStepperZ])
  {
		if( drawSteppers )
			rotate([0,0,0]) Nema17_shaft22_Stepper(0,NemaSize);
    translate ([0,0,0]) rotate([180,0,0]) Pulley16TeethAlu();

		holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
		color("grey")
		{
			translate([-holeDist,-holeDist,-xStepperZ+90]) cylinder(r=1.51,h=40);
			translate([holeDist,-holeDist,-xStepperZ+90]) cylinder(r=1.51,h=40);
			translate([holeDist,holeDist,-xStepperZ+90]) cylinder(r=1.51,h=40);
		}
  }
  // y stepper
  translate([yStepperX,yStepperY,yStepperZ])
  {
		if( drawSteppers )
			rotate([0,180,0]) Nema17_shaft22_Stepper(0,NemaSize);
    translate ([0,0,2]) rotate([0,0,0]) Pulley16TeethAlu();
		
		holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
		color("grey")
		{
			translate([-holeDist,-holeDist,-yStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=50);
			translate([holeDist,-holeDist,-yStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=50);
			translate([-holeDist,holeDist,-yStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=50);
		}
  }
}

// bed
if( !printLayout && (drawArray==[] || drawBed) )
{
	translate([BedXOffset,BedYOffset,40]) color ([1,0.5,0.5,0.5]) cube([BedSizeX,BedSizeY,3]);
}

if( drawExtruder )
{
	translate([-95,0,300]) extruder();
}
