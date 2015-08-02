module LProfile(x=10,y=10,w=1.5,len=200)
{
	color("silver")
	{
		cube([w,len,x]);
		cube([y,len,w]);
	}
}


module CProfile(x=10,y=10,w=1.5,len=200)
{
	color("silver")
	{
		cube([w,len,x]);
		cube([y,len,w]);
		translate([y-w,0,0]) cube([w,len,x]);
	}
}

//LProfile(20,15,1.5);
CProfile(20,15,1.5);