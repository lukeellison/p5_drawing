class pen{
	int id;
	int x; //Pos
	int y;
	float a; //Angle facing
	float r; //Arc radius
	color c; //Pen colour
	bool dir; //Starting arc direction

	pen(int startx, int starty){ //Constructor
		x = startx; //initialise with starting position
		y = starty;
		a = random(360); //and random other attributes
		r = random(1.5);
		dir = (int)random(2);
		c = color(random(255),random(255),random(255));
	}

	pen(int startx, int starty, float starta){ //Another constructor where the angle can also be set
		x = startx;
		y = starty;
		a = starta;
		r = random(1.5);
		dir = (int)random(2);
		c = color(random(255),random(255),random(255));
	}

	bool outOfBound(){ //For telling when the pen is off screen
		if(x<=-5 || x>=width+5) return true;
		if(y<=-5 || y>=height+5) return true;
		return false;
	}

	void update(){
		if((int)random(50) <=0) dir = !dir; //1 in 50 chance of changing arc direction
		fill(c); //change pen colour
		stroke(c);		
		ellipse(x, y, 2.5, 2.5); //draw next dot

		x = x + 2*sin(radians(a)); //move pen
		y = y + 2*cos(radians(a));
		if(dir) a = a+r;
		else a = a-r;
	}
};

pen[] pens = new pen[1]; // Create first pen

void setup() { //Initialise window and spawn pen
	size(window.innerWidth, window.innerHeight);
	background(255);
	newStartingPen();
}

void draw() { Called repeatedly to draw on page in steps
	if(pens.length == 0 && (int)random(50) <=0) newStartingPen(); //If no pens then make a new one after random delay (give you a chance to look at what was drawn)
	for (int i = 0; i < pens.length; ++i){ //update each pen
		pens[i].update();
		if(pens[i].outOfBound()){ //check if it is out of bounds
			int j=0;
			while((j+i)<pens.length-1){ //remove it from array if it is
				pens[i+j] = pens[i+j+1];
				j++;
			}
			pens = shorten(pens);
		}
	}
	if((int)random(100) <=0){ //randomly spawn new pen from existing pen (1 in 100)
		int id = (int)random(pens.length-1);
		append(pens, new pen(pens[id].x, pens[id].y));
		pens[pens.length-1].update();
	}
}

void newStartingPen(){ //create a new starting pen on the sides
	int side = (int)random(2); //Randomise the side
	int side2 = (int)random(2);
	int startingx;
	int startingy;
	float a;
	if(side){ //Choose random position and angle appropriate for that side
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

	pens[0] = new pen(startingx, startingy, a);	 //Add it to the array
}