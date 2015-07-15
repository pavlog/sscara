wallTh = 0.3;
wallH = 7;
difference()
{
	cube([20,20,wallH],center=true);
	cube([20-wallTh*2,20-wallTh*2,wallH+1],center=true);
}