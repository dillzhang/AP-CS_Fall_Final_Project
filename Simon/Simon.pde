import java.util.Random;

private Random rand = new Random();

private int redClick = millis(), greenClick = millis(), blueClick = millis(), yellowClick = millis();


private int lengths;
private Boolean levelup;
private ArrayList<Integer> computermoves = new ArrayList<Integer>(), playermoves = new ArrayList<Integer>();



void setup() {
  
  //Board Setup
  size(800, 800);
  background(204, 204, 204);
  
  fill(255,255,255);
  rect(0,0,20,5);

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
  
  //Game Play Setup
  lengths = 3;
  levelup = true;  
}

void mouseClicked() {
  if (mouseX < 20 && mouseY < 5){
    createLevel();
  } else if (mouseX > 400 && mouseY > 400){
    flashRed();
  } else if (mouseX < 400 && mouseY > 400){
    flashGreen();
  } else if (mouseX < 400 && mouseY < 400){
    flashBlue();
  } else if (mouseX > 400 && mouseY < 400){
    flashYellow();
  }
}

void draw() {
  if (redClick + 750 < millis()) {
    fill(255, 0, 0);
    arc(410, 410, 730, 730, 0, HALF_PI); 
    drawCenter();
  }
  
  if (greenClick + 750 < millis()) {
    fill(0, 255, 0);
    arc(390, 410, 730, 730, HALF_PI, PI);
    drawCenter();
  }
  
  if (blueClick + 750 < millis()) {
    fill(0, 0, 255);
    arc(390, 390, 730, 730, PI, PI+HALF_PI);
    drawCenter();
  }
  
  if (yellowClick + 750 < millis()) {
    fill(255, 255, 0);
    arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
    drawCenter();
  }
}

void delay(int delay) {
  int time = millis();
  while(millis() - time <= delay) {
    };
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

private void flashRed() {
  fill(255, 100, 115);
  arc(410, 410, 730, 730, 0, HALF_PI);
  drawCenter();
  redClick = millis();
}

private void flashGreen() {
  fill(125, 255, 165);
  arc(390, 410, 730, 730, HALF_PI, PI);
  drawCenter();
  greenClick = millis();
}

private void flashBlue() {
  fill(125, 249, 255);
  arc(390, 390, 730, 730, PI, PI+HALF_PI);
  drawCenter();
  blueClick = millis();
}

private void flashYellow() {
  fill(255, 255, 160);
  arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
  drawCenter();
  yellowClick = millis();
}

private void createLevel() {
  println("level");
  for (int i = 0; i < lengths; i++) {
    
    int move = rand.nextInt(4);
    computermoves.add(move);
    
    if (move == 0) {
      flashRed();
    } else if (move == 1) {
      flashGreen();
    } else if (move == 2) {
      flashBlue();
    } else {
      flashYellow();
    }
  }
  println(computermoves);
}
    
    
