SIZE = 60;
wallTh = 0.3;
wallH = 4;
difference()
{
	cube([SIZE,SIZE,wallH],center=true);
	cube([SIZE-wallTh*2,SIZE-wallTh*2,wallH+1],center=true);
}