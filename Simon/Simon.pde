private Boolean redClick = false, greenClick = false, blueClick = false, yellowClick = false; 

void setup() {
  size(800, 800);
  background(204, 204, 204);

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

void mouseClicked() {
  if (mouseX > 400 && mouseY > 400){
    flashRed();
  } else if (mouseX < 400 && mouseY > 400){
    flashGreen();
  } else if (mouseX < 400 && mouseY < 400){
    flashBlue();
  } else if (mouseX > 400 && mouseY < 400){
    flashYellow();
  }
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

void keyPressed(){
}

private void flashRed() {
  fill(255, 100, 115);
  //fill(0,0,0);
  arc(410, 410, 730, 730, 0, HALF_PI);
  drawCenter();
}

private void flashGreen() {
  fill(125, 255, 165);
  //fill(0,0,0);
  arc(390, 410, 730, 730, HALF_PI, PI);
  drawCenter();
}

private void flashBlue() {
  fill(125, 249, 255);
  //fill(0,0,0);
  arc(390, 390, 730, 730, PI, PI+HALF_PI);
  drawCenter();
}

private void flashYellow() {
  fill(255, 255, 160);
  //fill(0,0,0);
  arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
  drawCenter();
}

void draw() {
}
