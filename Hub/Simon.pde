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
    textAlign(CENTER,CENTER);
    fill(0,0,0);
    textSize(60);
    text("Welcome to Simon!",400,100);
    text("Click anywhere to start!",400,700);
    
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
    if (redClick + 600 < millis() && redClicked && playermoves.size() < levellength) {
      fill(255, 0, 0);
      arc(410, 410, 730, 730, 0, HALF_PI); 
      drawCenter();
      beep1.rewind();
      redClicked = false;
    }

    if (greenClick + 600 < millis() && greenClicked && playermoves.size() < levellength) {
      fill(0, 255, 0);
      arc(390, 410, 730, 730, HALF_PI, PI);
      drawCenter();
      beep2.rewind();
      greenClicked = false;
    }

    if (blueClick + 600 < millis() && blueClicked && playermoves.size() < levellength) {
      fill(0, 0, 255);
      arc(390, 390, 730, 730, PI, PI+HALF_PI);
      drawCenter();
      beep3.rewind();
      blueClicked = false;
    }

    if (yellowClick + 600 < millis() && yellowClicked && playermoves.size() < levellength) {
      fill(255, 255, 0);
      arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
      drawCenter();
      beep4.rewind();
      yellowClicked = false;
    }
  
    if (leveling && leveldelay <= millis()) {
      addStep();
    }
  
    if (replaying && replayDelay + 800 < millis()) {
      replay();
    }
  
    if (playermoves.size() >= levellength && ! levelup) {
      if (checkVictory()) {
        drawCheck();
        levelup = true;
      } else {
        drawX();
        newgame = true;
      }
    }
  }

  // mouseClicked() ======================================================================================================================================================================================

  void mouseClicked() {
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
    } else if (mouseX > 720 && mouseY > 780) {
      choice = 4;
    } else if (mouseX > 400 && mouseY > 400 && !leveling && !replaying && !newgame) {
      flashRed();
      playermoves.add(0);
    }  else if (mouseX < 400 && mouseY > 400 && !leveling && !replaying && !newgame) {
      flashGreen();
      playermoves.add(1);
    } else if (mouseX < 400 && mouseY < 400 && !leveling && !replaying && !newgame) {
      flashBlue();
      playermoves.add(2);
    } else if (mouseX > 400 && mouseY < 400 && !leveling && !replaying && !newgame) {
      flashYellow();
      playermoves.add(3);
    }
  }
  
  // keyPressed() ========================================================================================================================================================================================
  
  void keyPressed() {
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

  private void flashRed() {
    fill(255, 100, 115);
    arc(410, 410, 730, 730, 0, HALF_PI);
    drawCenter();
    beep1.play();
    redClicked = true;
    redClick = millis();
  }

  private void flashGreen() {
    fill(125, 255, 165);
    arc(390, 410, 730, 730, HALF_PI, PI);
    drawCenter();
    beep2.play();
    greenClicked = true;
    greenClick = millis();
  }

  private void flashBlue() {
    fill(125, 249, 255);
    arc(390, 390, 730, 730, PI, PI+HALF_PI);
    drawCenter();
    beep3.play();
    blueClicked = true;
    blueClick = millis();
  }

  private void flashYellow() {
    fill(255, 255, 160);
    arc(410, 390, 730, 730, PI+HALF_PI, 2*PI);
    drawCenter();
    beep4.play();
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
      leveldelay = millis();
    } else {
      replay(computermoves);
      leveling = false;
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
    victory.play();
    
    background(0, 0, 0);
  
    //fill(204, 204, 204);
    //ellipse(400, 400, 350, 350);
    
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
    
    fill(255,255,255);
    textSize(35);
    textAlign(CENTER, CENTER);
    text("Level Complete", 400, 460);
    fill(0, 0, 0);
    
    fill(255,255,255);
    textSize(60);
    textAlign(CENTER,CENTER);
    text("Click anywhere",400,150);
    text("to continue",400,650);
    
    victory.rewind();
  }
  
  private void drawX() {
    lose.play();
    
    background(0, 0, 0);
  
    //fill(204, 204, 204);
    //ellipse(400, 400, 350, 350);
    
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
  
    fill(255,255,255);
    textSize(35);
    textAlign(CENTER, CENTER);
    text("You Lose", 400, 460);
    fill(0, 0, 0);
    
    fill(255,255,255);
    textSize(60);
    textAlign(CENTER,CENTER);
    text("Congratulations!",400,150);
    text("You made it to level " + (levellength - 2),400,650);
    textSize(20);
    text("Click anywhere to start a new game",400,750);
    
    lose.rewind();
  }
}
    
    

