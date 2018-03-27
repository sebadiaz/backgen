int maxTime = 400;
int strokesPerFrame = 25;

// Add your image here and on line 1 to preload it properly. https://www.openprocessing.org/sketch/400566
// Works best with images that don't exceed 700px.
String[] imgNames = {"emma.jpg", "obama.jpg", "clint.jpg"};

PImage img;
int imgIndex = -1;
float brightnessShift;


void setup() {
  size(950, 700);
  colorMode(HSB, 255);
  nextImage();
}


void draw() {
  translate(width/2, height/2);
  
	for (int i = 0; i < strokesPerFrame; i++) {
		// Pick a random pixel.
		int index = int(random(img.width*img.height));
		
		// Get pixel's color and coordinates.
		color pixelColor = img.pixels[index];
		pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 255);

		int x = index%img.width;
		int y = index/img.width;
		
		// Move image to center canvas.
		pushMatrix();
		translate(x-img.width/2, y-img.height/2);
		
		if (frameCount % 5 == 0) {
			// Paint big dots once in a while.
			paintDot(pixelColor, (int)(random(2, 20)*map(frameCount, 0, maxTime, 1, 0.5))/10);
		} else {
			// Paint a stroke.
			paintStroke(random(50, 250), pixelColor, (int)(random(2, 8)*map(frameCount, 0, maxTime, 1, 0.1)), map(frameCount, 0, maxTime, 40, 5)/10.0*random(1.0));
		}

		popMatrix();
	}
	
	// Stop drawing once it exceeds the time.
  if (frameCount > maxTime) {
    noLoop();
  }
}


void mousePressed() {
  nextImage();
}


void nextImage() {
	// Reset values.
  background(255);
  loop();
  frameCount = 0;
	
	// Make shift random so hues aren't always the same.
  brightnessShift = random(255);
	
	// Load the next image.
  imgIndex++;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }
	
  img = loadImage(imgNames[imgIndex]);
  img.loadPixels();
}


void paintStroke(float strokeLength, color strokeColor, int strokeThickness, float length) {
	float b = brightness(strokeColor);
	
	float bShift = b+brightnessShift;
	if (bShift > 255) {
		bShift -= 255;
	}
	
	pushMatrix();
	// Map pixel's brightness to determine the stroke's direction.
	rotate(radians(map(b, 0, 255, -180, 180)));
	
	// Draw a dark stroke.
	stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 0, 100), 50);
	line(-length, 1, length, 1);
	
	// Draw a normal stroke.
	stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 0, 255));
  strokeWeight(strokeThickness);
	line(-length, 0, length, 0);
	
	// Draw a lighter stroke.
	stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 150, 255), 20);
	line(-length, 2, length, 2);
	
	popMatrix();
}


void paintDot(color strokeColor, int strokeThickness) {
	float b = brightness(strokeColor);
	
	float bShift = b+brightnessShift;
	if (bShift > 255) {
		bShift -= 255;
	}
	
	pushMatrix();
	// Map pixel's brightness to determine the stroke's direction.
	rotate(radians(random(-180, 180)));
	
	// Draw a stroke with short length.
	stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 0, 255));
	strokeWeight(strokeThickness);
	line(0, 0, 5, 0);
	
	popMatrix();
}
