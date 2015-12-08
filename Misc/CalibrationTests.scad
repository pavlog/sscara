module wall(SIZE=20,isCircle=0)
{

wallTh = 0.3;
wallH = 4;
	if( !isCircle )
	{	
difference()
{
	cube([SIZE,SIZE,wallH],center=true);
	cube([SIZE-wallTh*2,SIZE-wallTh*2,wallH+1],center=true);
	}
}
else
{
difference()
{
	cylinder(r=SIZE,h=wallH);
	cylinder(r=SIZE-wallTh*2,h=wallH+1);
	}
}
}

wall(40,0);