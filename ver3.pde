class pen{
	int id;
	int x; //Pos
	int y;
	float a; //Angle facing
	float r; //Arc radius
	color c; //Pen colour
	bool dir; //Clockwise

	pen(int startx, int starty){
		x = startx;
		y = starty;
		a = random(360);
		r = random(1.5);
		dir = true;
		c = color(random(255),random(255),random(255));
	}

	pen(int startx, int starty, float starta){
		x = startx;
		y = starty;
		a = starta;
		r = random(1.5);
		dir = true;
		c = color(random(255),random(255),random(255));
	}

	pen(int startx, int starty, float starta, color fromc){
		x = startx;
		y = starty;
		if(starta != null) a = starta;
		else a = random(360);
		r = random(1.5);
		dir = true;
		c_red = random( max(0, red(fromc)-30), min(255, red(fromc)+30));
		c_green = random( max(0, green(fromc)-30), min(255, green(fromc)+30));
		c_blue = random( max(0, blue(fromc)-30), min(255, blue(fromc)+30));
		c = color(c_red, c_green, c_blue);
	}

	bool outOfBound(){
		if(x<=-5 || x>=width+5) return true;
		if(y<=-5 || y>=height+5) return true;
		return false;
	}

	void update(){
		if((int)random(50) <=0) dir = !dir; //1 in 50 chance of changing arc direction
		fill(c);
		stroke(c);		
		ellipse(x, y, 2.5, 2.5); //draw next dot

		x = x + 2*sin(radians(a)); //move pen
		y = y + 2*cos(radians(a));
		if(dir) a = a+r;
		else a = a-r;
	}
};

pen[] pens = new pen[1];

void setup() { //Initialise window and spawn pen
	size(window.innerWidth, window.innerHeight);
	background(255);
	newStartingPen();
}

void draw() {
	if(pens.length == 0 && (int)random(100) <=0) newStartingPen();
	for (int i = 0; i < pens.length; ++i){
		pens[i].update();
		if(pens[i].outOfBound()){
			int j=0;
			while((j+i)<pens.length-1){
				pens[i+j] = pens[i+j+1];
				j++;
			}
			pens = shorten(pens);
		}
	}
	if(pens.length > 0 && (int)random(100) <=0){
		int id = (int)random(pens.length-1);
		append(pens, new pen(pens[id].x, pens[id].y, null, pens[id].c));
		pens[pens.length-1].update();
	}
}

void newStartingPen(){
	int side = (int)random(2);
	int side2 = (int)random(2);
	int startingx;
	int startingy;
	float a;
	if(side){
		if(side2) a = random(45) + 247.5; //Right side
		else a = random(45) + 67.5; //Left side
		startingx = (side2) * width;
		startingy = random(height);
	}
	else{
		if(side2) a = random(45) + 157.5; //Bottom
		else a = random(45) - 22.5; //Top
		startingy = (side2) * height;
		startingx = random(width);
	};

	pens[0] = new pen(startingx, startingy, a);	
}