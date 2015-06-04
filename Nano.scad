use <Modules/Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
use <Modules/ISOThread.scad>
use <Modules/Bearings.scad>

m5Rclearance = 0.1;
m5Hclearance = 0.2;
b625RClearance = 0.2;

drawIndex = 1;

isExpolode = 0;
pulleyH = 9;
//cylinder(r=4,h=30);

if( drawIndex==0 ) Bearing625();

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+isExpolode*5]) color( "Silver") hex_nut(5);

if( drawIndex==1 || drawIndex==0 )
 translate([0,0,Bearing625Height()+isExpolode*10]) ArmPulley(numBigHoles=5);

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+pulleyH+isExpolode*15]) color( "Silver") hex_nut(5);

if( drawIndex==2 || drawIndex==0 )
{
	translate ([0,0,Bearing625Height()+pulleyH+1+isExpolode*15]) 
	{
		//color([0,1,0,0.1]) 
		difference()
		{
			ArmPulley(numBigHoles=3,numSmallHoles=3,smallHolesDist=12,smallHolesDia=1.55,bigHolesRadScale=0.85,bigHolesOffset=2);
			cylinder(d=rolson_hex_nut_dia(5)+2,h=rolson_hex_nut_hi(5)+m5Hclearance);
			translate ([0,0,pulleyH-Bearing625Height()])
				cylinder(r=Bearing625Diameter()/2+b625RClearance,pulleyH);
		}
		if( drawIndex!=2 ) translate ([0,0,pulleyH-Bearing625Height()]) Bearing625();
	}
}

if( drawIndex==0 ) translate ([0,0,Bearing625Height()+pulleyH+pulleyH+1+isExpolode*15]) color( "Silver") hex_nut(5);



module ArmPulley(numBigHoles=0,numSmallHoles=0,smallHolesDist=10,smallHolesDia=1.5,bigHolesRadScale=1,bigHolesOffset=0)
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
retainer_ht = 1,	// height of retainer flange over pulley, standard = 1.5
idler = 1,			// Belt retainer below teeth, 0 = No, 1 = Yes
idler_ht = 1,		// height of idler flange over pulley, standard = 1.5

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
    outerRad = (80*2/3.14*0.5);
    //echo(outerRad);
    bigHoleRad = (outerRad-5)*0.32;
    for (i = [0:numBigHoles-1]) 
    {
        rotate([0, 0, (360/numBigHoles)*i])
        translate([bigHoleRad/2+5+6+bigHolesOffset, 0, 0])
        cylinder(r=bigHoleRad*bigHolesRadScale,h=10,$fn=16);
    }
  }

  //numSmallHoles = 3;
  if( numSmallHoles )
  {
    for (i = [0:numSmallHoles-1]) 
    {
        rotate([0, 0, (360/numSmallHoles)*i+60])
        translate([smallHolesDist, 0, 0])
        cylinder(r=smallHolesDia,h=10,$fn=16);
    }
  }
}
}




