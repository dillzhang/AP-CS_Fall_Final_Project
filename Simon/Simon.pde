import java.util.Random;

//Random
private Random rand = new Random();

//For flashing timing
private int redClick = millis(), greenClick = millis(), blueClick = millis(), yellowClick = millis();
private boolean redClicked = false, greenClicked = false, blueClicked = false, yellowClicked = false;
//Game Play
private ArrayList<Integer> computermoves = new ArrayList<Integer>(), playermoves = new ArrayList<Integer>();
private int levellength = 3, leveldelay = millis();
private boolean leveling = false, loser = false;

//Replay Function
private boolean replaying = false;
private ArrayList<Integer> playing;
private int location, replayDelay = millis();

void setup() {

  //Board Setup
  size(800, 800);
  background(204, 204, 204);

  fill(255, 255, 255);
  rect(0, 0, 20, 20);
  rect(20,0,20,20);

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
}

void mouseClicked() {
  if (mouseX < 20 && mouseY < 20) {
    createlevel();
  } else if (mouseX < 40 && mouseY < 20) {
    drawX();
    //replay(computermoves);
  }else if (mouseX > 400 && mouseY > 400) {
    flashRed();
    playermoves.add(0);
  } else if (mouseX < 400 && mouseY > 400) {
    flashGreen();
    playermoves.add(1);
  } else if (mouseX < 400 && mouseY < 400) {
    flashBlue();
    playermoves.add(2);
  } else if (mouseX > 400 && mouseY < 400) {
    flashYellow();
    playermoves.add(3);
  }
}

void draw() {
  if (redClick + 750 < millis() && redClicked && playermoves.size() < levellength) {
    fill(255, 0, 0);
    arc(410, 410, 730, 730, 0, HALF_PI); 
    drawCenter();
    redClicked = false;
  }

  if (greenClick + 750 < millis() && greenClicked && playermoves.size() < levellength) {
    fill(0, 255, 0);
    arc(390, 410, 730, 730, HALF_PI, PI);
    drawCenter();
    greenClicked = false;
  }

  if (blueClick + 750 < millis() && blueClicked && playermoves.size() < levellength) {
    fill(0, 0, 255);
    arc(390, 390, 730, 730, PI, PI+HALF_PI);
    drawCenter();
    blueClicked = false;
  }

  if (yellowClick + 750 < millis() && yellowClicked && playermoves.size() < levellength) {
    fill(255, 255, 0);
    arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
    drawCenter();
    yellowClicked = false;
  }
  
  if (leveling && leveldelay + 1000 < millis()) {
    addStep();
  }
  
  if (replaying && replayDelay + 1000 < millis()) {
    replay();
  }
  
  if (playermoves.size() >= levellength) {
    if (checkVictory()) {
      drawCheck();
    } else {
      drawX();
    }
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

private void flashRed() {
  fill(255, 100, 115);
  arc(410, 410, 730, 730, 0, HALF_PI);
  drawCenter();
  redClicked = true;
  redClick = millis();
}

private void flashGreen() {
  fill(125, 255, 165);
  arc(390, 410, 730, 730, HALF_PI, PI);
  drawCenter();
  greenClicked = true;
  greenClick = millis();
}

private void flashBlue() {
  fill(125, 249, 255);
  arc(390, 390, 730, 730, PI, PI+HALF_PI);
  drawCenter();
  blueClicked = true;
  blueClick = millis();
}

private void flashYellow() {
  fill(255, 255, 160);
  arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
  drawCenter();
  yellowClicked = true;
  yellowClick = millis();
}

private void playInt(int alpha) {
  if (alpha == 0) {
    flashRed();
  } else if (alpha == 1) {
    flashGreen();
  } else if (alpha == 2) {
    flashBlue();
  } else {
    flashYellow();
  }
}

private void createlevel() {
  playermoves = new ArrayList<Integer>();
  leveling = true;
}

private void addStep() {
  if (computermoves.size() < levellength){
    int move = rand.nextInt(4);
    computermoves.add(move);
    playInt(move);
    leveldelay = millis();
  }
}

private boolean checkVictory() {
  return computermoves.equals(playermoves);
}

private void replay(ArrayList<Integer> alpha) {
  replaying = true;
  playing = alpha;
  location = 0;
  replayDelay = millis();
}
  
private void replay() {
  if (location < playing.size()) {
    playInt(playing.get(location));
    location += 1;
    replayDelay = millis();
  } else {
    replaying = false;
  }
}

private void drawCheck() {
  pushMatrix();
  translate(420, 320);
  rotate(radians(45));
  fill(0,255,0);
  strokeWeight(10);
  rect(0, 80, 80, 40);
  rect(41,0,40,120);
  noStroke();
  rect(5,85,70,30);
  stroke(0);
  strokeWeight(1);
  popMatrix();
}

private void drawX() {
  fill(0, 0, 0);
  ellipse(400, 400, 350, 350);

  fill(204, 204, 204);
  ellipse(400, 400, 310, 310);
  
  pushMatrix();
  translate(400,280);
  rotate(radians(45));
  fill(255,0,0);
  strokeWeight(10);
  rect(0,40,120,40);
  rect(41,0,40,120);
  noStroke();
  rect(5,45,110,30);
  stroke(0);
  strokeWeight(1);
  popMatrix();

  fill(0);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("You Lose", 400, 460);
}
  
  

