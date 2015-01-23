import ddf.minim.*;

class Battleship {
  //Images
  PImage logo;
  
  //Sound
  private AudioPlayer victory, splash, explode;
  
  //Info Storage
  Battleship_Board player1, player2;
  Battleship_Board[] boards = new Battleship_Board[2];
  
  //Location Data
  int[][][] locationData = {
    { //Board Location, Target Location, Logo Location, Player X's Location, Turn Location, Text Location, Example Ships 
      {10, 10} ,       {10, 410} ,       {440, 325} ,   {600,100} ,          {600, 200},    {425},         {50}
    } , {
      {410, 10} ,      {410,410} ,       {40, 325} ,    {200,100} ,          {200, 200},    {25},          {450}
    } 
  };
  
  //Game Play Booleans
  boolean startScreen, settingUp, playerChange, returnStatus;
  int winner, shipNumber, playerTurn, opposite;
  
  void setup() {
    logo = loadImage("Battleship_logo.png");
    
    victory = loader.loadFile("Battleship_victory.mp3");
    splash = loader.loadFile("Battleship_splash.mp3");
    explode = loader.loadFile("Battleship_explode.mp3");
    
    size(800, 800);
    background(0, 0, 0);
    textAlign(CENTER,CENTER);
    fill(255,255,255);
    textSize(60);
    text("Welcome to BattleShip!",400,100);
    text("Click anywhere to start!",400,700);
    
    image(logo,80,250,640,300);
    
    //Game Play
    player1 = new Battleship_Board();
    player2 = new Battleship_Board();
    boards[0] = player1;
    boards[1] = player2;
    
    startScreen = true;
    settingUp = true;
    winner = -1;
    playerChange = true;
    
    playerTurn = 0;
    shipNumber = 0;
  }
  
  void draw() {
    
    if (startScreen) {
      
    } else if (settingUp) {
      background(0,0,0);
      pushMatrix();
      translate(410,0);
      rotate(radians(90));
      fill(255,255,0);
      rect(0,0,800,20);
      fill(255,0,0);
      textAlign(CENTER,CENTER);
      textSize(20);
      text("Personal Fleet",200, 5);
      text("Ship Examples",600,5);
      popMatrix();
      
      if (playerTurn < 2) {
        boards[playerTurn].drawBoard(locationData[playerTurn][0][0],locationData[playerTurn][0][1]);
        
        textAlign(CENTER,CENTER);
        textSize(60);
        fill(255,255,255);
        text("Player " + (playerTurn + 1) + "'s", locationData[playerTurn][3][0], locationData[playerTurn][3][1]);
        text("Setup Phase", locationData[playerTurn][4][0], locationData[playerTurn][4][1]);
        image(logo,locationData[playerTurn][2][0],locationData[playerTurn][2][1],320,150);
        
        textAlign(LEFT,TOP);    
        textSize(15);
        fill(255,255,255);
        text("      This is the setup phase. The ships below \nthe board are the ships you will need to place. \nLeft click to set the location of a ship. Right \nclick to rotate the ship. Once all ships have \nbeen placed, the phase will end. May the \nodds be ever in your favor!",locationData[playerTurn][5][0],500);
        
        Battleship_Ship e1 = new Battleship_Ship(2), e2 = new Battleship_Ship(4), e3 = new Battleship_Ship(4), e4 = new Battleship_Ship(5), e5 = new Battleship_Ship(7);
        
        e1.drawShip(locationData[playerTurn][6][0], 450);
        e2.drawShip(locationData[playerTurn][6][0], 500);
        e3.drawShip(locationData[playerTurn][6][0], 550);
        e4.drawShip(locationData[playerTurn][6][0], 600);
        e5.drawShip(locationData[playerTurn][6][0], 650);
        
        if (shipNumber < boards[playerTurn].ships.length) {
          
          boards[playerTurn].drawShips();
          
          if (mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])){
            noCursor();
            boards[playerTurn].ships[shipNumber].drawShip(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
          } else {
            cursor();
          }
          
        } else {
   
          playerTurn += 1;
          shipNumber = 0;
   
        }
   
      } else {
   
        playerTurn = 0;
        settingUp = false;
        playerChange = true;
   
      }
      
    } else if (winner == -1) {
      if (playerTurn < 2) {
        if (playerChange) {
          background(0,0,0);
          textAlign(CENTER,CENTER);
          fill(255,255,255);
          textSize(60);
          text("Player " + (playerTurn + 1) + "'s Turn" ,400,100);
          textSize(40);
          text("Click anywhere to Begin",400,700);
          image(logo,80,250,640,300);
    
        } else if (returnStatus) {
          cursor();
          
          boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          boards[playerTurn].drawShips();
          boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          
          boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          
          textAlign(LEFT,TOP);    
          textSize(20);
          fill(255,255,255);
          text("            Shots Fired! \n      Click anywhere to continue",locationData[playerTurn][5][0],700);
        
        }else {
          background(0,0,0);
          opposite = Math.abs(playerTurn - 1);
          
          pushMatrix();
          translate(410,0);
          rotate(radians(90));
          fill(255,255,0);
          rect(0,0,800,20);
          fill(255,0,0);
          textAlign(CENTER,CENTER);
          textSize(20);
          text("Personal Fleet",200, 5);
          text("Enemy Fleet",600,5);
          popMatrix();
          
          textSize(60);
          fill(255,255,255);
          text("Player " + (playerTurn + 1) + "'s", locationData[playerTurn][3][0], locationData[playerTurn][3][1]);
          text("Turn", locationData[playerTurn][4][0], locationData[playerTurn][4][1]);
          
          image(logo,locationData[playerTurn][2][0],locationData[playerTurn][2][1],320,150);
          
          textAlign(LEFT,TOP);    
          textSize(15);
          fill(255,255,255);
          text("      This is the attack phase. Each player will take \nturns guessing the location of the opponent's \nships. Use your cursor to select a location to \ntarget and left click to fire. A red dot represent a \nhit and a white dot represents a miss. \n      Good Luck Commander!",locationData[playerTurn][5][0],500);
        
          
          boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          boards[playerTurn].drawShips();
          boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          
          boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          
          if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
            noCursor();
            boards[opposite].drawTarget(boards[opposite].properX(locationData[playerTurn][1][0]) * 38 + locationData[playerTurn][1][0], boards[opposite].properY(locationData[playerTurn][1][1]) * 38 + locationData[playerTurn][1][1]);
          } else {
            cursor();
          }
        }
      } else {
        playerTurn = 0;
      }
    } else {
      //WINNER SCREEN
      background(0,0,0);
      textAlign(CENTER,CENTER);
      fill(255,255,255);
      textSize(60);
      text("Game Over",400,100);
      text("Player " + (winner + 1) + " Wins!",400,150);
      
      textSize(20);
      text("Click anywhere to start a new game",400, 700);
        
      image(logo,80,250,640,300);
    }
    
    fill(255,255,255);
    rect(720,780,80,20);
    textSize(10);
    fill(0,0,0);
    textAlign(CENTER,CENTER);
    text("Back to Hub",760,790);
  }
  
  void mouseClicked() {
    if (mouseX > 720 && mouseY > 780) {
      choice = 4;
    } else if (startScreen) {
      startScreen = false;
    } else if (settingUp) {
      
      if (mouseButton == LEFT && mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])) {
        splash.rewind();
        splash.play();
        boards[playerTurn].ships[shipNumber].setLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
        boards[playerTurn].placeShip(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber]);
        shipNumber += 1;
      }
      if (mouseButton == RIGHT) {
        boards[playerTurn].ships[shipNumber].rotateShip();
      } 
      
    } else if (winner == -1) {
      if (playerChange) {
        playerChange = false;
      } else if (returnStatus) {
        playerChange = true;
        playerTurn = opposite;
        returnStatus = false;
      } else if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
          boards[opposite].addTarget(boards[opposite].properX(locationData[playerTurn][1][0]), boards[opposite].properY(locationData[playerTurn][1][1]));
          explode.rewind();
          explode.play();
          if (boards[opposite].checkWin()) {
            winner = playerTurn;
            victory.rewind();
            victory.play();
      
          }
          returnStatus = true;
      }
    } else {
      setup();
    }
  }
  
  void keyPressed() {
    if (key == 'm') {
      choice = 4;
    }
  }
}

