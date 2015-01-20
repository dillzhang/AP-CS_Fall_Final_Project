PImage logo;

//Info Storage
Board player1 = new Board(), player2 = new Board();
Board[] boards = {player1, player2};

//Location Data
int[][][] locationData = {
  { //Board Location, Target Location
    {10, 10} , {10, 410} 
  } , {
    {410, 10} , {410,410}  
  }
};

//Game Play Booleans
boolean startScreen, settingUp, playerChange;
int winner, shipNumber, playerTurn;

void setup() {
  logo = loadImage("battleshiplogo.png");
  
  size(800, 800);
  background(0, 0, 0);
  textAlign(CENTER,CENTER);
  fill(255,255,255);
  textSize(60);
  text("Welcome to BattleShip!",400,100);
  text("Click anywhere to start!",400,700);
  
  image(logo,80,250,640,300);
  
  //Game Play
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
    
    if (playerTurn < 2) {
      boards[playerTurn].drawBoard(locationData[playerTurn][0][0],locationData[playerTurn][0][1]);
      
      if (shipNumber < boards[playerTurn].ships.length) {
        
        boards[playerTurn].drawShips();
        
        if (mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])){
          boards[playerTurn].ships[shipNumber].drawShip(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
        }
        
      } else {
 
        playerTurn += 1;
        shipNumber = 0;
 
      }
 
    } else {
 
       playerTurn = 0;
      settingUp = false;
 
    }
    
  } else if (winner == -1) {
    if (playerTurn < 2) {
      int opposite = Math.abs(playerTurn - 1);
      
      boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
      boards[playerTurn].drawShips();
      boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
      
      boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
      boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
      
      if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
        boards[opposite].drawTarget(boards[opposite].properX(locationData[playerTurn][1][0]) * 38 + locationData[playerTurn][1][0], boards[opposite].properY(locationData[playerTurn][1][1]) * 38 + locationData[playerTurn][1][1]);
      }
    } else {
      playerTurn = 0;
    }
  }
}

void mouseClicked() {
  if (startScreen) {
    startScreen = false;
  } else if (settingUp) {
    
    if (mouseButton == LEFT && mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])) {
      boards[playerTurn].ships[shipNumber].setLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
      boards[playerTurn].placeShip(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber]);
      shipNumber += 1;
    }
    if (mouseButton == RIGHT) {
      boards[playerTurn].ships[shipNumber].rotateShip();
    } 
    
  }
}

void keyPressed() {
  
}

