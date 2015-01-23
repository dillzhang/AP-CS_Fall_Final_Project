import java.util.Random;
import ddf.minim.*;

//INSTANCE VARIABLES =====================================================================================================================================================================================

//Random
private Random rand = new Random();

//Sound
private Minim loader;
private AudioPlayer beep1, beep2, beep3, beep4, victory, lose;

//For flashing timing
private int redClick = millis(), greenClick = millis(), blueClick = millis(), yellowClick = millis();
private boolean redClicked = false, greenClicked = false, blueClicked = false, yellowClicked = false;

//Game Play
private ArrayList<Integer> computermoves = new ArrayList<Integer>(), playermoves = new ArrayList<Integer>();
private int levellength = 3, leveldelay = millis();
private boolean leveling = false, levelup = false, newgame = true;

//Replay Function
private boolean replaying = false;
private ArrayList<Integer> playing;
private int location, replayDelay = millis();

//SETUP ==================================================================================================================================================================================================

void setup() {
  //Welcome Screen Setup
  size(800, 800);
  background(255,255,255);
  
  // Welcoming Text
  textAlign(CENTER,CENTER);
  fill(0,0,0);
  textSize(60);
  text("Welcome to Simon!",400,100);
  text("Click anywhere to start!",400,700);
  
  //Mini Board
  fill(0, 0, 0);
  ellipse(400, 400, 490, 490);

  fill(255, 0, 0);
  arc(410, 410, 430, 430, 0, HALF_PI);

  fill(0, 255, 0);
  arc(390, 410, 430, 430, HALF_PI, PI);

  fill(0, 0, 255);
  arc(390, 390, 430, 430, PI, PI+HALF_PI);

  fill(255, 255, 0);
  arc(410, 390, 430, 430, PI+HALF_PI, 2*PI);
  
  fill(0, 0, 0);
  ellipse(400, 400, 150, 150);

  fill(204, 204, 204);
  ellipse(400, 400, 110, 110);

  //Sound Setup
  loader = new Minim(this);
  beep1 = loader.loadFile("beep1.mp3");
  beep2 = loader.loadFile("beep2.mp3");
  beep3 = loader.loadFile("beep3.mp3");
  beep4 = loader.loadFile("beep4.mp3");
  victory = loader.loadFile("victory.mp3");
  lose = loader.loadFile("lose.mp3");
}

//MOUSECLICKED ===========================================================================================================================================================================================


void mouseClicked() {
  if (newgame) { //Checks for a new game in order to reset when the mouse is clicked
    
    setupGame();  //Draws new board
    levellength = 3; //Resets the level size
    computermoves = new ArrayList<Integer>(); //Deletes old level saves
    createlevel(); //Creates a new level
    
    newgame = false; //No longer a new game
  
  } else if (levelup) { //Checks if a level has been completed
    
    setupGame(); //Reset the board
    levellength += 1; //Increases the size of the level
    createlevel(); //Creates the new level
    
    levelup = false; //No longer leveling up
   
   //Checks which quadrant the mouse is in, and prevents clicking while the level is shown to the player
   //When a quadrant is clicked, the corresponding animation is called and the move is recorded
  } else if (mouseX > 400 && mouseY > 400 && !leveling && !replaying) {
    flashRed();
    playermoves.add(0);
  } else if (mouseX < 400 && mouseY > 400 && !leveling && !replaying) {
    flashGreen();
    playermoves.add(1);
  } else if (mouseX < 400 && mouseY < 400 && !leveling && !replaying) {
    flashBlue();
    playermoves.add(2);
  } else if (mouseX > 400 && mouseY < 400 && !leveling && !replaying) {
    flashYellow();
    playermoves.add(3);
  }
}

//DRAW ===================================================================================================================================================================================================

void draw() { //Continuously runs the following
  //Checks if red has been clicked and it has been 600 milliseconds since the clicked occured and the player has less moves than the level length (Process is the same for all the colors below)
  if (redClick + 600 < millis() && redClicked && playermoves.size() < levellength) {
    fill(255, 0, 0); //Resets the fill to the proper color
    arc(410, 410, 730, 730, 0, HALF_PI);  //Draws the area in the proper shade
    
    drawCenter(); //Redraws the middle circles with logo
    
    beep1.rewind(); //Resets the audio played by the button press
    
    redClicked = false; //No longer has been clicked
  }
  
  //Same as previous but with green
  if (greenClick + 600 < millis() && greenClicked && playermoves.size() < levellength) {
    fill(0, 255, 0);
    arc(390, 410, 730, 730, HALF_PI, PI);
    
    drawCenter();
    
    beep2.rewind();
    
    greenClicked = false;
  }
  
  //Same as previous but with blue
  if (blueClick + 600 < millis() && blueClicked && playermoves.size() < levellength) {
    fill(0, 0, 255);
    arc(390, 390, 730, 730, PI, PI+HALF_PI);
    
    drawCenter();
    
    beep3.rewind();
    
    blueClicked = false;
  }

  //Same as previous but with yellow
  if (yellowClick + 600 < millis() && yellowClicked && playermoves.size() < levellength) {
    fill(255, 255, 0);
    arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
    
    drawCenter();
    
    beep4.rewind();
    
    yellowClicked = false;
  }
  
  //Checks if a leveling has been called and that a proper delay has occured
  if (leveling && leveldelay <= millis()) {
    addStep(); //adds a step
  }
  
  //Checks if a replay has been called and that a proper delay has already occured
  if (replaying && replayDelay + 800 < millis()) {
    replay(); //Reruns replay
  }
  
  //Checks if the player has made enough moves for the level and no new level is currently being created
  if (playermoves.size() >= levellength && ! levelup) {
    //Checks if the player has beat the level
    if (checkVictory()) {
      drawCheck(); //Draws a check
      levelup = true; //Allows the next level to be created
    } else {
      drawX(); //Draws an X
      newgame = true; //Causes a new game to start
    }
  }
}

//METHODS ================================================================================================================================================================================================

void setupGame() {
  //Board Setup
  background(204, 204, 204);

  //Full Board Setup
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

void drawCenter() {
  //Drawing the center circle with text
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
  //Runs a red flash animation (Same for other colors below)
  fill(255, 100, 115); //Sets color to a brighter shade
  arc(410, 410, 730, 730, 0, HALF_PI); //Fills the area with the brighter shade
  drawCenter(); //Recreates the center circle with text
  
  beep1.play(); //Plays corresponding sound
  
  redClicked = true; //Set that the red has been clicked (Important for unclicking animation in draw())
  
  redClick = millis(); //Sets the time when red was clicked (Important for delays)
}

private void flashGreen() {
  //Same as previous except with green
  fill(125, 255, 165);
  arc(390, 410, 730, 730, HALF_PI, PI);
  drawCenter();
  
  beep2.play();
  
  greenClicked = true;
  
  greenClick = millis();
}

private void flashBlue() {
  //Same as previous except with blue
  fill(125, 249, 255);
  arc(390, 390, 730, 730, PI, PI+HALF_PI);
  drawCenter();
  
  beep3.play();
  
  blueClicked = true;
  
  blueClick = millis();
}

private void flashYellow() {
  //Same as previous except with yellow
  fill(255, 255, 160);
  arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
  drawCenter();
  
  beep4.play();
  
  yellowClicked = true;
  
  yellowClick = millis();
}

private void playInt(int alpha) {
  //Plays the corresponding animation to a number (0:red, 1:green, 2:blue; 3:yellow)
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
  //Creating a new level
  playermoves = new ArrayList<Integer>(); //Resets the player's moves to an empty arraylist (To be filled again by the player in the next level)
  leveling = true; //Says leveling is occuring
}

private void addStep() {
  //Adds the moves for the computer's list
  if (computermoves.size() < levellength){ //Checks if computer is missing moves
    int move = rand.nextInt(4); //Selects a random move
    computermoves.add(move); //Adds selected move to the list of moves for the computer
    leveldelay = millis(); //Sets the level delay (Timing purposes, doesnt perform all moves at once)
  } else {
    replay(computermoves); //Replays the entire list of computer's moves 
    leveling = false; //Stops the leveling process
  }
}

private boolean checkVictory() {
  //Checks for a level completion
  return computermoves.equals(playermoves); //Sees if the player's moves is the same as the moves played by the computer
}

private void replay(ArrayList<Integer> alpha) {
  replaying = true; //Starts the replaying process
  playing = alpha; //Sets a global variable to the series that should be replayed
  location = 0; //Sets a counter to determine what part of the series it has reached
  replayDelay = millis(); //Marks the start time for delay purposes
}
  
private void replay() {
  //Replay function
  if (location < playing.size()) { //Checks if the playing location is still within the series being played
    playInt(playing.get(location)); //plays the corresponding value at said location
    location += 1; //Moves the location along
    replayDelay = millis(); //Resets the timing for delay
  } else {
    replaying = false; //Once we finish the series, we stop replaying
  }
}

private void drawCheck() { //Shows level completion
  victory.play(); //Plays winning noise
  
  background(0, 0, 0); //Cleans the screen

  //Draw a checkmark, originally a backwards L, but is then rotated
  pushMatrix();
  translate(420, 290);
  rotate(radians(45));
  fill(0,255,0);
  stroke(255,255,255);
  strokeWeight(10);
  rect(0, 80, 80, 40);
  rect(41,0,40,120);
  noStroke();
  rect(5,85,70,30);
  stroke(0);
  strokeWeight(1);
  popMatrix();
  
  //Writes a level complete message
  fill(255,255,255);
  textSize(35);
  textAlign(CENTER, CENTER);
  text("Level Complete", 400, 460);
  fill(0, 0, 0);
  
  //Writes instructions on how to continue
  fill(255,255,255);
  textSize(60);
  textAlign(CENTER,CENTER);
  text("Click anywhere",400,150);
  text("to continue",400,650);
  
  //Resets level completion sound
  victory.rewind();
}

private void drawX() { //Shows level failure
  lose.play(); //Plays losing sound
  
  background(0, 0, 0); //Cleans the screen

  //Draws an X, originally a plus, but is then rotated
  pushMatrix();
  translate(400,280);
  rotate(radians(45));
  fill(255,0,0);
  stroke(255,255,255);
  strokeWeight(10);
  rect(0,40,120,40);
  rect(41,0,40,120);
  noStroke();
  rect(5,45,110,30);
  stroke(0);
  strokeWeight(1);
  popMatrix();

  //Writes Lose message
  fill(255,255,255);
  textSize(35);
  textAlign(CENTER, CENTER);
  text("You Lose", 400, 460);
  fill(0, 0, 0);
  
  //Writes instruction to proceed
  fill(255,255,255);
  textSize(60);
  textAlign(CENTER,CENTER);
  text("Congratulations!",400,150);
  text("You made it to level " + (levellength - 2),400,650);
  textSize(20);
  text("Click anywhere to start a new game",400,750);
  
  lose.rewind(); //Resets lose sound
}
  
  

