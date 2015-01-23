import java.util.Random;
import java.util.Arrays;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Instance Variables ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Trouble extends Game {
  /*
    The 2d arrays of basic, yellowPath, bluePath, redPath, and greenPath are the locations of the cirles
    that the pieces of the board game would follow. It is hard-coded in because this would never change
    for any color or for any reason. Also, there may have been an easier way by using math but my math
    skills are not high enough. 
  */
  private int[][] basic = new int[][]{{770,400},{757,496},{720,585},{662,662}, {585,720}, {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}};
  
  private int[][] yellowPath = new int[][] {{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585},{662,662}, {585,720},{496,757},{400,770},{304,757},{215,720},{138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80}};
  
  private int[][] bluePath = new int[][] {{662,662}, {585,720},{496,757},{400,770},{304,757},{215,720},{138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585}};
  
  private int[][] redPath = new int[][] { {138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585}, {662,662}, {585,720},{496,757},{400,770},{304,757},{215,720}};
  
  private int[][] greenPath = new int[][] { {138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585}, {662,662}, {585,720},{496,757},{400,770},{304,757},{215,720}, {138,662},{80,585},{43,496},{30,400},{43,304},{80,215}};
  
  //this is used to keep track of each player's info
  private int[][] pInfo = new int[4][3];
  
  //this keeps track of the order of the game
  private int[] order = new int[4];
  
  /*
    Most of the boolean variables are just used to keep track of certain that happen. circle is used
    to alternate between drawing an ellipse and writing a number when rolling (flashing). clicked
    checks if one has clicked on a certain thing and is used to prevent further clicking as the 
    the event is happening. 
  */
  
  private boolean clicked, circle, home;
  
  /*
    gPlayer, yPlayer, rPlayer, and bPlayer are used to keep track of what players have been assigned
    an order
  */
  private boolean gPlayer,yPlayer,rPlayer,bPlayer;
  
  //roll is used for keeping track of what number has been rolled while the flashR is flashing
  //time is used keep track of time when the flashR is flashing
  //level is to keep track of what part of the game the user is currently at
  //maxTurn is the maxinum number of turns
  private int roll, time,level, maxTurn;
  
  //turn keeps track of whose turn it is
  private int turn;
  
  
  //self-explained
  private Random r = new Random();
  
  //setup resets the whole game and all the necessary variables
  void setup(){
      size(800,800);
      frameRate(30);
      PFont font;
      font = createFont("bubble.ttf",200);
      textFont(font);
      level = 0;
      // drawBoard();
      for (int x = 0; x < 4; x++){
          order[x] = 10;
  	for (int y = 0; y < 3; y++){
  	    if (y == 0) pInfo[x][y] = 1;
              else if (y == 1) pInfo[x][y] = 10;
  	    else pInfo[x][y] = -1;
  	}
      }
      gPlayer = yPlayer = rPlayer = bPlayer = clicked = circle = false;
      turn = 0;
      maxTurn = 0;
      promptNewGame();
  }
  
  //drawBoard draws the board in the fancy colors
  private void drawBoard(){
      textAlign(BASELINE);
      stroke(15,140,20);
      fill(15,140,20);
      rect(0,0,400,400);
      stroke(255,215,20);
      fill(255,215,20);
      rect(400,0,400,400);
      stroke(200,0,10);
      fill(200,0,10);
      rect(0,400,400,400);
      stroke(0,50,220);
      fill(0,50,220);
      rect(400,400,400,400);
      fill(25);
      stroke(25);
      ellipse(400,400,800,800);
      fill(220,135,20);
      ellipse(400,400,625,625);
      fill(64,0,128);
      arc(450,400,550,550,-QUARTER_PI,QUARTER_PI);
      arc(400,450,550,550,QUARTER_PI,(3)*QUARTER_PI);
      arc(350,400,550,550,3*QUARTER_PI,5*QUARTER_PI);
      arc(400,350,550,550,5*QUARTER_PI,7*QUARTER_PI);  
      fill(205);
      stroke(0);
      strokeWeight(5);
      ellipse(400,400,200,200);
      for (int x = 0; x < 24; x++){
  	ellipse(basic[x][0],basic[x][1],40,40);
      }
      textSize(30);
      fill(0,50,220);
      text('S',655,675);
      fill(200,0,10);
      text('S',130,675);
      fill(15,140,20);
      text('S',130,150);
      fill(255,215,20);
      text('S',655,150);
      fill(255,0,0);
      if (level == 3) reDrawPieces();
  }
  
  
  private void reDrawPieces(){
      for (int x = 0; x < 4; x++){
  	int loc = pInfo[x][2];
  	if (x == 0 && loc != -1 && loc < 24){
  	    fill(15,140,25);
  	    ellipse(greenPath[loc][0],greenPath[loc][1],40,40);
  	}
  	if (x == 1 && loc != -1 && loc < 24){
  	    fill(255,215,20);
  	    ellipse(yellowPath[loc][0],yellowPath[loc][1],40,40);
  	}
  	if (x == 2 && loc != -1 && loc < 24){
  	    fill(200,0,10);
  	    ellipse(redPath[loc][0],redPath[loc][1],40,40);
  	}
  	if (x == 3 && loc != -1 && loc < 24){
  	    fill(0,50,220);
  	    ellipse(bluePath[loc][0],bluePath[loc][1],40,40);
  	}
      }
  }
  
  //this is the first start screen that appears upon startup
  private void promptNewGame(){
      stroke(0);
      fill(0);
      rect(0,0,800,800);
      fill(255);
      textAlign(CENTER,TOP);
      textSize(100);
      text("TROUBLE",400,0);
      textSize(50);
      fill(230,230,0);
      text("Start a New Game",400,110);
      fill(255);
      text("How many players are playing?",400,170);
      textSize(30);
      fill(0,50,220);
      text("Click to Change Settings",400,245);
      textSize(150);
  }
  
  //this is a simple switcher that helps showPlayers to determine
  //what should be shown: AI, N/A, or P (person)
  private void choosePlayer(int player){
      int loc = player -1;
      if (pInfo[loc][0] == 0){
  	pInfo[loc][0] = 1;
      } else if (pInfo[loc][0] == 1){
  	pInfo[loc][0] = 0;
      }
  }
  
  /*
    showPlayers shows the current settings that the user has chosen on what players 
    will be playing. A done button appears when at least one player and opponent
    have been selected.
  */
  private void showPlayers(){
      stroke(0);
      strokeWeight(5);
      fill(15,140,20);
      rect(45,295,340,200);
      fill(255);
      textSize(200);
      if (pInfo[0][0] == 0){
  	text("P",210,255);
      } else if (pInfo[0][0] == 1){
  	textSize(150);
  	text("N/A",212,285);
      }
      fill(255,215,20);
      rect(415,295,340,200);
      fill(255);
      textSize(200);
      if (pInfo[1][0] == 0){
  	text("P",590,255);
      } else if (pInfo[1][0] == 1){
  	textSize(150);
  	text("N/A",590,285);
      }
      fill(200,0,10);
      rect(45,525,340,200);
      fill(255);
      textSize(200);
      if (pInfo[2][0] == 0){
  	text("P",210,490);
      } else if (pInfo[2][0] == 1){
  	textSize(150);
  	text("N/A",212,520);
      }
      fill(0,50,220);
      rect(415,525,340,200);
      fill(255);
      textSize(200);
      if (pInfo[3][0] == 0){
  	text("P",590,490);
      } else if (pInfo[3][0] == 1){
  	textSize(150);
  	text("N/A",590,520);
      }   
      if (checkPlayer()){
  	fill(255);
  	textSize(60);
  	text("DONE",400,725);
  	stroke(255);
  	noFill();
  	strokeWeight(5);
  	rect(300,735,200,60);
      } else {
  	fill(0);
  	rect(300,735,200,60);
      }
  }
  
  // checkPlayer checks whether the requirements of a new game has been completed
  private boolean checkPlayer(){
      int numP = 0;
      for (int p = 0; p < 4; p++){
  	if (pInfo[p][0] == 0) numP++;
      }
      if (numP >= 2) return true;
      return false;
  }
  
  // this is the first part of choosing what players get what order w/ user clicks
  private void chooseOrder(){
      fill(0);
      stroke(0);
      rect(0,0,800,800);
      if (pInfo[0][0] != 1) {
  	fill(15,140,25);
  	rect(0,0,400,400);
      }
      if (pInfo[1][0] != 1) {
  	fill(255,215,20);
  	rect(400,0,400,400);
      }
      if (pInfo[2][0] != 1) {
  	fill(200,0,10);
  	rect(0,400,400,400);
      }
      if (pInfo[3][0] != 1) {
  	fill(0,50,220);
  	rect(400,400,400,400);
      }
      fill(205);
      stroke(0);
      strokeWeight(5);
      ellipse(400,400,200,200);
      textAlign(CENTER,TOP);
      textSize(100);
      fill(255);
      textSize(40);
      fill(64,0,128);
      text("Click each quadrant to roll for order:",400,100);
  }
  
  //this shows the rolls each player gets that determine the order that game is played in
  private void showQuad(){
      fill(0);
      stroke(0);
      rect(0,0,800,800);
      if (pInfo[0][0] != 1) {
  	fill(15,140,25);
  	rect(0,0,400,400);
      }
      if (pInfo[1][0] != 1) {
  	fill(255,215,20);
  	rect(400,0,400,400);
      }
      if (pInfo[2][0] != 1) {
  	fill(200,0,10);
  	rect(0,400,400,400);
      }
      if (pInfo[3][0] != 1) {
  	fill(0,50,220);
  	rect(400,400,400,400);
  
      }
      fill(0);
      textSize(400);
      textAlign(CENTER,TOP);
      if (pInfo[0][1] > 0 && pInfo[0][1] <= 6){
  	text(pInfo[0][1],200,-100);
      }
      if (pInfo[1][1] > 0  && pInfo[1][1] <= 6){
  	text(pInfo[1][1],600,-100);
      }
      if (pInfo[2][1] > 0 && pInfo[2][1] <= 6){
  	text(pInfo[2][1],200,300);
      }
      if (pInfo[3][1] >0 && pInfo[3][1] <= 6){
  	text(pInfo[3][1],600,300);
      }
      fill(205);
      stroke(0);
      strokeWeight(5);
      ellipse(400,400,200,200);
      if (checkQuad()){
  	fill(0);
  	textSize(75);
  	text("Done",400,350);
  	level = 2;
      }
  }
  
  // this checks if all the players have been given an order
  private boolean checkQuad(){
      int numPlayers = 0;
      int numOrdered = 0;
      for (int p = 0; p < 4; p++){
  	if ((pInfo[p][0] == 0) || (pInfo[p][0] == -1)) numPlayers++;
  	if (pInfo[p][1] >= 1 && pInfo[p][1] <= 6) numOrdered++;
      }
      if (numPlayers == numOrdered) return true;
      return false;
  }
  
  //this reRolls so that no player gets the same roll when choosing the order (to make my life easier)
  private boolean reRoll(){
      for (int x = 0; x < 4; x++){
  	if (pInfo[x][1] == roll) return true;
      }
      return false;
  }
  
  // this flashes the roll of randomly; however, the end result has already been chosen before this
  private void flashR(){
      textAlign(BASELINE);
      int a = r.nextInt(6) + 1;
      if (circle){
  	fill(0);
  	textSize(180);
  	text("" + a, 350,470);
  	circle = false;
      } else {
  	fill(205);
  	stroke(0);
          strokeWeight(5);
  	ellipse(400,400,200,200);
  	circle = true;
      }
  }
  
  //this shows the last roll/end result
  private void showRoll(){
      clicked = false;
      fill(205);
      stroke(0);
      strokeWeight(5);
      ellipse(400,400,200,200);
      fill(0);
      textAlign(BASELINE);
      textSize(180);
      text("" + roll,350,470);
  }
  
  //After the player(s) have selected the order, this orders it internally to play the game 
  //through simple for loops
  private void orderTurns(){
      for (int i = 0; i < 4; i++){
  	order[i] = pInfo[i][1];
      }
      Arrays.sort(order);
      for (int j = 0; j < 4; j++){
  	for (int k = 0; k < 4; k++){
  	    if (order[j] == pInfo[k][1]) {
  		order[j] = k;
                  k = 5;
  	    }
  	}
      }
  }
  
  //This does what is necessary to move on to the next turn after checking if any player has won
  private void Turn(){
      turn++;
      if (turn >= maxTurn) turn = 0;
      if (checkWin()) level = 4;
      if (level == 3){
  	drawBoard();
  	showTurn();
  	showRoll();
  	clicked = false;
      }
  }
  
  //this finds the maxinum of turns possible/number of players
  private void setMaxTurn(){
      maxTurn = 0;
      for (int x = 0; x < 4; x++){
  	if (pInfo[x][0] == 0){
  	    maxTurn++;
  	}
      }
  }
  
  //This shows the user who's turn is it
  private void showTurn(){
      String s = "";
      if (order[turn] == 0) s = "Green's Turn";
      if (order[turn] == 1) s = "Yellow's Turn";
      if (order[turn] == 2) s = "Red's Turn";
      if (order[turn] == 3) s = "Blue's Turn";
      fill(255);
      textAlign(CENTER,TOP);
      textSize(25);
      text(s, 400, 200);
  }
  
  //this plays a turn by setting up to be colored again
  private void playPiece(){
      stroke(0);
      strokeWeight(5);
      pInfo[order[turn]][2] += roll;
      if (checkWin()) level = 4;
      Turn();
  }
  
  //this checks if any player have reached back to home base 
  private boolean checkWin(){
      if (pInfo[order[turn]][2] >= 24) return true;
      return false;
  }
  
  //this is the screen displayed after any player wins
  private void winScreen(){
      background(0);
      stroke(0);
      fill(255);
      textAlign(CENTER,TOP);
      textSize(100);
      text("TROUBLE",400,0);
      String s = "";
      int winner = 0;
      if (order[turn] == 0) {
  	fill(15,140,25);
  	s = "GREEN";
      }
      if (order[turn] == 1) {
  	fill(255,215,20);
  	s = "YELLOW";
      }
      if (order[turn] == 2) {
  	fill(200,0,10);
  	s = "RED";
      }
      if (order[turn] == 3) {
  	fill(0,50,220);
  	s = "BLUE";
      }
      textSize(100);
      text("Player that won:\n" + s,400,120);
      textSize(40);
      fill(255);
      text("Click Anywhere to Start a New Game",400,600);
  }
  
  
  
  //this takes a click and decides what to do based on a mix of boolean variables, level, and mouse location
  void mouseClicked(){
      if (mouseX > 720 && mouseY > 780) { //Checks if returning to main hub has been selected
        choice = 4;
      }
    
      if (dist(mouseX,mouseY,400,400)<= 100 && level == 2){
  	roll = r.nextInt(6) + 1;
  	clicked = true;
  	time = second();
      }
      if (level == 0 && mouseX >= 15 && mouseX <= 385  && mouseY >= 295 && mouseY <= 495){
  	choosePlayer(1);
      }
      if (level == 0 && mouseX >= 415 && mouseX <= 755 && mouseY >= 295 && mouseY <= 495){
  	choosePlayer(2);
      }
      if (level == 0 && mouseX >= 15 && mouseX <= 385 && mouseY >= 525 && mouseY <= 725){
  	choosePlayer(3);
      }
      if (level == 0 && mouseX >= 415 && mouseX <= 755 && mouseY >= 525 && mouseY <= 725){
  	choosePlayer(4);
      }
      if (checkPlayer() && mouseX >= 300 && mouseX <= 500 && mouseY >= 735 && mouseY <= 795){
  	level = 1;
          chooseOrder();
      }
      if (level == 1 && mouseX >= 0 && mouseX <= 400 && mouseY >= 0 && mouseY <= 400 && pInfo[0][0] != 1 && !gPlayer && !clicked){
  	roll = r.nextInt(4) + 1;
          while (reRoll()) roll = r.nextInt(4) + 1;
  	clicked = true;
  	time = second();
  	gPlayer = true;
  	pInfo[0][1] = roll;
      }
      if (level == 1 && mouseX >= 400 && mouseY <= 400 && pInfo[1][0] != 1 && !yPlayer && !clicked){
  	roll = r.nextInt(4) + 1;
  	while (reRoll()) roll = r.nextInt(4) + 1;
  	clicked = true;
  	time = second();
  	yPlayer = true;
  	pInfo[1][1] = roll;
      }
      if (level == 1 && mouseX >= 0 && mouseX <= 400 && mouseY >= 400 && pInfo[2][0] != 1 && !rPlayer && !clicked){
  	roll = r.nextInt(4) + 1;
  	while (reRoll()) roll = r.nextInt(4) + 1;
  	clicked = true;
  	time = second();
  	rPlayer = true;
  	pInfo[2][1] = roll;
      }
      if (level == 1 && mouseX >= 400 && mouseY >= 400 && pInfo[3][0] != 1 && !bPlayer  && !clicked){
  	roll = r.nextInt(4) + 1;
  	while (reRoll()) roll = r.nextInt(4) + 1;
  	clicked = true;
  	time = second();
  	bPlayer = true;
  	pInfo[3][1] = roll;
      }
      if (dist(mouseX,mouseY,400,400)<= 100 && level == 2){
  	drawBoard();
          orderTurns();
          setMaxTurn();
          showTurn();
          level = 3;
      }
      if (level == 3 && dist(mouseX,mouseY,400,400)<= 100 && !clicked){
  	roll = r.nextInt(6) + 1;
  	clicked = true;
  	time = second();
      }
      if (level == 4) setup();
  }
  
  // based on certain conditions, this performs some of the above methods
  // there's an unknown error in the time that makes it go on forever
  void draw(){
      if (second() < (time + 2) && clicked && level >= 1) {
  	flashR();
      }
      else if (clicked) {
  	showRoll();
  	if (level == 3) playPiece();
      }
      if (second() > (time + 2) && level == 1) showQuad();
      if (level == 0) showPlayers();
      if (level == 3 && checkWin()) level = 4;
      if (level == 4) winScreen();
      
      //Adds in a box to signify a button to return to the main hub
      fill(255,255,255);
      rect(720,780,80,20);
      textSize(10);
      fill(0,0,0);
      textAlign(CENTER,CENTER);
      text("Back to Hub",760,790);
      textAlign(CENTER,TOP);
  }
  
  void keyPressed() {
    if (key == 'm') {
      choice = 4;
    }
  }
}
