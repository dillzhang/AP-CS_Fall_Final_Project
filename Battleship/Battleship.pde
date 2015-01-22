PImage logo;

//Info Storage
Board player1, player2;
Board[] boards = new Board[2];

//Location Data
int[][][] locationData = {
  { //Board Location, Target Location
    {10, 10} , {10, 410} , {440, 325} , {600,100} , {600, 200}
  } , {
    {410, 10} , {410,410} , {40, 325} , {200,100} , {200, 200}
  }
};

//Game Play Booleans
boolean startScreen, settingUp, playerChange, returnStatus;
int winner, shipNumber, playerTurn, opposite;

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
  player1 = new Board();
  player2 = new Board();
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
        boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        boards[playerTurn].drawShips();
        boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        
        boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
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
        
        boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        boards[playerTurn].drawShips();
        boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        
        boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        
        if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
          boards[opposite].drawTarget(boards[opposite].properX(locationData[playerTurn][1][0]) * 38 + locationData[playerTurn][1][0], boards[opposite].properY(locationData[playerTurn][1][1]) * 38 + locationData[playerTurn][1][1]);
        }
      }
    } else {
      playerTurn = 0;
    }
  } else {
    //WINNER SCREEN
    background(0,0,0);
    
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
    
  } else if (winner == -1) {
    if (playerChange) {
      playerChange = false;
    } else if (returnStatus) {
      playerChange = true;
      playerTurn = opposite;
      returnStatus = false;
    } else if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
        boards[opposite].addTarget(boards[opposite].properX(locationData[playerTurn][1][0]), boards[opposite].properY(locationData[playerTurn][1][1]));
        if (boards[opposite].checkWin()) {
          winner = playerTurn;
        }
        returnStatus = true;
    }
  } else {
    setup();
  }
}

void keyPressed() {
  
}

