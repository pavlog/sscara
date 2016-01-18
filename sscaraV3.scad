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

//ex = 70;
//ey = 130;
// almost parralel
ex = -100;
ey = 170;
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
EndPointMountOffset = 0;
EndPointMountAngle = 0;
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
//drawArray = [1,4,5];//[1,2,3,4,5];//[1,7,8];
drawArray = [1,2,3,4,5,6];//[1,2,3,4,5];//[1,7,8];
// 1 - bottom big pulley (for m5 threaded rod) (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells,no supports)
// 2 - top big pulley (for alu 8mm rod) (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supprts)
// 3 - mount for 2nd pulley and outer axis (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, supports enabled)
// 4 - base for xy steppers (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supprts)
// 5 - steppers spacers (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 6 - rods supports mount and 608(bottom)  (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 7 - rods supports mount and 608(top)  (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 8 - rods fixators + z max end stopper  (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 9 - base for z stepper (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supprts)
// 10 - ramps1.4 bottom mounts (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, supports enabled)
// 11 - extruder  (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 12 - extruder bottom support  (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 13 - extruder top support and top 608 support
// 14 - z carret (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 15 - bed parts (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled) (1 full anddivided to 2 parts stls available)
// 16 - spacers to top panel 1st part (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 17 - spacers to top panel 2nd part (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 18 - spacers bottom arm  (40%-infill, 0.25-layer, 0.4-nozzle, perimeter - 3 shells, no supports enabled)
// 19 - bottom arm
// 20 - bottom second arm
// 21 - top arm
// 22 - top second arm
// 23 - upper bearing fixator
// 24 - extruder spacers
// 25 - far bottom spacer

// 300: Optional - bearing spacers for XY Steppers 
// 301: Optional - xy steppers shaft to bearings coupliers 

// more printer friedly layout (note: implemented not for all parts)
printLayout = 0;


drawSteppers = 1;
drawZSteppers = 0;
drawBelts = 0;
drawZBelts = 0;
drawSwitchesAll = 0;
drawBaseAllum = 0;
drawLCD = 0;
drawMetall = 0;
drawRamps = 0;
drawRods = 0;
drawBed = 1;
drawHotEnd = 0;
drawPowerButton = 0;
drawSpool = 0;



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
xStepperZ = 78+5+15;


yStepperX = -33;
yStepperY = 0;
yStepperRZ = 0;
yStepperZ = 41;
yStepperZPlane = 44;

part1ZBase = yStepperZPlane+3;
part2ZBase = part1ZBase+21+3;



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

if( !printLayout && drawSpool )
{
	difference()
	{
		translate([0,-65,125]) rotate([90,0,0]) cylinder(d=170,h=46);
		translate([0,-60,125]) rotate([90,0,0]) cylinder(d=53,h=70);
	}
}

// static const part
EX = EndPointMountOffset*cos(EndPointMountAngle)+Linkage_2;
EY = EndPointMountOffset*sin(EndPointMountAngle);
lHp2 = (EX)*(EX)+EY*EY;
lH = sqrt(lHp2);
dhalf = 0.0;
LH3 = Linkage_2/lH;
l2 = Linkage_1 * Linkage_1;
L2 = Linkage_2 * Linkage_2;
//echo(EX);
//echo(EY);
//echo(LH3);


l = Linkage_1;
L = Linkage_2;

//AA = -2 * l * (ex - dhalf);
BB = -2 * l * ey;
//CC = (ex - dhalf) * (ex - dhalf) + ey * ey + l2 - lHp2;
FF = (ex + dhalf) * (ex + dhalf) + ey * ey + l2 - lHp2;
EE = -2  * l * (ex+dhalf);
Det2e = BB * BB - (FF * FF - EE * EE);

qq21e = (-BB + sqrt(Det2e)) / (FF - EE);
q21e = 2 * atan(qq21e);

xxd = -dhalf + l * cos(q21e);
yyd = l * sin(q21e);

//echo(lH);
//echo(xxd);
//echo(yyd);
//color("red") translate([xxd,yyd,200]) cylinder(r=5,h=100);

K = EndPointMountOffset;
//echo("K");
//echo(K);
//echo(lH);
//echo(L);
//echo("dd-ee");
//echo(sqrt((ex-xxd)*(ex-xxd)+(ey-yyd)*(ey-yyd)));

cosa1 = (L*L+lH*lH-K*K)/(2*L*lH);
sina1 = sqrt(1-cosa1*cosa1);
rx = ex-xxd;
ry = ey-yyd;
x = (rx*cosa1+ry*sina1)*LH3+xxd;
y = (-rx*sina1+ry*cosa1)*LH3+yyd;

//x = 0;
//y = 60;// offset from axis to printed area

//echo("xy");
//echo(x);
//echo(y);

//color("red") translate([x,y,200]) cylinder(r=5,h=100);

/*
hull()
{
	cylinder(r=1,h=100);
	translate([xxd,yyd,0]) cylinder(r=1,h=100);
}
*/

A = -2 * l * (x - dhalf);
B = -2 * y * l;
C = (x - dhalf) * (x - dhalf) + y * y + l2 - L2;
F = (x + dhalf) * (x + dhalf) + y * y + l2 - L2;
E = -2  * l * (x+dhalf);
Det1 = B * B - (C * C - A * A);
Det2 = B * B - (F * F - E * E);

qq11 = (-B - sqrt(Det1)) / (C - A);
q11 = 2 * atan(qq11);
//qq12 = (-B + sqrt(Det1)) / (C - A);
//q12 = 2 * atan(qq12);

//qq21 = (-B - sqrt(Det2)) / (F - E);
//q21 = 2 * atan(qq21);
qq22 = (-B + sqrt(Det2)) / (F - E);
q22 = 2 * atan(qq22);

q22Pos = q22 < 0 ? 360+q22 : q22;

//echo("q22,q11");
//echo(q22Pos);
//echo(q11);

xd = -dhalf + l * cos(q22);
yd = l * sin(q22);

xb = -dhalf + l * cos(q11);
yb = l * sin(q11);

hx = xb-xd;
hy = yb-yd;
H = sqrt(hx*hx+hy*hy);
LH = L/H;
cosa = (H*H)/(2*L*H);
sina = -sqrt(1-cosa*cosa);
xxp = (hx*cosa+hy*sina)*LH+xd;
yyp = (-hx*sina+hy*cosa)*LH+yd;

cosz = cos(-EndPointMountAngle);
sinz = sin(-EndPointMountAngle);

//echo (cosz);

LH2 = EndPointMountOffset/L;
hhx = xxp-xd;
hhy = yyp-yd;
xp = (hhx*cosz+hhy*sinz)*LH2+xxp;
yp = (-hhx*sinz+hhy*cosz)*LH2+yyp;
//xp = xxp;
//yp = yyp;

//echo (hhx);
//echo (hhy);

//echo("hh");
//echo (xp);
//echo(yp);
//echo("LH2");
//echo (LH2);
//echo("xd,yd");
//echo (xd);
//echo(yd);
//color("green") translate([xp,yp,200]) cylinder(r=2,h=100);
//color("blue") translate([xxp,yyp,200]) cylinder(r=3,h=100);
//color("magenta") translate([xb,yb,200]) cylinder(r=1,h=100);
//color("silver") translate([ex,ey,200]) cylinder(r=3,h=100);
//color("magenta") translate([xd,yd,200]) cylinder(r=1,h=100);


WIP = 1;


module DCJack5p5()
{
	color("red") difference()
	{
		cylinder(d=8,h=20);
		cylinder(d=5.5,h=21);
	}
}

module PowerButton()
{
	color("green") cylinder(d=12,h=20);
	translate([-33/2,-15/2,-20]) cube([33,15,27]);
}

if( !printLayout && (drawArray==[] || drawPowerButton) )
{
	translate([-50,-40,102]) rotate([0,-90,0]) PowerButton();
}

//color("grey") translate([-60,-60,80]) rotate([0,-90,0])  cube([60,60,3]);

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

module part1Idler(bPrintLayout)
{
	if( bPrintLayout==1 )
	{
		intersection()
		{
			part1Idler_full();
			translate([0,-50,0]) cube([100,100,100]);
		}
	}
	else if( bPrintLayout==2 )
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
	//bPrintLayout = 1;
	rotAngle = bPrintLayout ? 0 : q11;
	translate([0,0,part1ZBase]) rotate([0,0,rotAngle]) 
	{
		if( bPrintLayout )
		{
			part1Idler(1);
			translate([-5,0,0]) part1Idler(2);
		}
		else
		{
			part1Idler();
		}
		pulleyOffsX = bPrintLayout ? -5 : 0;
		pulleyOffsY = bPrintLayout ? 45 : 0;
		pulleyOffsZ = bPrintLayout ? 0 : 7;
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
		topIdlerOffsetZ = bPrintLayout ? 0 : 14;
		translate([0,0,topIdlerOffsetZ])
		{
		if( bPrintLayout )
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
	xd = dhalf + l * cos(q11);
  yd = l * sin(q11);
	a = printLayout ? 0 : atan((y-yd)/(x-xd));

	rotAngle = bPrintLayout ? 0 : a;
	translate([0,0,part2ZBase]) rotate([0,0,rotAngle]) 
	{
		if( bPrintLayout )
		{
			part1Idler(1);
			translate([-5,0,0]) part1Idler(2);
		}
		else
		{
			part1Idler();
		}
		pulleyOffsX = bPrintLayout ? -5 : 0;
		pulleyOffsY = bPrintLayout ? 45 : 0;
		pulleyOffsZ = bPrintLayout ? 0 : 7;
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
		topIdlerOffsetZ = bPrintLayout ? 0 : 14;
		translate([0,0,topIdlerOffsetZ])
		{
		if( bPrintLayout )
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
  xd = dhalf + l * cos(q11);
  yd = l * sin(q11);
	a = printLayout ? 0 : atan((y-yd)/(x-xd));
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
			xd = dhalf + l * cos(q11);
			yd = l * sin(q11);
			a = printLayout ? 0 : atan((y-yd)/(x-xd));
			a2 = printLayout ? 0 : atan2(yd,xd);
			rotAngle = printLayout ? 0 : a;
			rotAngle2 = printLayout ? 0 : -rotAngle+a2;
			hull()
			{
				rotAngle = bPrintLayout ? 0 : a;
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
	xd = dhalf + l * cos(q11);
  yd = l * sin(q11);
	a = printLayout ? 0 : atan((y-yd)/(x-xd));
	a2 = printLayout ? 0 : atan2(yd,xd);
	
	/*
	hull()
	{
		rotAngle = bPrintLayout ? 0 : a;
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
		xd = dhalf + l * cos(q11);
		yd = l * sin(q11);
		a = printLayout ? 0 : atan((y-yd)/(x-xd));
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
		xd = dhalf + l * cos(q11);
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
			translate([yStepperX,yStepperY,yStepperZPlane-5]) cylinder(d=23,h=2);
			translate([yStepperX-3,yStepperY,yStepperZPlane-5]) cylinder(d=23,h=2);
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
		translate([-30,11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4,h=50,$fn=12);
		translate([-10,11,yStepperZPlane-7.5]) rotate([0,90,0])rotate([0,0,30]) cylinder(d=rolson_hex_nut_dia(4),h=rolson_hex_nut_hi(4),$fn=6);
		translate([-30,-11,yStepperZPlane-7.5]) rotate([0,90,0]) cylinder(d=4,h=50,$fn=12);
		translate([-10,-11,yStepperZPlane-7.5]) rotate([0,90,0])rotate([0,0,30]) cylinder(d=rolson_hex_nut_dia(4),h=rolson_hex_nut_hi(4),$fn=6);
	}
	
}

if( drawArray==[] || search(6,drawArray)!=[] )
{
	//printLayout = 1;
	// subpart 1
	part6(printLayout);
	// subpart 2
	translate([0,0,139]) mirror([0,0,1]) part6(printLayout);
	
	color("blue") translate([-60,-20,yStepperZPlane]) cube([10,10,51]);

	color("green") translate([-60,-sideSize/2-3,yStepperZPlane]) cube([16,sideSize+6,5]);

}


pulley2FixatorZ = pulley2Z+pulleysH; 
part5SpacerH = Nema17Len+(xStepperZ-15+3.5)+2+2;
part6Z = part5SpacerH+15-1.5;


//translate([0,0,part6Z]) cylinder(r=100,h=1);

if( !printLayout && (drawArray==[] || drawMetall) ) 
{
	// bearing
	translate ([0,0,pulley2FixatorZ]) color( "Silver") hex_nut(5);
}


BaseGearboxThreadedRodsX1 = -55.5;
BaseGearboxThreadedRodsY1 = -59;
BaseGearboxThreadedRodsX2 = 55.5;
BaseGearboxThreadedRodsY2 = -59;
BaseGearboxThreadedRodsX3 = -55.5;
BaseGearboxThreadedRodsY3 = 0;
BaseGearboxThreadedRodsX4 = 55.5;
BaseGearboxThreadedRodsY4 = 0;
BaseGearboxThreadedRodsH = 285;// cut 290 initially
module BaseGearboxThreadedRods()
{
	color("silver") 
	{
		translate([BaseGearboxThreadedRodsX1,BaseGearboxThreadedRodsY1,-5]) rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=BaseGearboxThreadedRodsH,$fn=16);
		translate([BaseGearboxThreadedRodsX2,BaseGearboxThreadedRodsY2,-5])  rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=BaseGearboxThreadedRodsH,$fn=16);
		//
		translate([BaseGearboxThreadedRodsX3,BaseGearboxThreadedRodsY3,-5]) rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=BaseGearboxThreadedRodsH,$fn=16);
		translate([BaseGearboxThreadedRodsX4,BaseGearboxThreadedRodsY4,-5])  rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=BaseGearboxThreadedRodsH,$fn=16);
	}
}

// m3 threaded rods
if( !printLayout && (drawArray==[] || drawMetall) )
{
	BaseGearboxThreadedRods();
}

m3PlatesRad = rolson_hex_nut_dia(3)/2+0.9;

module switchXMount()
{
			translate([-alumXOffset+4.5-3,switchX_oy,15-1.5]) 
        color("blue") rotate([0,0,0]) scale([1,1,1])
          cube([3.5+3,20,19]);
}


if( drawArray==[] || search(300,drawArray)!=[] )
{
		translate([xStepperX+printLayout ? 10 : 0,xStepperY,4]) color("grey")
		{
			difference()
			{
				translate([0,0,0]) cylinder(d=Bearing625Diameter(),h=1);
				translate([0,0,-1]) cylinder(d=5+5,h=3);
			}
		}
		translate([yStepperX+printLayout ? -10 : 0,yStepperY,4]) color("grey")
		{
			difference()
			{
				translate([0,0,0]) cylinder(d=Bearing625Diameter(),h=1);
				translate([0,0,-1]) cylinder(d=5+5,h=3);
			}
		}
}

if( drawArray==[] || search(301,drawArray)!=[] )
{
		translate([xStepperX+printLayout ? 8 : 0,xStepperY,9]) rotate([printLayout ? 180 : 0,0,0]) color("grey")
		{
			difference()
			{
				union()
				{
					translate([0,0,0]) cylinder(d=Bearing625Diameter()-5,h=4,$fn=32);
					translate([0,0,-4]) cylinder(d=5-0.1,h=5,$fn=64);
				}
				translate([0,0,2]) cylinder(d=5,h=10,$fn=32);
			}
		}
		translate([yStepperX+printLayout ? -8 : 0,yStepperY,9]) rotate([printLayout ? 180 : 0,0,0]) color("grey")
		{
			difference()
			{
				union()
				{
					translate([0,0,0]) cylinder(d=Bearing625Diameter()-5,h=4,$fn=32);
					translate([0,0,-4]) cylinder(d=5-0.1,h=5,$fn=64);
				}
				translate([0,0,2]) cylinder(d=5,h=10,$fn=32);
			}
		}
}



// bearing mount steppersspacers
if( drawArray==[] || search(25,drawArray)!=[] )
{
	h = spacersH2/2;
	//echo ("hh");
	//echo(h);
	//
	//printLayout = 0;
	//
	spacersDistMultX = printLayout ? 1 : 1;
	spacersDistMultY = printLayout ? 0.55 : 1;
	spacersDistMultX2 = printLayout ? -80 : 1;
	spacersRot = printLayout ? 0 : 0;
	spacersRot2 = printLayout ? 0 : 0;
	offX2 = printLayout ? 0 : 0;
	offY2 = printLayout ? 0 : 0;

	off2 = printLayout ? 0 : 0;
	//
	mountOffsetR = printLayout ? 0 : 0;
	mountOffsetRZ = printLayout ? 0 : 0;
	//
	//
	difference()
	{
		color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX3*spacersDistMultX,99,15-1.5]) rotate([0,mountOffsetR,-90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=4);
		translate([LCDX,LCDY,LCDZ]) LCD20x4SmartController(1);
	}
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX4*spacersDistMultX+spacersDistMultX2,99,15-1.5]) rotate([0,mountOffsetR,180+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=5);
}



if( !printLayout && (drawArray==[] || drawMetall) )
{
	translate ([0,0,part6Z+1]) Bearing608(); 
}

module SCS6UUAll(bHolesOnly=0)
{
	translate([-rodOffsetX,0,part6Z+10+z]) rotate([90,0,0]) SCS6UU(bHolesOnly);
	translate([rodOffsetX,0,part6Z+10+z]) rotate([90,0,0]) SCS6UU(bHolesOnly);

	translate([-rodOffsetX,0,part6Z+36+z]) rotate([90,0,0]) SCS6UU(bHolesOnly);
	translate([rodOffsetX,0,part6Z+36+z]) rotate([90,0,0]) SCS6UU(bHolesOnly);
}

if( !printLayout && drawMetall )
{
	SCS6UUAll(0);
}

plateH = 4;
plateHCover = (Bearing608Height()+2)-plateH;

part7EndZ = part6Z+plateH+plateHCover;

// 608 bearing support up
if( drawArray==[] || search(7,drawArray)!=[] )
{
	h = part5SpacerH;

	plateOffset = printLayout ? 0 : 0;
	plateRot = printLayout ? 180 : 0;
	

	translate([0,plateOffset,0]) rotate([plateRot,0,0])
	{
		difference()
		{
			color("green") p5_plate(plateH,plateHCover);
			//
			p5_plate_holes(h);
		}
	}
}

module ZRods()
{
	translate([rodOffsetX,rodOffsetY/*+20*/,part6Z]) color ("silver") cylinder(r=3,h=200,$fn=32);

	translate([-rodOffsetX,rodOffsetY,part6Z]) color ("silver") cylinder(r=3,h=200,$fn=32);
}

// rods
if( !printLayout && (drawArray==[] || drawRods) )
{	
	ZRods();
}

module rodsFixator()
{
	difference()
	{
		color ("green") hull()
		{
			translate([rodOffsetX,rodOffsetY/*+20*/,part6Z-10]) cylinder(d=6+6,h=10);
			translate([rodOffsetX+11,rodOffsetY/*+20*/,part6Z-10]) cylinder(d=6+6,h=10);
			translate([rodOffsetX-15,rodOffsetY/*+20*/,part6Z-10]) cylinder(d=6+6,h=10);
			translate([rodOffsetX,rodOffsetY-8/*+20*/,part6Z-10]) cylinder(d=6+6,h=10);
			//translate([rodOffsetX+11,rodOffsetY-6.5/*+20*/,part6Z-10]) cylinder(d=6+6,h=10);
			//translate([rodOffsetX-15,rodOffsetY-7,part6Z-10]) cylinder(d=6+6,h=10);
		}
		p5_plate_holes(50);
	}
}

module ZMaxEndStopper(holesOnly=0)
{
	translate([0,0,part6Z]) 
	{
			translate([-39.5,10,5]) rotate([-90,0,0]) EndSwitchBody20x11(holesOnly);
	}
}

module part8()
{
  printOffset = printLayout ? -10 : 0;
	translate([printOffset,0,0]) rodsFixator();
	difference()
	{
		union()
		{
			mirror() rodsFixator();
			hull()
			{
				hull()
				{
					translate([-rodOffsetX+8,7.9+0.5,part6Z-10]) cylinder(r=2,h=10,$fn=32);
					translate([-rodOffsetX+9,5,part6Z-10]) cylinder(r=2,h=10,$fn=32);
				}
				translate([-rodOffsetX-8,7.9+0.5,part6Z-10]) cylinder(r=2,h=10,$fn=32);
			}
			hull()
			{
				translate([-rodOffsetX-8,7.9+0.5,part6Z-10]) cylinder(r=2,h=10,$fn=32);
				translate([-rodOffsetX-8,1,part6Z-10]) cylinder(r=2,h=10,$fn=32);
				translate([-rodOffsetX,7.9,part6Z-10]) cylinder(r=2,h=10,$fn=32);
			}
		}
		ZMaxEndStopper(1);
		translate([0,0,part6Z]) 
		{
				translate([-34.5,6,-2]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3));
				translate([-25.5,6,-2]) rotate([-90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=rolson_hex_nut_hi(3));
		}
	}
}
// rods fixators and z max endstopper mount
if( drawArray==[] || search(8,drawArray)!=[] )
{
	part8();
}

// z max end stopper
if( !printLayout && (drawArray==[] || drawSwitchesAll==1) )
{
	ZMaxEndStopper();
}

zStepperX = 5;
zStepperY = 33;
zStepperZ = 57;
nemaH = lookup(NemaRoundExtrusionDiameter, Nema17);
ZStepperBottomZ = zStepperZ-nemaH-3;

module StepperCoverHoles()
{
				nemaH = lookup(NemaRoundExtrusionDiameter, Nema17);
			translate([-nemaH-6,45,zStepperZ-nemaH/1.35]) rotate([90,0,0]) cylinder(d=3,h=50,$fn=32);
			mirror() translate([-nemaH-6,45,zStepperZ-nemaH/1.35]) rotate([90,0,0]) cylinder(d=3,h=50,$fn=32);
			translate([-nemaH-6,45,zStepperZ+nemaH/1.35]) rotate([90,0,0]) cylinder(d=3,h=50,$fn=32);
			mirror() translate([-nemaH-6,45,zStepperZ+nemaH/1.35]) rotate([90,0,0]) cylinder(d=3,h=50,$fn=32);
			translate([0,40,zStepperZ]) color("red") rotate([90,0,0]) cylinder(r=11,h=10,$fn=16);
}

module ZStepperMountHoles(isNuts)
{
	d = isNuts ? rolson_hex_nut_dia(3)+1 : 3;
	ns = isNuts ? 6 : 32;
	h = isNuts ? rolson_hex_nut_hi(3)+2 : 60;
	translate([zStepperX-22,zStepperY+33,-9])color("red") rotate([0,0,90]) cylinder(d=d,h=h,$fn=ns);
	translate([zStepperX-22,zStepperY+22,-9])color("red") rotate([0,0,90]) cylinder(d=d,h=h,$fn=ns);
	translate([zStepperX+22,zStepperY+33,-9])color("red") rotate([0,0,90]) cylinder(d=d,h=h,$fn=ns);
	translate([zStepperX+22,zStepperY+22,-9])color("red") rotate([0,0,90]) cylinder(d=d,h=h,$fn=ns);
}

module zStepperLMount()
{
	difference()
	{
		union()
		{
			translate([zStepperX-26.5,31,zStepperZ-nemaH]) cube([53,4,nemaH*2-2]);
			color ("lightblue") translate([zStepperX-25,31,ZStepperBottomZ]) cube([50,41,4]);
			hull()
			{
				color ("green") translate([zStepperX-26.5,zStepperY+14+20,ZStepperBottomZ]) cube([5.25,5,13]);
				color ("green") translate([zStepperX-26.5,31,ZStepperBottomZ]) cube([5.25,4,40]);
			}
			translate() hull()
			{
				color ("green") translate([-(zStepperX-31.25),zStepperY+14+20,ZStepperBottomZ]) cube([5.25,5,13]);
				color ("green") translate([-(zStepperX-31.25),31,ZStepperBottomZ]) cube([5.25,4,40]);
			}
		}
		// mount holes
		ZStepper(1);
		//
		translate([0,0,-7]) ZStepperMountHoles();
		translate([0,0,45]) ZStepperMountHoles(1);
		//
		translate([zStepperX,zStepperY+5,zStepperZ]) rotate([90,0,0]) cylinder(d=23,h=20);
	}
}
// base for z stepper
module part9()
{
	//redesign me to L bracket and base
	//printLayout = 1;
	extraD = 6;
	//
	//color ("blue") 
	intersection()
	{
		difference()
		{
			union()
			{
				color ("blue") translate([-alumXOffset+1.5,37,0]) cube([alumXOffset*2-1.5*2,60+extraD,4]);
				/*
				hull()
				{
					color ("magenta") translate([-32,37,0]) cube([10.5,15,75]);
					color ("magenta") translate([-50,37,0]) cube([10.5,15,20]);
				}
				mirror() hull()
				{
					color ("magenta") translate([-32,37,0]) cube([10.5,15,75]);
					color ("magenta") translate([-50,37,0]) cube([10.5,15,20]);
				}
				*/
				//color ("magenta") translate([-26,37,0]) cube([52,5,zStepperZ-nemaH+1]);

				color ("green") translate([zStepperX-25,37,0]) cube([50,35,zStepperZ-nemaH-3]);

				//color ("green") translate([zStepperX-25,39,0]) cube([3,10,75]);
				//color ("green") translate([zStepperX-25,39,0]) cube([3,10,75]);

				//color ("green") translate([-24.3,65,24]) rotate([30,0,0]) cube([3,5,45]);
				//color ("green") mirror() translate([-24.3,65,24]) rotate([30,0,0]) cube([3,5,45]);
				// corners
				translate([-alumXOffset+4.5,93+extraD,3]) 
					color("green") rotate([0,0,0]) scale([1,1,1])
						cylinder(r=m3PlatesRad,h=10.5);
				mirror() translate([-alumXOffset+4.5,93+extraD,3]) 
					color("green") rotate([0,0,0]) scale([1,1,1])
						cylinder(r=m3PlatesRad,h=10.5);
				// near corders
				translate([-alumXOffset+4.5,42,3]) 
					color("green") rotate([0,0,0]) scale([1,1,1])
						cylinder(r=m3PlatesRad,h=10.5);
				mirror() translate([-alumXOffset+4.5,42,3]) 
					color("green") rotate([0,0,0]) scale([1,1,1])
						cylinder(r=m3PlatesRad,h=10.5);
				// border
				translate([-alumXOffset+1.5,93.5+extraD,3]) 
					color("red") rotate([0,0,0]) scale([1,1,1])
						cube([alumXOffset*2-1.5*2,3.5,10.5]);
				// borders near
				translate([-alumXOffset+1.5,36,3]) 
					color("red") rotate([0,0,0]) scale([1,1,1])
						cube([alumXOffset*2-1.5*2,3.5,4]);
				translate([-alumXOffset+1.5,36,3]) 
					color("green") rotate([0,0,0]) scale([1,1,1])
						cube([21-1.5*2,4,10.5]);
				mirror() translate([-alumXOffset+1.5,36,3]) 
					color("green") rotate([0,0,0]) scale([1,1,1])
						cube([21-1.5*2,4,10.5]);
				// left right borders
				translate([-alumXOffset+1.5,36,3]) 
					color("red") rotate([0,0,0]) scale([1,1,1])
						cube([3.5,60,10.5]);
				mirror() translate([-alumXOffset+1.5,36,3]) 
					color("red") rotate([0,0,0]) scale([1,1,1])
						cube([3.5,60,10.5]);
				//
				color("green") hull()
				{
					//translate([-alumXOffset+3,33,0]) cylinder(r=2,h=5);
					translate([20,36,0]) cylinder(r=2,h=5);
					translate([alumXOffset-3,90,0]) cylinder(r=2,h=5);
				}
				mirror() color("green") hull()
				{
					//translate([-alumXOffset+3,33,0]) cylinder(r=2,h=5);
					translate([20,36,0]) cylinder(r=2,h=5);
					translate([alumXOffset-3,90,0]) cylinder(r=2,h=5);
				}
				color("green") hull()
				{
					//translate([-alumXOffset+3,33,0]) cylinder(r=2,h=5);
					translate([alumXOffset-3,36,0]) cylinder(r=2,h=5);
					translate([0,99,0]) cylinder(r=2,h=5);
				}
				mirror() color("green") hull()
				{
					//translate([-alumXOffset+3,33,0]) cylinder(r=2,h=5);
					translate([alumXOffset-3,36,0]) cylinder(r=2,h=5);
					translate([0,99,0]) cylinder(r=2,h=5);
				}
				// lcd mount
				//translate([-alumXOffset+1.5,88,0]) 
				//	color("blue") rotate([0,0,0]) scale([1,1,1])
				//		cube([3.5,7,21]);

 			}
			translate([zStepperX,62,-0.2]) color("red") scale([1.4,1,1])cylinder(r=9.5,h=100,$fn=6);
			StepperCoverHoles();
			// base alum
			BaseAllum();
			//
			translate([-alumXOffset+12,50,9]) 
				color("green") rotate([90,0,0]) scale([1,1,1])
					cylinder(d=3,h=50,$fn=32);
			mirror() translate([-alumXOffset+12,50,9]) 
				color("green") rotate([90,0,0]) scale([1,1,1])
					cylinder(d=3,h=50,$fn=32);
			// corners
			translate([-alumXOffset+4.5,93+extraD,-3]) 
				color("green") rotate([0,0,0]) scale([1,1,1])
					cylinder(r=1.5,h=20.5,$fn=32);
			mirror() translate([-alumXOffset+4.5,93+extraD,-3]) 
				color("green") rotate([0,0,0]) scale([1,1,1])
					cylinder(r=1.5,h=20.5,$fn=32);
			// near corners
			translate([-alumXOffset+4.5,42,-3]) 
				color("green") rotate([0,0,0]) scale([1,1,1])
					cylinder(r=1.5,h=20.5,$fn=32);
			mirror() translate([-alumXOffset+4.5,42,-3]) 
				color("green") rotate([0,0,0]) scale([1,1,1])
					cylinder(r=1.5,h=20.5,$fn=32);
			// far holes
			translate([-alumXOffset+12,110,9]) 
				color("green") rotate([90,0,0]) scale([1,1,1])
					cylinder(d=3,h=50,$fn=32);
			mirror() translate([-alumXOffset+12,110,9]) 
				color("green") rotate([90,0,0]) scale([1,1,1])
					cylinder(d=3,h=50,$fn=32);
			translate([0,110,9]) 
				color("green") rotate([90,0,0]) scale([1,1,1])
					cylinder(d=3,h=50,$fn=32);
			// side mounts
			translate([-alumXOffset-10,65,8]) 
				color("green") rotate([0,90,0]) scale([1,1,1])
					cylinder(d=3,h=20,$fn=32);
			mirror() translate([-alumXOffset-10,65,8]) 
				color("green") rotate([0,90,0]) scale([1,1,1])
					cylinder(d=3,h=20,$fn=32);
			//
			translate([-alumXOffset+27,85,-9]) 
				color("green") rotate([0,0,0]) scale([1,1,1])
					cylinder(d=18,h=50,$fn=6);
			mirror() translate([-alumXOffset+27,85,-9]) 
				color("green") rotate([0,0,0]) scale([1,1,1])
					cylinder(d=18,h=50,$fn=6);
			// lcd mounts
			//translate([LCDX,LCDY,LCDZ]) LCD20x4SmartController(1);	
			//
			translate([0,0,6]) cylinder(d=ArmPulleyDia+12+11,h=32-6,$fn=180);
			//
			ZStepperMountHoles();
		}
		color ("blue") translate([-alumXOffset+1.5,37,0]) cube([alumXOffset*2-1.5*2,60+extraD,150]);
	}
	//printLayout = 0; 
	if( printLayout==0 )
	{
			zStepperLMount();
	}
	else
	{
		//translate([5,65,-ZStepperBottomZ]) rotate([0,0,180]) zStepperLMount();

		translate([28,66,21.5]) rotate([0,-90,90]) 
		intersection()
		{
			zStepperLMount();
			//#translate([zStepperX-25,31,zStepperZ-nemaH]) cube([50,4,nemaH*2-2]);
			color ("lightblue") translate([zStepperX-26.5,31,zStepperZ-nemaH-5]) cube([53/2,41,150]);
		}
		mirror() translate([28,66,21.5]) rotate([0,-90,90]) 
		intersection()
		{
			zStepperLMount();
			//#translate([zStepperX-25,31,zStepperZ-nemaH]) cube([50,4,nemaH*2-2]);
			color ("lightblue") translate([zStepperX-26.5,31,zStepperZ-nemaH-5]) cube([53/2,41,150]);
		}
	}
}

if( drawArray==[] || search(9,drawArray)!=[] )
{
	part9();
	//part1();
	//part2();
	//ZStepper();
}


// ramps bottom mounts
if( drawArray==[] || search(10,drawArray)!=[] )
{
	 rotate([0,0,0])
	{
		difference()
		{
			translate([0,0,part7EndZ]) union()
			{
				translate([-15.5,-11,0]) cube([8,8,4]);
				translate([-23,-19,0]) cube([68,8,4]);
				translate([-10,-15,0]) rotate([0,0,-10]) cube([23,8,4]);
				translate([-20,-16,0]) rotate([0,0,30]) cube([10,5,4]);
				color("blue") translate([RampsX-32,-12.5,0]) cube([6,3,40]);
				color("blue") translate([RampsX+16.5,-12.5,0]) cube([6,3,38]);
			}
			p5_plate_holes(50);
			color("red") translate([RampsX-29,0,part7EndZ+36]) rotate([90,0,0]) cylinder(d=3,h=200,$fn=32);
			color("red") translate([RampsX+19.5,0,part7EndZ+34.5]) rotate([90,0,0]) cylinder(d=3,h=200,$fn=32);
		}
	}
}


part6_to_12ZOffset = 190;

module ExtruderStepperPanel()
{
					hull()
				{
					translate([-14,-14,0]) cylinder(r=7.5,h=4);
					translate([14,-14,0]) cylinder(r=7.5,h=4);
					translate([14,14,0]) cylinder(r=7.5,h=4);
					translate([-14,14,0]) cylinder(r=7.5,h=4);
					//translate([24.5+extrudeMountZOffset,9,0]) cylinder(r=7.5,h=4);
				}

}

// extruder
if( drawArray==[] || search(11,drawArray)!=[] )
{
	//printLayout = 1;
	aY = printLayout ? 0 : 70+90;
	aYY = printLayout ? 180 : -90;
	armX = printLayout ? 12 :0;
	armY = printLayout ? -38 : 0;
	armZ = printLayout ? -24.75 : 0;
	armRZ = printLayout ? 196.69 : 0;
	armRX = printLayout ? 90 : 0;
	armTX = printLayout ? 10 : 0;
	translate ([0,-37,223+armsExtruderExtra]) rotate([0,aYY,180]) rotate([0,0,aY]) mirror()//rotate([90,0,0]) 
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
				color ("red")  translate([gearRadToTeethEnd-1,-12,-armH]) cube([11+3,14,armH]);
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
						translate([15.5,-4.5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) cylinder(d=8,h=armH+4);
						translate([20.5,-6.5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3]) rotate([0,0,25])  cylinder(d=8,h=armH+4,$fn=4);
					}
					color("blue") translate([25,-4.5-gearRadToTeethEnd-Bearing623Diameter()/2-fillamentD/2,partsOffset+3+4-13]) rotate([0,0,90+70])  cube([5,6.5,23]);
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
			translate([0,0,-7]) difference()
			{
				union()
				{
					color( "green") hull()
					{
						color( "green") translate([-15.5,15.5,6]) cylinder(d=11+1,h=5);
						color( "green") rotate([0,0,-20]) translate([-26,3,6]) cube([5,13,5]);
					}
					color( "green") rotate([0,0,-20]) translate([-26,3,-5]) cube([3,13,15]);
				}
				// mount hole
				color( "green") translate([-15.5,15.5,-3]) cylinder(d=3,h=armH+5,$fn=32);
				//
				color( "magenta") translate([-15.5,15.5,0]) rotate([0,90,90+70])  cylinder(d=3,h=100,$fn=16);
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
						color( "green") translate([15.5,15.5,5]) cylinder(d=11+1,h=11);
						color( "green") rotate([0,0,-20]) translate([15.5+3+5,15.5-3,5]) cube([5,13,10]);
					}
					color( "red") rotate([0,0,-20]) translate([15.5+8.1,15.5-3,-5]) cube([5,13,30]);
					color( "red") rotate([90,0,-20]) translate([15.5+8.1,15.5-7,-25.5]) cylinder(r=5,h=13);
					color( "red") rotate([90,0,-20]) translate([15.5+8.1,15.5-4,-25.5]) cylinder(r=5,h=13);
				}
				// mount hole
				color( "green") translate([15.5,15.5,-3]) cylinder(d=3,h=armH+5,$fn=32);
				color( "green") translate([15.5,15.5,-6]) cylinder(d=9,h=10,$fn=32);
				translate([0,0,10]) scale([1.01,1.01,1.5]) ExtruderStepperPanel();
				//
				color( "magenta") translate([15.5,15.5,0]) rotate([0,90,90+70+180])  cylinder(d=3,h=100,$fn=16);
				color( "magenta") translate([15.5,15.5,20]) rotate([0,90,90+70+180])  cylinder(d=3,h=100,$fn=16);
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

part12Z = part6Z+part6_to_12ZOffset-56;
part12H = 3;
//translate([0,0,part12Z]) cylinder(r=100,h=1);

// ramps 1.4 top supprt
if( drawArray==[] || search(12,drawArray)!=[] )
{
	//printLayout = 0;
	//ramps();
	h = part12H;
	rotate([printLayout ? 180 : 0,0,0])
	difference()
	{
		union()
		{
			p5_plate(part6_to_12ZOffset-56,h);
			color("blue") translate([RampsX+16.5-1,-12.5,part6_to_12ZOffset+8]) cube([8,3,15]);
			color("blue") translate([RampsX+16.5-1,-12.5-3,part6_to_12ZOffset+18]) cube([8,3,5]);
		}
		//
		//translate([0,0,90]) p5_plate_holes(h);
		translate([0,0,90]) p5_plate_side_holes(h);//p5_plate_holes(h);
		translate([0,0,90]) p5_plate_leftright_holes(h);//p5_plate_holes(h);
		minkowski()
		{
			translate([-45,-85,part6_to_12ZOffset+15+3.5]) cube([90,50,5]);
			sphere(r=2);
		}
		minkowski()
		{
			translate([-45,-7.7,part6_to_12ZOffset+15+3.5]) cube([90,50,5]);
			sphere(r=2);
		}
		
		color("red") translate([RampsX+19.5,0,part6_to_12ZOffset+12.1]) rotate([90,0,0]) cylinder(d=3,h=50,$fn=32);
		// extruder mount
		color( "magenta") translate([-10,-28,part6_to_12ZOffset]) rotate([0,0,0])  cylinder(d=3,h=30,$fn=16);
	}
	//add holes to extruder munt

}



part13H = Bearing608Height()+1;
part13ZTop = part6Z+part6_to_12ZOffset+part13H;
part13Z = part6Z+part6_to_12ZOffset;
// top 608 bearing support bottom
if( drawArray==[] || search(13,drawArray)!=[] )
{
	plateH = part13H;
	difference()
	{
		union()
		{
			hull()
			{
				p5_plate(part6_to_12ZOffset,plateH);
				translate([-zStepperX,18,part6Z+part6_to_12ZOffset]) rotate([0,0,45]) cylinder(d=25,h=plateH,$fn=4);
				translate([zStepperX,18,part6Z+part6_to_12ZOffset]) rotate([0,0,45]) cylinder(d=25,h=plateH,$fn=4);
			}
			hull()
			{
				translate([zStepperX,0,part6Z+part6_to_12ZOffset]) cylinder(d=35,h=plateH,$fn=32);
				translate([zStepperX,18,part6Z+part6_to_12ZOffset]) rotate([0,0,45]) cylinder(d=25,h=plateH,$fn=4);
			}
		}
		translate([zStepperX,24.5,part6Z+part6_to_12ZOffset+plateH/2]) rotate([90,0,0]) cylinder(d=12+4,h=9,$fn=32);
		translate([zStepperX,34.5,part6Z+part6_to_12ZOffset+plateH/2]) rotate([90,0,0]) cylinder(d=3,h=26,$fn=32);
		translate([zStepperX,13,part6Z+part6_to_12ZOffset+plateH/2]) rotate([90,0,0]) cylinder(d=6,h=6,$fn=32);
		//
		//p5_plate_holes(h);
		BaseGearboxThreadedRods();
		//
		ZRods();
		// extruder mount
		color( "magenta") translate([-13,-17.2,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "magenta") translate([7,-17.2,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "magenta") translate([-18,-46.3,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		// fillament hole
		hull()
		{
			color( "magenta") translate([-8,-31,part6_to_12ZOffset+60]) cylinder(d=13,h=30,$fn=16);
			color( "magenta") translate([+8,-31,part6_to_12ZOffset+60]) cylinder(d=13,h=30,$fn=16);
			color( "magenta") translate([0,-35,part6_to_12ZOffset+60]) cylinder(d=30,h=30,$fn=6);
		}
		// fillament hole
		color( "magenta") translate([0,0,part6_to_12ZOffset+part6Z+1]) cylinder(d=Bearing608Diameter()+b608Clearance,h=30,$fn=16);
		color( "magenta") translate([0,0,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+5,h=30,$fn=16);
		//
		//color( "magenta") translate([-19,12,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+3,h=30,$fn=6);
		//color( "magenta") translate([19,12,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+3,h=30,$fn=6);
		//
		color( "green") translate([-47,-12,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+5,h=30,$fn=6);
		color( "green") translate([47,-12,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+5,h=30,$fn=6);
		//
		color( "green") translate([-22,-12,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+5,h=30,$fn=6);
		color( "green") translate([22,-12,part6_to_12ZOffset+part6Z-1]) cylinder(d=8+5,h=30,$fn=6);
		//
		translate([0,0,part6_to_12ZOffset]) p5_plate_back_holes(plateH);
		translate([0,0,part6_to_12ZOffset]) part5_plate_big_holes(plateH,1);
		translate([0,0,part6_to_12ZOffset]) part5_plate_horz_holes(plateH);
		// rods covers holes
		color( "magenta") translate([-19,-0,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "magenta") translate([19,-0,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "magenta") translate([-41,-0,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "magenta") translate([19,-0,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "magenta") translate([41,-0,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		//
		color( "blue") translate([-32,11,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "blue") translate([32,11,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "blue") translate([-18,18,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
		color( "blue") translate([18,18,part6_to_12ZOffset+60]) cylinder(d=3,h=30,$fn=16);
	}
}

	part25z = part12Z+part12H;

// spacers extruder
if( drawArray==[] || search(24,drawArray)!=[] )
{
	
	h = part13Z-part25z;
	//echo ("hh");
	//echo(h);
	//
	//printLayout = 1;
	//
	spacersDistMultX = printLayout ? 0.31 : 1;
	spacersDistMultY = printLayout ? 0.55 : 1;
	spacersRot = printLayout ? 0 : 0;
	spacersRot2 = printLayout ? 90 : 0;
	offX2 = printLayout ? 0 : 0;
	offY2 = printLayout ? 10 : 0;

	off2 = printLayout ? 44 : 0;
	
	mountH = 15;
	mountOffsetZ = printLayout ? mountH : 0;
	mountOffsetZ2 = printLayout ? (h+h+mountH-3) : 0;
	//
	mountOffsetR = printLayout ? 180 : 0;
	mountOffsetRZ = printLayout ? -90 : 0;
	//
	//
	//intersection()
	//{
	//	union()
	//	{
	
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX1*spacersDistMultX,BaseGearboxThreadedRodsY1*spacersDistMultY,part25z]) rotate([0,mountOffsetR,0+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=1);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX2*spacersDistMultX,BaseGearboxThreadedRodsY2*spacersDistMultY,part25z]) rotate([0,mountOffsetR,90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=1);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX3*spacersDistMultX,BaseGearboxThreadedRodsY3*spacersDistMultY,part25z]) rotate([0,mountOffsetR,-90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=4);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX4*spacersDistMultX,BaseGearboxThreadedRodsY4*spacersDistMultY,part25z]) rotate([0,mountOffsetR,180+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=5);
	//	}
	//	translate([-50,-50,part7EndZ+h]) rotate([0,mountOffsetR,0+mountOffsetRZ])  cube([100,100,h-44.5]);
	//}
}


if( !printLayout && (drawArray==[] || drawMetall) )
{
		translate ([zStepperX,20,part6_to_12ZOffset+part6Z+4]) rotate([90,0,0])
		{		
				Bearing623(); 
				translate ([0,0,-4])Bearing623(); 
			}
}


module BeltTensionerHoles()
{
	translate([4.5,-3.5,0]) cube([5,7,20]);
	cylinder(d=3,h=20,$fn=32);
	translate([-4-1.5,-3.5,0]) cube([1.5,7,20]);
	translate([-4-1.5-4.5*1,-3.5,0]) cube([1.5,7,20]);
	translate([-4-1.5-4.5*2,-3.5,0]) cube([1.5,7,20]);
	//translate([-4-1.5-4.5*3,-3.5,0]) cube([1.5,7,20]);
	translate([-4-1.5-4.5*3,0,0]) cylinder(d=3,h=20,$fn=32);
}


module platformAlum()
{
	color("darkgrey") translate([-rodOffsetX-26+0.3,5,z+10+75+13-1.2]) rotate([0,90,0]) LProfile(10,10,1.2,150-6);
	color("darkgrey") translate([(rodOffsetX+26)-0.3,5,z+10+75+13-1.2]) rotate([0,180,0]) LProfile(10,10,1.2,150-6);
}
if( !printLayout && (drawArray==[] || drawMetall) )
{
	platformAlum();
}


// z axis carret
if( drawArray==[] || search(14,drawArray)!=[] )
{
	//SCS6UUAll(0);

		extraX = 13;
		Thickness = 6;
		extraY = 9;
		ThicknessY = 19;
		ThicknessZ = 5;

	difference()
	{
		union()
		{
			hull()
			{
				translate([-rodOffsetX-extraX,rodOffsetY+extraY,part6Z+13+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness);
				translate([rodOffsetX+extraX,rodOffsetY+extraY,part6Z+13+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness);

				translate([-rodOffsetX-extraX,rodOffsetY+extraY,part6Z+58+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness);
				translate([rodOffsetX+extraX,rodOffsetY+extraY,part6Z+58+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness);
			}
			color("magenta") hull()
			{
				translate([-rodOffsetX,rodOffsetY+extraY+6,part6Z+17+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness+5);
				translate([-rodOffsetX,rodOffsetY+extraY,part6Z+57+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness);
			}
			color("magenta") hull()
			{
				translate([rodOffsetX,rodOffsetY+extraY+6,part6Z+17+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness+5);
				translate([rodOffsetX,rodOffsetY+extraY,part6Z+57+z]) rotate([-90,0,0]) cylinder(r=3,h=Thickness);
			}
			color("green") hull()
			{
				translate([-rodOffsetX-extraX-3,rodOffsetY+extraY,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);
				translate([rodOffsetX+extraX+3,rodOffsetY+extraY,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);

				translate([-rodOffsetX-extraX-3,rodOffsetY+extraY,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);
				translate([rodOffsetX+extraX+3,rodOffsetY+extraY,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);
			}
			offyb =11;
			extra = 11;
			color("red") hull()
			{
				translate([-8,rodOffsetY+extraY,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+8);
				translate([8,rodOffsetY+extraY,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+8);

				translate([-8,rodOffsetY+extraY,part6Z+17.5+ThicknessYMount+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+8);
				translate([8,rodOffsetY+extraY,part6Z+17.5+ThicknessYMount+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+8);
			}
			difference()
			{
				color("orange") hull()
				{
					translate([-rodOffsetX-24.5,rodOffsetY+extraY-offyb+7,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);
					translate([-rodOffsetX+15.5,rodOffsetY+extraY-offyb+7,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);

					translate([-rodOffsetX-24.5,rodOffsetY+extraY-offyb+7,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);
					translate([-rodOffsetX+15.5,rodOffsetY+extraY-offyb+7,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);
				}
				hull()
				{	
					SCS6UUAll(0);
				}
				translate([0,-10,0])SCS6UUAll(1);
			}

			mirror()
			{
				difference()
				{
					color("orange") hull()
					{
						translate([-rodOffsetX-24.5,rodOffsetY+extraY-offyb+7,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);
						translate([-rodOffsetX+15.5,rodOffsetY+extraY-offyb+7,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);

						translate([-rodOffsetX-24.5,rodOffsetY+extraY-offyb+7,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);
						translate([-rodOffsetX+15.5,rodOffsetY+extraY-offyb+7,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY+offyb+extra);
					}
					hull()
					{
						SCS6UUAll(0);
					}
					translate([0,-10,0])SCS6UUAll(1);
				}
			}

			ThicknessYMount = 2;
			/*
			color("red") hull()
			{
				translate([-rodOffsetX-24.5,rodOffsetY+extraY-offyb,part6Z+10.2+z+10+1.7]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);
				translate([-rodOffsetX-15.5,rodOffsetY+extraY-offyb,part6Z+10.2+z+10+1.7]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);

				translate([-rodOffsetX-24.5,rodOffsetY+extraY-offyb,part6Z+15.5+ThicknessYMount+z+10+1.7]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);
				translate([-rodOffsetX-15.5,rodOffsetY+extraY-offyb,part6Z+15.5+ThicknessYMount+z+10+1.7]) rotate([-90,0,0]) cylinder(r=0.1,h=ThicknessY);
			}
			*/
			translate([-rodOffsetX,rodOffsetY+extraY+5,part6Z+18.5+ThicknessYMount+z])  rotate([0,90,0]) cylinder(r=3,h=rodOffsetX*2,$fn=32);
		}
		SCS6UUAll(1);
		translate([4,rodOffsetY+extraY+11.5,part6Z+5+z])  BeltTensionerHoles();
		// zmax nut
		hull()
		{
			translate([-rodOffsetX-extraX+7,rodOffsetY+extraY+11.5,part6Z+13+z+9])  cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
			translate([-rodOffsetX-extraX+7,rodOffsetY+extraY+11.5-7,part6Z+13+z+9])  cylinder(d=rolson_hex_nut_dia(3)+1,h=3,$fn=6);
		}
		translate([-rodOffsetX-extraX+7,rodOffsetY+extraY+11.5-7,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		// center
		translate([0,rodOffsetY+extraY+23,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		// alums mount holes
		translate([-rodOffsetX-20,rodOffsetY+extraY+26,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		translate([-rodOffsetX-20,rodOffsetY+extraY+1,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		translate([-rodOffsetX-20,rodOffsetY+extraY+13,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		mirror()
		{
			translate([-rodOffsetX-20,rodOffsetY+extraY+26,part6Z])  cylinder(d=2.9,h=35,$fn=32);
			translate([-rodOffsetX-20,rodOffsetY+extraY+1,part6Z])  cylinder(d=2.9,h=35,$fn=32);
			translate([-rodOffsetX-20,rodOffsetY+extraY+13,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		}
		//
		color("red") translate([-rodOffsetX-extraX+4,rodOffsetY+extraY+12,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		mirror() color("red") translate([-rodOffsetX-extraX+4,rodOffsetY+extraY+12,part6Z])  cylinder(d=2.9,h=35,$fn=32);
		platformAlum();
	}
	translate([printLayout ? 6 : 4,printLayout ? 40 : rodOffsetY+extraY+11.5,printLayout ? -(part6Z+5+z-41) : 0])
	difference()
	{
		color("blue") translate([-rodOffsetX+10,rodOffsetY+extraY+11.5-ThicknessY/2,part6Z+5+z+45])  cube([28,ThicknessY-2,8]);
		translate([4,rodOffsetY+extraY+11.5,part6Z+5+z+40])  BeltTensionerHoles();
	}
	
	//ZBelt();
	//part8();
	//ZMaxEndStopper();
	//platformAlum();
}

module zCarretBodyPart(Len,LenExtra=0)
{
	ThicknessZ = 5;

	difference()
	{
		//color("blue") 
		hull()
		{
			translate([-rodOffsetX-24.5,0,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=Len+LenExtra);
			translate([rodOffsetX+24.5,0,part6Z+10.2+z]) rotate([-90,0,0]) cylinder(r=0.1,h=Len+LenExtra);

			translate([-rodOffsetX-24.5,0,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=Len+LenExtra);
			translate([rodOffsetX+24.5,0,part6Z+14.5+ThicknessZ+z]) rotate([-90,0,0]) cylinder(r=0.1,h=Len+LenExtra);
		}
		translate([0,-10,0])SCS6UUAll(1);
		
		translate([0,Len/2,part6Z+14.5+ThicknessZ+z-20]) rotate([0,0,0]) scale([1.8,1,1]) cylinder(r=Len/4,h=40);
		translate([-rodOffsetX,Len/2,part6Z+14.5+ThicknessZ+z-20]) rotate([0,0,0]) scale([1,1.2,1]) cylinder(r=Len/4,h=40);
		translate([rodOffsetX,Len/2,part6Z+14.5+ThicknessZ+z-20]) rotate([0,0,0]) scale([1,1.2,1]) cylinder(r=Len/4,h=40);
	}
}


if( drawArray==[] || search(15,drawArray)!=[] )
{
	//printLayout = 0;
	aY = printLayout ? -60 : 0;
	aZ = printLayout ? 243 : 0;
	rY = printLayout ? -90 : 0;
	//
	Len = 30;
	LenOffset = printLayout ? 10 : 0;
	LenEndExtra = 10;
	HolesOffse = 6;
	///*
	translate([0,aY,aZ]) rotate([rY,0,0])
	{
		translate([0,46+Len+LenOffset+Len,0]) difference()
		{
			
			union()
			{
				color("orange")
				{
					zCarretBodyPart(Len,LenExtra=LenEndExtra);
				}
				translate([0,LenEndExtra+Len,part6Z+15+z]) cube([112,2,12],center=true);
			}
			// side holes
			translate([rodOffsetX+20.5,LenEndExtra+Len-HolesOffse,part6Z+15+z-10]) cylinder(r=1.51,h=30,$fn=12);
			mirror() translate([rodOffsetX+20.5,LenEndExtra+Len-HolesOffse,part6Z+15+z-10]) cylinder(r=1.51,h=30,$fn=12);
			// tweak holes
			translate([rodOffsetX+6,LenEndExtra+Len-HolesOffse,part6Z+15+z-10]) cylinder(r=1.51,h=30,$fn=12);
			mirror() translate([rodOffsetX+6,LenEndExtra+Len-HolesOffse,part6Z+15+z-10]) cylinder(r=1.51,h=30,$fn=12);
			// center holes
			translate([rodOffsetX-5,LenEndExtra+Len-HolesOffse,part6Z+15+z-10]) cylinder(r=1.51,h=30,$fn=12);
			mirror() translate([rodOffsetX-5.5,LenEndExtra+Len-HolesOffse,part6Z+15+z-10]) cylinder(r=1.51,h=30,$fn=12);
			translate([0,-10,0])SCS6UUAll(1);
		}
	}
	//*/
	color("blue") translate([0,46,0])
	{
		zCarretBodyPart(Len);
	}
	color("green") translate([0,46+Len+LenOffset,0])
	{
		zCarretBodyPart(Len);
	}
}


spacersH2 = part12Z-part7EndZ;

// spacers 2
if( drawArray==[] || search(16,drawArray)!=[] )
{
	h = spacersH2/2;
	//echo ("hh");
	//echo(h);
	//
	//printLayout = 1;
	//
	spacersDistMultX = printLayout ? 0.31 : 1;
	spacersDistMultY = printLayout ? 0.55 : 1;
	spacersRot = printLayout ? 0 : 0;
	spacersRot2 = printLayout ? 90 : 0;
	offX2 = printLayout ? 0 : 0;
	offY2 = printLayout ? 10 : 0;

	off2 = printLayout ? 44 : 0;
	//
	mountOffsetR = printLayout ? 180 : 0;
	mountOffsetRZ = printLayout ? -90 : 0;
	//
	//
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX1*spacersDistMultX,BaseGearboxThreadedRodsY1*spacersDistMultY,part7EndZ]) rotate([0,mountOffsetR,0+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=1);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX2*spacersDistMultX,BaseGearboxThreadedRodsY2*spacersDistMultY,part7EndZ]) rotate([0,mountOffsetR,90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=1);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX3*spacersDistMultX,BaseGearboxThreadedRodsY3*spacersDistMultY,part7EndZ]) rotate([0,mountOffsetR,-90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=4);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX4*spacersDistMultX,BaseGearboxThreadedRodsY4*spacersDistMultY,part7EndZ]) rotate([0,mountOffsetR,180+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=5);
}

// spacers 2
if( drawArray==[] || search(17,drawArray)!=[] )
{
	
	h = spacersH2/2;
	//echo ("hh");
	//echo(h);
	//
	//printLayout = 1;
	//
	spacersDistMultX = printLayout ? 0.31 : 1;
	spacersDistMultY = printLayout ? 0.55 : 1;
	spacersRot = printLayout ? 0 : 0;
	spacersRot2 = printLayout ? 90 : 0;
	offX2 = printLayout ? 0 : 0;
	offY2 = printLayout ? 10 : 0;

	off2 = printLayout ? 44 : 0;
	
	mountH = 15;
	mountOffsetZ = printLayout ? mountH : 0;
	mountOffsetZ2 = printLayout ? (h+h+mountH-3) : 0;
	//
	mountOffsetR = printLayout ? 180 : 0;
	mountOffsetRZ = printLayout ? -90 : 0;
	//
	//
	//intersection()
	//{
	//	union()
	//	{
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX1*spacersDistMultX,BaseGearboxThreadedRodsY1*spacersDistMultY,part7EndZ+h]) rotate([0,mountOffsetR,0+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=1);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX2*spacersDistMultX,BaseGearboxThreadedRodsY2*spacersDistMultY,part7EndZ+h]) rotate([0,mountOffsetR,90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=1);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX3*spacersDistMultX,BaseGearboxThreadedRodsY3*spacersDistMultY,part7EndZ+h]) rotate([0,mountOffsetR,-90+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=4);
	color("blue") rotate([spacersRot,0,0]) translate([BaseGearboxThreadedRodsX4*spacersDistMultX,BaseGearboxThreadedRodsY4*spacersDistMultY,part7EndZ+h]) rotate([0,mountOffsetR,180+mountOffsetRZ]) spacer(m3PlatesRad,m3PlatesRad,h=h,bWings=5);
	//	}
	//	translate([-50,-50,part7EndZ+h]) rotate([0,mountOffsetR,0+mountOffsetRZ])  cube([100,100,h-44.5]);
	//}
}

if( !printLayout && (drawArray==[] || drawLCD) )
{
	translate([LCDX,LCDY,LCDZ]) LCD20x4SmartController();
}


module BaseAllum()
{
	len = 160+6;
	color("darkgrey") translate([-alumXOffset,-63,-1.5]) LProfile(15,15,1.5,len);
	mirror() color("darkgrey") translate([-alumXOffset,-63,-1.5]) LProfile(15,15,1.5,len);
}

if(  !printLayout && (drawArray==[] || drawBaseAllum) )
{
	BaseAllum();
}


// hot end
if( !printLayout && (drawArray==[] || drawHotEnd!=0) )
{
	translate ([xp,yp,armsZ+armsZExtra+31])
	{
		rotate([180,0,0]) color("silver") heatsinkE3DV5(0,100);
	}
}

if(  !printLayout && (drawArray==[] || drawMetall) )
{
	translate ([0,0,armsZ+armsZExtra+bottomArmH]) Bearing625();
}

if( drawArray==[] || search(18,drawArray)!=[] )
{
	translate ([0,0,part13ZTop])
	{
		difference()
		{
			//echo(armsZ+armsZExtra-part13ZTop);
			color("red") translate([0,0,0]) cylinder(r=ArmNearestW/2+1,h=armsZ+armsZExtra-part13ZTop);
			color("red") translate([0,0,-1]) cylinder(d=8,h=20);
		}
	}
}


module armCubeBearings()
{
		blockH = 22;
		//translate([20,-5,5]) cube([10,10,bottomArmH]);
		difference()
		{
			union()
			{
				//minkowski()
				{
				translate([-10,-11,-0.5]) cube([20,22,blockH]);
				//sphere(r=2);
				}
				//hull()
				//{
					//cylinder(r=ArmNearestD/2+2,h=bottomArmH+7);
					//translate([Linkage_1*0.15,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH+7);
				//}
			}
			translate([0,0,-1]) cylinder(d=8,h=bottomArmH+20,$fn=64);
			//color("red") translate([-15,4+3,3]) rotate([0,90,0]) rotate([0,0,90]) cylinder(d=rolson_hex_nut_dia(3),h=100,$fn=6);
			color("red") translate([-15,4+3,3]) rotate([0,90,0]) cylinder(d=3+0.2,h=100,$fn=24);
			color("red") translate([-15,-(4+3),3]) rotate([0,90,0]) cylinder(d=3+0.2,h=100,$fn=24);
			color("red") translate([-15,4+3,4+bottomArmH+4]) rotate([0,90,0]) cylinder(d=3+0.2,h=100,$fn=24);
			color("red") translate([-15,-(4+3),4+bottomArmH+4]) rotate([0,90,0]) cylinder(d=3+0.2,h=100,$fn=24);
			translate([0,0,blockH-0.5-Bearing623Height()]) cylinder(d=Bearing623Diameter()+0.8,h=Bearing623Height()+1,$fn=64);
			translate([0,0,-1-0.5]) cylinder(d=Bearing623Diameter()+0.8,h=Bearing623Height()+1,$fn=64);
			//translate([0.1,-25,-1]) cube([0.2,50,blockH+5]);
			translate([0,0,5.5]) cylinder(r=20,h=bottomArmH);
		}
}

// bottom arm
if( drawArray==[] || search(19,drawArray)!=[])
{
	//printLayout = 0;

	a = printLayout ? 0 : q22;
	ax = printLayout ? 0 : 0;

	translate ([0,0,armsZ+armsZExtra]) rotate([ax,0,a])
	{
		//color("red") translate([-4,0,20]) hull()
		//{
		//	translate([0,-1.5,0])  cube([3,3,10]);
		//	translate([75.5-3,-1.5,0]) cube([3,3,10]);
		//}
		
		///*
		translate([printLayout ? 10 : 0,0,0]) rotate([0,printLayout ? 90 : 0,printLayout ? 0 : 0]) intersection()
		{
			armCube();
			translate([0,-25,-1]) cube([50,50,50]);
		}
		translate([printLayout ? -10 : 0,0,0]) rotate([0,printLayout ? -90 : 0,printLayout ? 0 : 0])  intersection()
		{
			armCube();
			mirror() translate([0,-25,-1]) cube([50,50,50]);
		}
		rotate([0,printLayout ? 180 : 0,printLayout ? 0 : 0]) 
		translate([printLayout ? -90 : 0,printLayout ? 30 : 0,printLayout ? 6.5 : 0]) //rotate([0,printLayout ? -90 : 0,printLayout ? 0 : 0])  
		intersection()
		{
			translate([Linkage_1,0,0])  armCubeBearings();
			translate([Linkage_1,0,0]) translate([-25,-25,-1]) cube([50,50,13]);
		}
		color("green") rotate([0,printLayout ? 0 : 0,printLayout ? 0 : 0]) 
		translate([printLayout ? -90 : 0,printLayout ? 30 : 0,printLayout ? -27.5 : 0])  
		intersection()
		{
			translate([Linkage_1,0,0])  armCubeBearings();
			translate([Linkage_1,0,0]) translate([-25,-25,13]) cube([50,50,13]);
		}
		//*/
		translate([printLayout ? -30 : 0,printLayout ? 60 : 0,printLayout ? 24 : 0])
		rotate([0,printLayout ? 90 : 0,printLayout ? 0 : 0]) 
		color("blue") difference()
		{
			hull()
			{
				translate([27,0,0]) armsRods(d=rolson_hex_nut_dia(3)+1,h=48/2);
			}
			translate([27,0,0]) armsRods(d=3+0.2,h=100);
			color("red") translate([0,0,10.5]) rotate([0,90,0]) cylinder(d=10,h=100,$fn=32);
			translate([27-0.1,0,0]) armsRods(d=rolson_hex_nut_dia(3),h=rolson_hex_nut_hi(3)+0.3,fn=6);
		}
		//
		translate([printLayout ? 10 : 0,printLayout ? 60 : 0,printLayout ? 24+48/2 : 0])
		rotate([0,printLayout ? 90 : 0,printLayout ? 0 : 0]) 
		color("lightblue") difference()
		{
			hull()
			{
				translate([27+48/2,0,0]) armsRods(d=rolson_hex_nut_dia(3)+1,h=48/2);
			}
			translate([27,0,0]) armsRods(d=3+0.2,h=100);
			color("red") translate([0,0,10.5]) rotate([0,90,0]) cylinder(d=10,h=100,$fn=32);
			translate([27+48/2-0.1,0,0]) armsRods(d=rolson_hex_nut_dia(3),h=rolson_hex_nut_hi(3)+0.3,fn=6);
		}
	}
	/*
	translate ([0,0,armsZ+armsZExtra]) rotate([ax,0,a])
	{
		difference()
		{
			union()
			{
				hull()
				{
					cylinder(r=ArmNearestD/2+2,h=bottomArmH+7);
					translate([Linkage_1*0.15,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH+7);
				}
				hull()
				{
					cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					translate([Linkage_1*0.85,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
				}
				translate([6,6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=12,$fn=12);
				translate([0,0,bottomArmH]) cylinder(r=ArmNearestD/2+2,h=Bearing625Height());
			}
			translate([Linkage_1,0,1]) cylinder(d=Bearing623Diameter()+0.6,h=bottomArmH+2,$fn=64);
			translate([Linkage_1,0,-1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=bottomArmH+2);
			//translate([0,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([0,0,-1]) cylinder(d=8+0.6,h=bottomArmH+20,$fn=64);
			//color("blue") translate([0,0,bottomArmH-1]) cylinder(d=BearingF512MDiameter()+BearingRClearance*2,h=1+1,$fn=24);
			translate([4,-0.5,-1]) cube([10.5,1,bottomArmH+20]);
			// fixator
			translate([0,0,bottomArmH/2+4])
			{
				color("red") translate([6,50,0]) rotate([90,0,0]) cylinder(r=1.51,h=100,$fn=24);
				color("red") translate([6,16,0]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
				color("red") translate([6,-6,0]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			}
		//
			translate([Linkage_1*0.35,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);
			translate([Linkage_1*0.70,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);
			translate([0,0,bottomArmH+6]) cylinder(d=Bearing625Diameter()+0.8,h=Bearing625Height()+1,$fn=64);

		}
		if( drawArray==[] )
		{
			translate([Linkage_1,0,1]) Bearing623();
			translate([Linkage_1,0,1+Bearing623Height()]) Bearing623();
			color("silver") translate([Linkage_1,0,1+Bearing623Height()+Bearing623Height()]) hex_nut(5);
		}
	}
	*/
	a1 = printLayout ? 0 : q22;
	ay1 = printLayout ? 23 : 0;
	az1 = printLayout ? -30 : 0;
/*
	translate ([0,ay1,armsZ+armsZExtra+30+az1]) rotate([0,0,a1])
	{
		//cylinder(r=Bearing623Diameter()+2,h=bottomArmH+Bearing625Height());
		difference()
		{
			union()
			{
				hull()
				{
					cylinder(d=Bearing625Diameter()+5,h=bottomArmH);
					translate([2,0,0]) cylinder(d=Bearing625Diameter()+5,h=bottomArmH);
					translate([Linkage_1*0.15,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					translate([Linkage_1*0.85,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
				}
				translate([6,6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=12,$fn=12);
			translate([-13,0,bottomArmH/2]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+3.5,h=13,$fn=24);
			}
			translate([Linkage_1,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([Linkage_1,0,-1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=bottomArmH+2);
			//translate([0,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([0,0,-1]) cylinder(d=rolson_hex_nut_dia(5)+1,h=bottomArmH+2);
			hull()
			{
			color("blue") translate([0,0,2]) cylinder(d=Bearing625Diameter()+BearingRClearance*2,h=bottomArmH);
			color("blue") translate([2,0,2]) cylinder(d=Bearing625Diameter()+BearingRClearance*2,h=bottomArmH);
			}
				// mount holes
			translate([5,-0.5,0]) cube([12.5,1,bottomArmH+2]);
			color("red") translate([12,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100,$fn=24);
			color("red") translate([12,17,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=11,$fn=12);
			color("red") translate([12,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=13,$fn=24);
			color("red") translate([-18,0,bottomArmH/2]) rotate([0,90,0]) cylinder(d=3,h=13,$fn=24);
			color("red") translate([-10,0,bottomArmH/2]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=13,$fn=6);
						// mount holes 2
			translate([Linkage_1-11,-0.5,0]) cube([12.5,1,bottomArmH+2]);
			color("red") translate([Linkage_1-7,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100,$fn=24);
			color("red") translate([Linkage_1-7,17,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			color("red") translate([Linkage_1-7,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);

			translate([Linkage_1*0.35,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);
			translate([Linkage_1*0.70,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);


		}
		if( drawArray==[] )
		{
			translate([Linkage_1,0,1]) Bearing623();
			translate([Linkage_1,0,1+Bearing623Height()]) Bearing623();
			color("silver") translate([Linkage_1,0,1+Bearing623Height()+Bearing623Height()]) hex_nut(5);
		}
	}
	*/
}

//echo (bottomArmH);

if( drawArray==[] || search(20,drawArray)!=[])
{
	//printLayout=0;
	xd = -dhalf + l * cos(q22);
  yd = l * sin(q22);
	a = printLayout ? 0 : atan((y-yd)/(x-xd));
	mountRotZ = -90;
	translate ([xd,yd,armsZ+bottomArmH+armsZExtra+2.5-7])
		rotate([0,0,a]) 
	{
		color("brown") difference()
		{
			union()
			{
				color("blue") 
				hull()
				{
					cylinder(r=ArmNearestD/2,h=bottomArmH);
					translate([5,20,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
				}

				color("blue") 
				hull() 
				{
					translate([5,20,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
					translate([Linkage_2,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
				}

				color("red") 
				hull()
				{
					translate([Linkage_2,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
					translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,0]) cylinder(d=16+6,h=bottomArmH);
				}
				color("red") hull()
				{
					translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,0])
					{
						cylinder(d=16+6,h=bottomArmH);
						rotate([0,0,mountRotZ]) translate([8,0,0]) cylinder(d=10,h=bottomArmH);
					}
				}
				translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,0]) rotate([0,0,mountRotZ]) translate([0,-4,0]) cube([16,8,bottomArmH]);

				//translate([Linkage_2-13,6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=12,$fn=12);
			}
			translate([Linkage_2,0,-1]) cylinder(d=8,h=30,$fn=32);
			translate([Linkage_2,0,+1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH,$fn=32);
			translate([0,0,-1]) cylinder(d=3.0,h=30,$fn=32);

			//translate([Linkage_2-20,-0.5,-1]) cube([20.5,1,bottomArmH+2]);
			//color("red") translate([Linkage_2-13,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100);
			//color("red") translate([Linkage_2-13,16,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			//color("red") translate([Linkage_2-13,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
		// end effector arm
		translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,bottomArmH/2])  rotate([0,0,mountRotZ])  translate([13,10,0]) rotate([90,0,0])  cylinder(d=3,h=30,$fn=12);

				translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,bottomArmH/2]) rotate([0,0,mountRotZ])  translate([13,10,0]) rotate([90,0,0])   cylinder(d=rolson_hex_nut_dia(3),h=3+3,$fn=12);

				translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle])  translate([EndPointMountOffset,0,bottomArmH/2]) rotate([0,0,mountRotZ])  translate([13,-4,0]) rotate([90,0,0])  cylinder(d=rolson_hex_nut_dia(3),h=3+3,$fn=12);

			//translate([Linkage_2-20,-0.5,-1]) cube([20.5,1,bottomArmH+2]);
			//color("red") translate([Linkage_2-13,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100);
			//color("red") translate([Linkage_2-13,16,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			//color("red") translate([Linkage_2-13,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			
			translate([Linkage_2,0,0]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,0]) rotate([0,0,mountRotZ]) translate([0,-0.5,0]) cube([20,1,20]);
		// hot end mount hole
			color("silver") translate([Linkage_2,0,-1]) rotate([0,0,EndPointMountAngle]) translate([EndPointMountOffset,0,0]) cylinder(r=8+0.1,h=100);
		}
		if( drawArray==[] )
		{
			translate([Linkage_2,0,1]) Bearing623();
			translate([Linkage_2,0,1+Bearing623Height()]) Bearing623();
		}
	}
}

if( !printLayout && (drawArray==[] || drawMetall) )
{
	translate ([0,0,armsZ+bottomArmH+armsZExtra+12])
	{
		Bearing625();
		color("silver") translate ([0,0,4]) rolson_hex_nut(5);
	}
}

// top arm
if( drawArray==[] || search(21,drawArray)!=[] )
{
	a = printLayout ? 0 : q11;
	ax = printLayout ? 180 : 0;
	translate ([0,0,armsZ+bottomArmH+armsZExtra+Bearing625Height()+3+12]) rotate([ax,0,a])
	{
		difference()
		{
			union()
			{
				hull()
				{
					cylinder(r=ArmNearestD/2,h=bottomArmH,$fn=64);
					translate([Linkage_1*0.15,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH,$fn=64);
				}
				hull()
				{
					cylinder(r=ArmNearestD/2,h=bottomArmH,$fn=64);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH,$fn=64);
				}
				hull()
				{
					translate([Linkage_1*0.85,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH,$fn=64);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH,$fn=64);
				}
				translate([6,6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=12,$fn=12);
			}
			translate([Linkage_1,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2,$fn=64);
			translate([Linkage_1,0,-1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=bottomArmH+2,$fn=64);
			//translate([0,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([0,0,-1]) cylinder(d=5.0,h=bottomArmH+2,$fn=32);
			translate([0,-0.5,-1]) cube([12,1,bottomArmH+2]);
			color("blue") translate([0,0,-0.1]) cylinder(d=BearingF512MDiameter()+BearingRClearance*2,h=1.1);
			//color("blue") translate([0,0,-0.1]) cylinder(d=rolson_hex_nut_dia(5)+1,h=1.1,$fn=12);
			

//			difference()
			//{
			//color("blue") translate([0,0,-0.1]) cylinder(r=ArmNearestD/2+0.5,h=0.5+0.1);
			//color("blue") translate([0,0,-0.1]) cylinder(r=ArmNearestD/2-2.3,h=0.5+0.1);
			//}
			color("red") translate([5,50,bottomArmH/2]) rotate([90,0,0]) cylinder(d=3,h=100,$fn=12);
			color("red") translate([5,17,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+2,h=10,$fn=12);
			color("red") translate([5,-7,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+2,h=10,$fn=12);
			
									// mount holes 2
			translate([Linkage_1-13,-0.5,0]) cube([12.5,1,bottomArmH+2]);
			color("red") translate([Linkage_1-7,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100,$fn=24);
			color("red") translate([Linkage_1-7,17,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+2,h=10,$fn=12);
			color("red") translate([Linkage_1-7,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+2,h=10,$fn=12);

			
			//translate([Linkage_1*0.35,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);
			//translate([Linkage_1*0.70,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);
		}
	}
// holder
				a1 = printLayout ? 0 : q11;
	ay1 = printLayout ? 23 : 0;
az1 = printLayout ? -10 : 28;
/*
	translate ([0,ay1,armsZ+bottomArmH+armsZExtra+Bearing625Height()+az1]) rotate([0,0,a1])
	{
		//cylinder(r=Bearing623Diameter()+2,h=bottomArmH+Bearing625Height());
		difference()
		{
			union()
			{
				hull()
				{
					cylinder(d=Bearing625Diameter()+5,h=bottomArmH);
					translate([2,0,0]) cylinder(d=Bearing625Diameter()+5,h=bottomArmH);
					translate([Linkage_1*0.15,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
				}
				hull()
				{
					translate([Linkage_1*0.85,0,0]) cylinder(r=ArmNearestW/2,h=bottomArmH);
					translate([Linkage_1,0,0]) cylinder(r=ArmNearestD/2,h=bottomArmH);
				}
				translate([6,6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=12,$fn=12);
			translate([-13,0,bottomArmH/2]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+3.5,h=13,$fn=24);
			}
			translate([Linkage_1,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([Linkage_1,0,-1]) cylinder(d=rolson_hex_nut_dia(3)+1,h=bottomArmH+2);
			//translate([0,0,1]) cylinder(d=Bearing623Diameter()+0.2,h=bottomArmH+2);
			translate([0,0,-1]) cylinder(d=rolson_hex_nut_dia(5)+1,h=bottomArmH+2);
			hull()
			{
			color("blue") translate([0,0,2]) cylinder(d=Bearing625Diameter()+BearingRClearance*2,h=bottomArmH);
			color("blue") translate([2,0,2]) cylinder(d=Bearing625Diameter()+BearingRClearance*2,h=bottomArmH);
			}
				// mount holes
			translate([5,-0.5,0]) cube([12.5,1,bottomArmH+2]);
			color("red") translate([12,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100,$fn=24);
			color("red") translate([12,17,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=11,$fn=12);
			color("red") translate([12,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=13,$fn=24);
			color("red") translate([-18,0,bottomArmH/2]) rotate([0,90,0]) cylinder(d=3,h=13,$fn=24);
			color("red") translate([-10,0,bottomArmH/2]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+0.5,h=13,$fn=6);
						// mount holes 2
			translate([Linkage_1-11,-0.5,0]) cube([12.5,1,bottomArmH+2]);
			color("red") translate([Linkage_1-7,50,bottomArmH/2]) rotate([90,0,0]) cylinder(r=1.51,h=100,$fn=24);
			color("red") translate([Linkage_1-7,17,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);
			color("red") translate([Linkage_1-7,-6,bottomArmH/2]) rotate([90,0,0]) cylinder(d=rolson_hex_nut_dia(3)+1,h=10,$fn=12);

			translate([Linkage_1*0.35,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);
			translate([Linkage_1*0.70,0,0]) cylinder(d=3,h=bottomArmH+2,$fn=23);


		}
		if( drawArray==[] )
		{
			translate([Linkage_1,0,1]) Bearing623();
			translate([Linkage_1,0,1+Bearing623Height()]) Bearing623();
			color("silver") translate([Linkage_1,0,1+Bearing623Height()+Bearing623Height()]) hex_nut(5);
		}
	}
		*/
}


// upper bearing fixer
if( drawArray==[] || search(23,drawArray)!=[] )
{
  translate([0,0,armsZ-Bearing608Height()-UpperBearingMountH-12-UpperBearingMountOffset+armsExtruderExtra]) 
  {
		difference()
		{
			union()
			{
				cylinder(r=centerTubeFixerR,h=9,$fn=32);
				translate([0,0,9]) cylinder(r=4+2,h=13-9,$fn=32);
			}
			translate([0,0,-1]) cylinder(r=4,h=15+2,$fn=32);
			translate([-20,6,5]) rotate([0,90,0]) cylinder(d=3.1,h=45,$fn=16);
			translate([6.5,6,5]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+0.7,h=45,$fn=6);
			translate([-10,6,5]) rotate([0,90,0]) cylinder(d=rolson_hex_nut_dia(3)+0.7,h=3,$fn=6);
			translate([0,0,-1]) cube([1,10,12]);
		}
	}
}


if( drawArray==[] )
{
//	translate ([0,0,0]) cylinder(r=4.5,h=300);
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
  // z stepper
	if( drawZSteppers )
		ZStepper();
  // x stepper
  translate([xStepperX,xStepperY,xStepperZ])
  {
		if( drawSteppers )
			rotate([0,0,0]) Nema17_shaft22_Stepper(0,NemaSize);
    translate ([0,0,0]) rotate([180,0,0]) Pulley16TeethAlu();

		holeDist = lookup(NemaDistanceBetweenMountingHoles, Nema17) * 0.5;
		color("grey")
		{
			translate([-holeDist,-holeDist,-xStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=xStepperZ+5);
			translate([holeDist,-holeDist,-xStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=xStepperZ+5);
			translate([holeDist,holeDist,-xStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=xStepperZ+5);
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
			translate([-holeDist,-holeDist,-yStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=xStepperZ+5);
			translate([holeDist,-holeDist,-yStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=xStepperZ+5);
			translate([-holeDist,holeDist,-yStepperZ+firtstNumZ-1]) cylinder(r=1.51,h=xStepperZ+5);
		}
  }
}

// m3 threaded rods
if( drawArray==[] )
{
	color("silver") 
	{
		translate([-40,0,0]) rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=254,$fn=16);
		translate([40,0,0])  rotate([0,0,0]) scale([1,1,1]) cylinder(d=3.1,h=254,$fn=16);
	}
}

module ZBelt()
{
  color ("black") translate([zStepperX-6.5,zStepperY-15.5,50]) cube([1.5,6,225]);
  color ("black") translate([zStepperX+5,zStepperY-15.5,50]) cube([1.5,6,225]);
}

// belts
if( !printLayout && (drawArray==[] || drawBelts==1) ) 
{
	bletXZOffs = Bearing625Height()+1.5+(pulleysH-3)/2-3;
	color ("black") hull()
	{
		
		translate([xStepperX+31/2+5+0.7,xStepperY-31/2,bletXZOffs]) cylinder(d=1.5,h=6);
		rotate([0,0,0])  translate([ArmPulleyDia/2+0.7,0,bletXZOffs]) cylinder(d=1.5,h=6);
  }
	
	color ("black") hull()
	{
		translate([xStepperX-31/2-5-0.7,xStepperY-31/2,bletXZOffs]) cylinder(d=1.5,h=6);
		rotate([0,0,240])  translate([ArmPulleyDia/2+0.7,0,bletXZOffs]) cylinder(d=1.5,h=6);
  }

	color ("black") hull()
	{
		translate([yStepperX+31/2+5+0.7,yStepperY-31/2,17.5]) cylinder(d=1.5,h=6);
		rotate([0,0,-40])  translate([ArmPulleyDia/2+0.7,0,17.5]) cylinder(d=1.5,h=6);
  }
	
	color ("black") hull()
	{
		translate([yStepperX-31/2-5+0.7,yStepperY-31/2,17.5]) cylinder(d=1.5,h=6);
		rotate([0,0,180])  translate([ArmPulleyDia/2+0.7,0,17.5]) cylinder(d=1.5,h=6);
  }
	ZBelt();
}

// belts
if( !printLayout && (drawArray==[] || drawZBelts==1) ) 
{
	ZBelt();
}

switchX_ox = -53;
switchX_oy = -9;
switchX_r = -25;
module SwitchX(bHolesOnly=0)
{
	// switch x
	translate([switchX_ox,switchX_oy,20]) rotate([90,switchX_r,90]) translate([3,-5,0]) EndSwitchBody20x11(bHolesOnly);
}

switchY_rz1 = 155;
switchY_ox = ArmPulleyDia/2+12.5;
module SwitchY(bHolesOnly=0)
{
	// switch y
	rotate([0,0,switchY_rz1]) translate([switchY_ox,0,31]) rotate([90,switchX_r,-100]) translate([2,-3,0]) EndSwitchBody20x11(bHolesOnly);
}

if( !printLayout && (drawArray==[] || drawSwitchesAll==1) )
{
	SwitchX();
	SwitchY();
}

// ID6 OD8 center tube
if( !printLayout && (drawArray==[] || drawMetall) )
{
	translate ([0,0,Bearing625Height()+pulleysH+pulleysH+9+isExpolode*140]) 
		color("silver")
	{
		difference()
		{
				cylinder(r=4,h=280);
				cylinder(r=3,h=285);
		}
	}
}

// upper bearing mount
if( drawArray==[] || search(66,drawArray)!=[] )
{
  translate([0,0,Bearing625Height()+pulleysH+pulleysH+32+isExpolode*85+Bearing608Height()]) 
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
			// rods fits
			translate([-45,5.5,-0.1]) cube([20,10,40]);
			translate([25,5.5,-0.1]) cube([20,10,40]);
    }
  }
}

// ramps 1.4
if( !printLayout && (drawArray==[] || drawRamps) )
{
	RAMPS();
}

if( !printLayout && (drawArray==[] || drawMetall) )
{
	translate ([0,0,part6Z+part6_to_12ZOffset+1]) Bearing608(); 
}
// xy steppers
if( !printLayout && (drawArray==[] || drawMetall) ) 
{
	translate([xStepperX,xStepperY,3]) Bearing625();
	translate([yStepperX,yStepperY,3]) Bearing625();
}
// bed
if( !printLayout && (drawArray==[] || drawBed) )
{
	translate([BedXOffset,BedYOffset,40]) color ([1,0.5,0.5,0.5]) cube([BedSizeX,BedSizeY,3]);
}
