use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>
use <Modules/EndStoppers.scad>
include <Modules/MCAD/stepper.scad>


m5Rclearance = 0.1;
m5Hclearance = 0.2;
b625RClearance = 0.2;
b608Clearance = 0.3;
outerRad = (80*2/3.14*0.5);

drawIndex = 4;//5;//4;//4;//0;//3;//0;

isExpolode = 0;
pulley1H = 10.5;
pulley2H = 9;
//cylinder(r=4,h=30);
smallHolesDia = 1.55;

endStopArmH = 2.5;

shaftRadius = 5.1/2;
shaftsSegments = 32;
pulleysSpace = 0.5;



// MY NEMA with 24mm length shafts
module Nema17_shaft24_Stepper()
{
	color ("silver")
  {		
    motor(Nema17,NemaLengthLong);
    translate([0,0,-40+16]) cylinder(r=2.5,h=8,$fn=32);
  }
  color ("gold") translate([21,-5,41.5]) cube ([5,10,5]);
}

//translate([-25,110,-24]) cube([24,24,24]);
//translate([0,150,0])  Nema17_shaft24_Stepper();

if( drawIndex==0 ) 
{
  // z stepper
  translate([0,83,49]) rotate([90,0,0])
  {
    translate( [0,0,45]) rotate([180,0,0]) Nema17_shaft24_Stepper();
    translate ([0,0,52]) Pulley16Teeth();
  }

  // x stepper
  translate([25,110,32-Bearing625Height()])
  {
    rotate([0,0,-90]) Nema17_shaft24_Stepper();
    translate ([0,0,-6]) rotate([180,0,0]) Pulley16Teeth();
  }
  // y stepper
  translate([-25,110,32-Bearing625Height()])
  {
    rotate([0,0,-90]) Nema17_shaft24_Stepper();
    translate ([0,0,-18]) rotate([0,0,0]) Pulley16Teeth();
  }
}
// bottom
//if( drawIndex==0 ) translate([-50,-30,-5]) color ("grey") cube([100,160,5]);

// bed
if( drawIndex==0 ) translate([-50,25,85]) color ([1,0.5,0.5,0.3]) cube([100,100,3]);

rodOffsetX = 40;
rodOffsetY = 15;

// rods
if( drawIndex==0 ) translate([rodOffsetX,rodOffsetY/*+20*/,40]) color ("silver") cylinder(r=3,h=200);

if( drawIndex==0 ) translate([-rodOffsetX,rodOffsetY,40]) color ("silver") cylinder(r=3,h=200);

if( drawIndex==0 ) Bearing625();

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+isExpolode*5]) color( "Silver") hex_nut(5);

// rods bearing
if( drawIndex==0 ) translate([rodOffsetX,rodOffsetY,65]) color ("silver") cylinder(d=12,h=19);
//if( drawIndex==0 ) translate([rodOffsetX,rodOffsetY,65+19]) color ("silver") cylinder(d=12,h=19);


if( drawIndex==0 ) 
{
  color ("black") translate([26,0,6.5]) rotate([0,0,88]) cube([110,1.5,6]);
  color ("black") translate([-20,15,6.5]) rotate([0,0,67]) cube([110,1.5,6]);

  color ("black") translate([20,15,17.5]) rotate([0,0,112]) cube([110,1.5,6]);
  color ("black") translate([-26,0,17.5]) rotate([0,0,92]) cube([110,1.5,6]);
}

// pulley1
if( drawIndex==1 || drawIndex==0 )
{
	translate([0,0,Bearing625Height()+isExpolode*10])
	{	
		ArmPulley(numBigHoles=5,retainerH=endStopArmH);
		translate([0,0,pulley1H-endStopArmH]) 
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

// puter tube holder - mounted to pulley2 (top)
if( drawIndex==3 || drawIndex==0 )
{
	rotate([0,0,0])//90])
	{
    translate ([0,0,Bearing625Height()+pulley1H+pulley2H+pulleysSpace+isExpolode*35]) 
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

if( drawIndex==0 )  
  translate ([0,0,Bearing625Height()+pulley1H+pulley2H+9++isExpolode*40]) 
  color("silver")
{
	difference()
	{
			cylinder(r=4,h=200);
			cylinder(r=3,h=200);
	}
}

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+pulley1H+pulley2H+35+isExpolode*45]) Bearing608(); 

//if( drawIndex==0 ) translate([30,0,0]) cube([10,10,50]);

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
        color("red") rotate([0,0,0]) scale([1,1,1])
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
          translate([40,0,0]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=rodsSupportH,$fn=16);
        }
        translate([rodOffsetX,rodOffsetY,-0]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.31,h=rodsSupportH,$fn=16);
      }
      difference()
      {
        hull()
        {
          translate([-rodOffsetX,rodOffsetY,-0]) cylinder(r=3+5,h=rodsSupportH);
          translate([-40,0,0])color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=rodsSupportH,$fn=16);
        }
          translate([-rodOffsetX,rodOffsetY,-0]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.31,h=rodsSupportH,$fn=16);
      }
			// center mount
			difference()
			{
				hull()
				{
					translate([0,34,-0]) cylinder(r=3+5,h=rodsSupportH);
					translate([0,25,0])color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=25,h=rodsSupportH,$fn=16);
				}
				translate([0,34,-0]) color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.31,h=rodsSupportH,$fn=16);
			}

			// extra
      height = 30;
			hull()
			{
				translate([rodOffsetX,rodOffsetY-11,-0]) rotate([0,0,45]) cylinder(r=3+8,h=height,$fn=4);
				translate([40,0,0]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
			}

			hull()
			{
				translate([-rodOffsetX,rodOffsetY-11,-0]) rotate([0,0,45]) cylinder(r=3+8,h=height,$fn=4);
				translate([-40,0,0]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(d=15,h=height,$fn=16);
			}
		}
		translate([0,0,5]) color("green") cylinder(d=60,h=Bearing625Height()+pulley1H+pulley2H+35+5);

		color ("magenta") hull()
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
			cube([20,5,7]);

		translate([-48,-13,23.5]) 
		color("blue") rotate([0,0,0]) scale([1,1,1])
			cube([20,5,7]);


		color("red") translate([0,0,0]) cylinder(d=Bearing625Diameter()+b625RClearance,h=Bearing625Height());

		translate([-28,-13,0]) rotate([180,180,0]) EndSwitchBody20x11(1);

		translate([40,-18,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.31,h=50,$fn=16);
		translate([30,-18,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.31,h=50,$fn=16);
		translate([43,-11,-0.10]) 
					color("red") rotate([0,0,0]) scale([1,1,1]) cylinder(r=1.31,h=50,$fn=16);
  }
}

if( drawIndex==5 || drawIndex==0 )
{
  translate([0,0,Bearing625Height()+pulley1H+pulley2H+32+isExpolode*45]) 
  {
    height = Bearing608Height();
    difference()
    {
      color("blue") 
      union()
      {
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
            translate([0,0,0]) color("green") cylinder(d=60,h=Bearing625Height()+pulley1H+pulley2H+35+5);
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
      translate([-rodOffsetX,rodOffsetY,-23]) cylinder(r=3.2,h=35);

      translate([-rodOffsetX-0.5,rodOffsetY-10,-23]) cube([1,10,40]);

      translate([-rodOffsetX-10,rodOffsetY-5,-0]) rotate([0,90,0]) cylinder(d=3.2,h=35);

      // rods holes
      translate([rodOffsetX,rodOffsetY,-23]) cylinder(r=3.2,h=35);

      translate([rodOffsetX-0.5,rodOffsetY-10,-23]) cube([1,10,40]);

      translate([rodOffsetX-10,rodOffsetY-5,-0]) rotate([0,90,0]) cylinder(d=3.2,h=35);
    }
  }
}


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


