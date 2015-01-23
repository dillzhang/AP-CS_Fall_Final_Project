import java.util.Random;
import ddf.minim.*;

class Simon extends Game {
  
  // INSTANCE VARIABLES ==================================================================================================================================================================================
  
  //Random
  private Random rand = new Random();

  //Sound
  private AudioPlayer beep1, beep2, beep3, beep4, victory, lose;

  //For flashing timing
  private int redClick = millis(), greenClick = millis(), blueClick = millis(), yellowClick = millis();
  private boolean redClicked = false, greenClicked = false, blueClicked = false, yellowClicked = false;

  //Game Play
  private ArrayList<Integer> computermoves, playermoves;
  private int levellength, leveldelay;
  private boolean leveling, levelup, newgame;

  //Replay Function
  private boolean replaying;
  private ArrayList<Integer> playing;
  private int location, replayDelay;

  // Setup() =============================================================================================================================================================================================

  void setup() {
    //Welcome Screen Setup
    size(800, 800);
    background(255,255,255);
    
    //Welcome Text
    textAlign(CENTER,CENTER);
    fill(0,0,0);
    textSize(60);
    text("Welcome to Simon!",400,100);
    text("Click anywhere to start!",400,700);
    
    
    //Mini Board for starting screen
    fill(0, 0, 0);
    ellipse(250, 400, 490, 490);

    fill(255, 0, 0);
    arc(260, 410, 430, 430, 0, HALF_PI);

    fill(0, 255, 0);
    arc(240, 410, 430, 430, HALF_PI, PI);

    fill(0, 0, 255);
    arc(240, 390, 430, 430, PI, PI+HALF_PI);

    fill(255, 255, 0);
    arc(260, 390, 430, 430, PI+HALF_PI, 2*PI);
  
    fill(0, 0, 0);
    ellipse(250, 400, 150, 150);

    fill(204, 204, 204);
    ellipse(250, 400, 110, 110);
    
    //Information about game and how to play
    fill(0,0,0);
    textSize(15);
    textAlign(LEFT,CENTER);
    text("This is Simon Says. A simple memory",510,340);
    text("game for passing the time. To play,",510,355);
    text("just memorize the pattern flashed by",510,370);
    text("the game and enter it back. To enter",510,385);
    text("one can either use the mouse and",510,400);
    text("click on the quadrants, or use the",510,415);
    text("keyboard, pressing 'h' for red, 'g'",510,430);
    text("for green,'t' for blue, and 'y' for",510,445);
    text("yellow. Have fun and enjoy the game!",510,460);

    //Sound Setup
    beep1 = loader.loadFile("Simon_beep1.mp3");
    beep2 = loader.loadFile("Simon_beep2.mp3");
    beep3 = loader.loadFile("Simon_beep3.mp3");
    beep4 = loader.loadFile("Simon_beep4.mp3");
    victory = loader.loadFile("Simon_victory.mp3");
    lose = loader.loadFile("Simon_lose.mp3");
    
    //Resets Entire GAME
    //Game Play
    computermoves = new ArrayList<Integer>();
    playermoves = new ArrayList<Integer>();
    levellength = 3; 
    leveldelay = millis();
    leveling = false;
    levelup = false;
    newgame = true;
  
    //Replay Function
    replaying = false;
    replayDelay = millis();
  }
  
  // draw() ==============================================================================================================================================================================================

  void draw() {
    //Resets red animation
    if (redClick + 600 < millis() && redClicked && playermoves.size() < levellength) { //Checks if red has been clicked, sufficient time has passed and the player could click it
      fill(255, 0, 0); //Resets selected color
      arc(410, 410, 730, 730, 0, HALF_PI); //Redraws the proper section
      
      drawCenter(); //Recreates the center
      
      beep1.rewind(); //Resets the audio file
      
      redClicked = false; //No longer clicked
    }

    //Same as above but with greens
    if (greenClick + 600 < millis() && greenClicked && playermoves.size() < levellength) {
      fill(0, 255, 0);
      arc(390, 410, 730, 730, HALF_PI, PI);
     
      drawCenter();
     
      beep2.rewind();
     
      greenClicked = false;
    }

    //Same as above but with blue
    if (blueClick + 600 < millis() && blueClicked && playermoves.size() < levellength) {
      fill(0, 0, 255);
      arc(390, 390, 730, 730, PI, PI+HALF_PI);
      drawCenter();
      beep3.rewind();
      blueClicked = false;
    }

    //Same as abouve but wuth yellow
    if (yellowClick + 600 < millis() && yellowClicked && playermoves.size() < levellength) {
      fill(255, 255, 0);
      arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
      
      drawCenter();
      
      beep4.rewind();
      
      yellowClicked = false;
    }
  
    //Checks if next step should be add yet for the leveling process
    if (leveling && leveldelay <= millis()) {
      addStep();
    }
  
    //Checks if replay should continue yet?
    if (replaying && replayDelay + 800 < millis()) {
      replay();
    }
  
    //Checks if the player has completed the level
    if (playermoves.size() >= levellength && ! levelup) {
      //If completed, check if they have won
      if (checkVictory()) {
        drawCheck(); //Show they won
        levelup = true; //Allow them to move on
      } else {
        drawX(); //Show they lose
        newgame = true; //Start of a new game
      }
    }
  }

  // mouseClicked() ======================================================================================================================================================================================

  void mouseClicked() {
    if (newgame) { //Checks if a new game should be created on click
      setupGame(); //Draws a new board

      levellength = 3; //Resets the level length
      computermoves = new ArrayList<Integer>(); //Resets the computers moves set
      
      createlevel(); //Run the creat level function
      
      newgame = false; //No longer a new game
    } else if (levelup) { //Checks if a level has been completed 
      setupGame(); //Resets the board
      levellength += 1; //Increases the level by one
      createlevel(); //Creates the new level
      levelup = false;
    } else if (mouseX > 720 && mouseY > 780) { //Checks if returning to main hub has been selected
      choice = 4;
    } else if (mouseX > 400 && mouseY > 400 && !leveling && !replaying && !newgame) { //Checks if red sector is clicked, but cannot be during leveling process or creation of a new game
      flashRed(); //Plays red animation
      playermoves.add(0); //Saves move in memory
    }  else if (mouseX < 400 && mouseY > 400 && !leveling && !replaying && !newgame) { //Same as above with green
      flashGreen();
      playermoves.add(1);
    } else if (mouseX < 400 && mouseY < 400 && !leveling && !replaying && !newgame) { //Same as above with blue
      flashBlue();
      playermoves.add(2);
    } else if (mouseX > 400 && mouseY < 400 && !leveling && !replaying && !newgame) { //Same as above with yellow
      flashYellow();
      playermoves.add(3);
    }
  }
  
  // keyPressed() ========================================================================================================================================================================================
  
  void keyPressed() { //Same function as above but associated with buttons rather than mouse locations
    if (newgame) {
      setupGame();
      levellength = 3;
      computermoves = new ArrayList<Integer>();
      createlevel();
      //lose.rewind();
      newgame = false;
    } else if (levelup) {
      setupGame();
      levellength += 1;
      createlevel();
      //victory.rewind();
      levelup = false;
    } else if (key == 'm') {
      choice = 4;
    } else if (key == 'h' && !leveling && !replaying && !newgame) {
      flashRed();
      playermoves.add(0);
    }  else if (key == 'g' && !leveling && !replaying && !newgame) {
      flashGreen();
      playermoves.add(1);
    } else if (key == 't' && !leveling && !replaying && !newgame) {
      flashBlue();
      playermoves.add(2);
    } else if (key == 'y' && !leveling && !replaying && !newgame) {
      flashYellow();
      playermoves.add(3);
    }
    
  }
  
  // METHODS =============================================================================================================================================================================================

  //~~ setupGame() ~~
  void setupGame() {
    //Board Setup
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
    
    //Adds in a box to signify a button to return to the main hub
    fill(255,255,255);
    rect(720,780,80,20);
    textSize(10);
    fill(0,0,0);
    textAlign(CENTER,CENTER);
    text("Back to Hub",760,790);
  }

  //~~ drawCenter() ~~
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

  //Animation for a button press
  private void flashRed() {
    fill(255, 100, 115); //Changes to a slightly brighter color 
    arc(410, 410, 730, 730, 0, HALF_PI); //Redraws that section in brighter color
    drawCenter(); //Restores the centerpiece 
    beep1.play(); //Plays corresponding sound
    redClicked = true; //State red has been clicked 
    redClick = millis(); //Set time for when it was clicked
  }

  private void flashGreen() { //Same as above but with green
    fill(125, 255, 165);
    arc(390, 410, 730, 730, HALF_PI, PI);
    drawCenter();
    beep2.play();
    greenClicked = true;
    greenClick = millis();
  }

  private void flashBlue() { //Same as above but with blue
    fill(125, 249, 255);
    arc(390, 390, 730, 730, PI, PI+HALF_PI);
    drawCenter();
    beep3.play();
    blueClicked = true;
    blueClick = millis();
  }

  private void flashYellow() { //Same as above but with yellow
    fill(255, 255, 160);
    arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
    drawCenter();
    beep4.play();
    yellowClicked = true;
    yellowClick = millis();
  }  

  private void playInt(int alpha) { //Function to play corresponding sector depending on a number (0:red, 1:green, 2:blue, 3:yellow)
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

  private void createlevel() { //Creates each new level
    playermoves = new ArrayList<Integer>(); //Resets the player moves to an empty arraylist 
    leveling = true; //Starts the leveling process
  }

  private void addStep() { //Adding steps for the computer
    if (computermoves.size() < levellength){ //Checks if the computer need to make more moves
      int move = rand.nextInt(4); //Selects a random move
      computermoves.add(move); //Adds said random move
      leveldelay = millis(); //Sets the time to create a delay
    } else {
      replay(computermoves); //Replays all the computer moves once the series has been assembled
      leveling = false; //Stops the leveling process
    }
  }

  private boolean checkVictory() { //Checks if a player has completed a level
    return computermoves.equals(playermoves); //Checks if the computer's sequence of moves is the same as the player's sequence of moves
  }

  private void replay(ArrayList<Integer> alpha) { //Replays a series of moves
    replaying = true; //Starts the replaying process
    playing = alpha; //Sets a global variable to be the series to be replayed
    location = 0; //Sets a global to determine the location in the series
    replayDelay = millis(); //Sets the time to allow for delay between each step
  }
  
  private void replay() { //Actual replaying process
    if (location < playing.size()) { //Checks for any moves left to replay
      playInt(playing.get(location)); //Replays the moves at a specified location
      location += 1; //Moves the location one to the right
      replayDelay = millis(); //Resets the delay
    } else {
    replaying = false; //Ends the replaying process
    }
  }

  private void drawCheck() { //Shows level completion status
    victory.play(); //Plays victory sound
    
    background(0, 0, 0); //Wipes the screen clean
    
    //Draws a backwards L to rotate into a check mark
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
    
    //Text for level completion
    fill(255,255,255);
    textSize(35);
    textAlign(CENTER, CENTER);
    text("Level Complete", 400, 460);
    fill(0, 0, 0);
    
    //Text for continuation instructions
    fill(255,255,255);
    textSize(60);
    textAlign(CENTER,CENTER);
    text("Click anywhere",400,150);
    text("to continue",400,650);
    
    //Resets the victory sound
    victory.rewind();
  }
  
  private void drawX() { //Show level lose status
    lose.play(); //Plays lose noise
    
    background(0, 0, 0); //Wipes the screen clean
  
    //Draws a plus to rotate into an X
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
  
    //Text to show lose
    fill(255,255,255);
    textSize(35);
    textAlign(CENTER, CENTER);
    text("You Lose", 400, 460);
    fill(0, 0, 0);
    
    //Text for new game instructions
    fill(255,255,255);
    textSize(60);
    textAlign(CENTER,CENTER);
    text("Congratulations!",400,150);
    text("You made it to level " + (levellength - 2),400,650);
    textSize(20);
    text("Click anywhere to start a new game",400,750);
    
    //Resets the lose sound
    lose.rewind();
  }
}
    
    

