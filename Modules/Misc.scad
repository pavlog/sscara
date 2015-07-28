include <MCAD/stepper.scad>
use <Pulley_T-MXL-XL-HTD-GT2_N-tooth.scad>
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
