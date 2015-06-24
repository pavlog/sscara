function radius_to_balls(r_ball, r) = 180 / asin(r_ball / r);
function ball_to_radius(n, r) = r * sin(180 / n);

sphereFn = 8;//45
cylinderFn = 18;//45
genPin = 0;
module Bearing(outer, inner, attempt, gap, hole, height) 
{
	n = round(radius_to_balls(attempt, inner));
	r = ball_to_radius(n, inner);
	theta = 360 / n;
	pinRadius = 0.5 * r;
	// The pins:
	for(i = [0 : n])
		rotate(a = [0, 0, theta * i])
			translate([inner, 0, 0])
				union() {/*
					sphere(r = r - gap, center = true, $fn = 45); */
					sphere(r = r - 0.5*gap, center = true, $fn = sphereFn);
					assign(rad = pinRadius - gap)
	if( genPin )
	{
		cylinder(r1 = rad, r2 = rad, h = height, center = true, $fn = cylinderFn);
	}
				}
	// The inner race:
	difference() 
	{
		assign(rad = inner - pinRadius - gap)
			cylinder(r1 = rad, r2 = rad, h = height, center = true, $fn = cylinderFn);
		rotate_extrude(convexity = 10)
			translate([inner, 0, 0])
				circle(r = r + gap, $fn = 30);
		cylinder(r1 = hole, r2 = hole, h = height + 5, center = true, $fn = cylinderFn);
	}
	// The outer race:
	difference() 
	{
		cylinder(r1 = outer, r2 = outer, h = height, center = true, $fn = cylinderFn);
		assign(rad = inner + pinRadius + gap)
			cylinder(r1 = rad, r2 = rad, h = height + 5, center = true, $fn = cylinderFn);
		rotate_extrude(convexity = 10)
			translate([inner, 0, 0])
				circle(r = r + gap, $fn = 45);
	}
}
module Bearing625()
{
  translate ([0,0,2.5]) color ("silver") Bearing(outer = 8, inner = 5, attempt = 1.5, gap = 0.2, height = 5, hole = 2.5);
}

function Bearing625Height() = 5;
function Bearing625Diameter() = 16;

module Bearing623()
{
  translate ([0,0,2]) color ("silver") Bearing(outer = 5, inner = 3, attempt = 1.5, gap = 0.2, height = Bearing623Height(), hole = 1.5);
}

function Bearing623Height() = 4;
function Bearing623Diameter() = 10;

module Bearing608()
{
  translate ([0,0,3.5]) color ("silver") Bearing(outer = Bearing608Diameter()/2, inner = 7, attempt = 2, gap = 0.2, height = Bearing608Height(), hole = 4);
}
function Bearing608Height() = 7;
function Bearing608Diameter() = 22;

module Bearing6800()
{
  translate ([0,0,2.5]) color ("silver") Bearing(outer = Bearing608Diameter()/2, inner = 8, attempt = 2, gap = 0.2, height = Bearing6800Height(), hole = 5);
}
function Bearing6800Height() = 5;
function Bearing6800Diameter() = 19;

module BearingLM6UU()
{
  color ("silver") 
	{
		difference()
	{
		cylinder(d=12,h=19);
		translate([0,0,-1]) cylinder(d=6,h=19+2);
	}
	}
}
function BearingLM6UUHeight() = 19;
function BearingLM6UUDiameter() = 12;


Bearing625();
translate ([0,0,20]) Bearing623();
translate ([0,0,40]) Bearing608();
translate ([0,0,60]) Bearing6800();
translate ([0,0,80]) BearingLM6UU();
