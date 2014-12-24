boolean drawer = false; 

void setup() {
  size(800, 800);
  background(255, 255, 255);

  fill(0, 0, 0);
  ellipse(400, 400, 790, 790);

  fill(255, 0, 0);
  arc(410, 410, 730, 730, 0, HALF_PI);

  fill(0, 255, 0);
  arc(390, 410, 730, 730, HALF_PI, PI);

  fill(0, 0, 255);
  arc(390, 390, 730, 730, PI, PI+HALF_PI);

  fill(255, 255, 0);
  arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);

  drawCenter();
}

void draw() {
  int m;
  if (drawer){
    m = millis();
    flashRed();
    drawCenter();
    drawer = false;
  }
  
  if (millis() - m > 10000){
    setup();
  }
} 

void mousePressed() {
  drawer = true;
}

void drawCenter() {
  fill(0, 0, 0);
  ellipse(400, 400, 350, 350);
  
  fill(204, 204, 204);
  ellipse(400, 400, 310, 310);
  
  fill(255, 255, 255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("SIMON", 400, 400);
}


void flashRed() {
  //fill(221, 0, 72);
  fill(0,0,0);
  arc(410, 410, 730, 730, 0, HALF_PI);
  drawCenter();
}

void flashGreen() {
  fill(57, 255, 20);
  arc(390, 410, 730, 730, HALF_PI, PI);
  drawCenter();
}

void flashBlue() {
  fill(125, 249, 255);
  arc(390, 390, 730, 730, PI, PI+HALF_PI);
  drawCenter();
}

void flashYellow() {
  fill(243, 243, 21);
  ellipse(400, 400, 310, 310);
  drawCenter();
}

