//Pen variables
int x; //Pos
int y;
float a; //Angle facing
float r; //Arc radius
bool dir; //Clockwise

void setup() { //Initialise window and spawn pen
	size(window.innerWidth, window.innerHeight);
	background(255);
	randomNew();
}

void draw() {
	//Check if pen off screen if so spawn new pen
	if(x<=-5 || x>=width+5) randomNew();
	if(y<=-5 || y>=height+5) randomNew();

	if((int)random(50) <=0) dir = !dir; //1 in 51 chance of changing arc direction

	ellipse(x, y, 2.5, 2.5); //draw next dot

	x = x + 2*sin(radians(a)); //move pen
	y = y + 2*cos(radians(a));
	if(dir) a = a+r;
	else a = a-r;
}

void randomNew() { //Function for spawing new pen randomises all pen variables
	x = random(width);
	y = random(height);
	a = random(360);
	r = random(1.5);
	dir = true;
	color c = color(random(255),random(255),random(255));
	fill(c);
	stroke(c);
}