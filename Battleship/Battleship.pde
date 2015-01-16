PImage logo;

//Info Storage
Board player1 = new Board(), player2 = new Board();
Board[] boards = {player1, player2};

//Location Data
int[][][] locationData = {
  { 
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
  winner = -2;
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
        if (mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][0] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])){
          boards[playerTurn].ships[shipNumber].drawShip(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
        }
      } else {
        playerTurn += 1;
        shipNumber = 0;
      }
    }
    
    
  } else if (winner == -1) {
  
  }
}

void mouseClicked() {
  if (startScreen) {
    startScreen = false;
  }

  if (settingUp) {
    if (mouseButton == LEFT) {
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

