import ddf.minim.*;

//Images
PImage logo;

//Sound
private Minim loader;
private AudioPlayer victory, splash, explode;

//Info Storage
Board player1, player2;
Board[] boards = new Board[2];

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
  //Loads Image Logo
  logo = loadImage("battleshiplogo.png");
  
  //Sets up the sound
  loader = new Minim(this);
  victory = loader.loadFile("Battleship_victory.mp3");
  splash = loader.loadFile("Battleship_splash.mp3");
  explode = loader.loadFile("Battleship_explode.mp3");
  
  //Sets up the world
  size(800, 800);
  background(0, 0, 0);
  
  //Welcome message and instructions to start
  textAlign(CENTER,CENTER);
  fill(255,255,255);
  textSize(60);
  text("Welcome to BattleShip!",400,100);
  text("Click anywhere to start!",400,700);
  
  //Shows the logo
  image(logo,80,250,640,300);
  
  //Game Play //Resets the boards and list of boards
  player1 = new Board();
  player2 = new Board();
  boards[0] = player1;
  boards[1] = player2;
  
  //Allows for each setting to run in order
  startScreen = true;
  settingUp = true;
  winner = -1;
  playerChange = true;
  
  //Starts the setup process
  playerTurn = 0;
  shipNumber = 0;
}

void draw() {
  
  if (startScreen) {
    //Changes nothing during the startscreen
  } else if (settingUp) {
    background(0,0,0); //Cleans the screen
    
    //Writes vetically label text for ships and board 
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
    
    //Setting up for both players
    if (playerTurn < 2) {
      boards[playerTurn].drawBoard(locationData[playerTurn][0][0],locationData[playerTurn][0][1]); //Draws the empty board at the proper side (Uses the location data)
      
      //Title text for the screens
      textAlign(CENTER,CENTER);
      textSize(60);
      fill(255,255,255);
      text("Player " + (playerTurn + 1) + "'s", locationData[playerTurn][3][0], locationData[playerTurn][3][1]);
      text("Setup Phase", locationData[playerTurn][4][0], locationData[playerTurn][4][1]);
      image(logo,locationData[playerTurn][2][0],locationData[playerTurn][2][1],320,150);
      
      //Informational text for the screen
      textAlign(LEFT,TOP);    
      textSize(15);
      fill(255,255,255);
      text("      This is the setup phase. The ships below \nthe board are the ships you will need to place. \nLeft click to set the location of a ship. Right \nclick to rotate the ship. Once all ships have \nbeen placed, the phase will end. May the \nodds be ever in your favor!",locationData[playerTurn][5][0],500);
      
      //Shows the example ships by creating example ships and drawing them in a proper spot
      Ship e1 = new Ship(2), e2 = new Ship(4), e3 = new Ship(4), e4 = new Ship(5), e5 = new Ship(7);
      
      e1.drawShip(locationData[playerTurn][6][0], 450);
      e2.drawShip(locationData[playerTurn][6][0], 500);
      e3.drawShip(locationData[playerTurn][6][0], 550);
      e4.drawShip(locationData[playerTurn][6][0], 600);
      e5.drawShip(locationData[playerTurn][6][0], 650);
      
      //Adding each ship individually
      if (shipNumber < boards[playerTurn].ships.length) {
        
        //Draws all ships added so far
        boards[playerTurn].drawShips();
        
        //Checks if the mouse is the board and a ship can be placed
        if (mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])){
          noCursor(); //Removes the mouse
          //Draws the ship in accordance to the mouse
          boards[playerTurn].ships[shipNumber].drawShip(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
        } else {
          //Otherwise, meaning mouse is not on the board or a ship cannot be placed
          cursor(); //Show the cursor
        }
        
      } else {
         //Once all ships have been placed
        playerTurn += 1; //We change to the next player
        shipNumber = 0; //We reset which ship is being placed
      }
 
    } else {
      //Once of both players have gone
      playerTurn = 0;  //We return to player one
      settingUp = false; //Stop setup
      playerChange = true; //Sets the player changing screen
 
    }
    
  } else if (winner == -1) { //After setup is finished and a winner has not been decided
    if (playerTurn < 2) { //Checks if both players have gone
      if (playerChange) { //Checks if its the player changing screen
        background(0,0,0); //Wipes the screen
        
        //Shows whose turn it should be and how to continue
        textAlign(CENTER,CENTER);
        fill(255,255,255);
        textSize(60);
        text("Player " + (playerTurn + 1) + "'s Turn" ,400,100);
        textSize(40);
        text("Click anywhere to Begin",400,700);
        image(logo,80,250,640,300);
  
      } else if (returnStatus) { //Prints once turn has finished
        cursor(); //Shows the cursor
        
        //Shows the player's board with ships and opponents guess and the opponents board with guess locations
        boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        boards[playerTurn].drawShips();
        boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        
        boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        
        //Text on how to continue and verification guess has been recorded
        textAlign(LEFT,TOP);    
        textSize(20);
        fill(255,255,255);
        text("            Shots Fired! \n      Click anywhere to continue",locationData[playerTurn][5][0],700);
      
      }else {
        background(0,0,0); //Cleans the screen
        opposite = Math.abs(playerTurn - 1); //Sets the opponents value (easier to access value of the opponents)
        
        //Vertical lab of Boards (Player's and Opponent's)
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
        
        //Title of screen (Which player's turn)
        textSize(60);
        fill(255,255,255);
        text("Player " + (playerTurn + 1) + "'s", locationData[playerTurn][3][0], locationData[playerTurn][3][1]);
        text("Turn", locationData[playerTurn][4][0], locationData[playerTurn][4][1]);
        
        //Logo in size middle of the screen
        image(logo,locationData[playerTurn][2][0],locationData[playerTurn][2][1],320,150);
        
        //Informational Text on the phase
        textAlign(LEFT,TOP);    
        textSize(15);
        fill(255,255,255);
        text("      This is the attack phase. Each player will take \nturns guessing the location of the opponent's \nships. Use your cursor to select a location to \ntarget and left click to fire. A red dot represent a \nhit and a white dot represents a miss. \n      Good Luck Commander!",locationData[playerTurn][5][0],500);
      
        //Draws the player's own board with ships and opponents guesses
        boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        boards[playerTurn].drawShips();
        boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
        
        //Draws the opponents board with already guessed locations
        boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
        
        //Checks if the mouse is in the board
        if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
          //Removes the cursor and places with a target sprite
          noCursor();
          boards[opposite].drawTarget(boards[opposite].properX(locationData[playerTurn][1][0]) * 38 + locationData[playerTurn][1][0], boards[opposite].properY(locationData[playerTurn][1][1]) * 38 + locationData[playerTurn][1][1]);
        } else {
          //While not in the board, the cursor is back
          cursor();
        }
      }
    } else {
      //Once bother players have gone, the player 1 is set to go again
      playerTurn = 0;
    }
  } else {
    //WINNER SCREEN
    victory.rewind(); //Resets victory sound
    victory.play(); //Plays victory sound
    
    background(0,0,0); //Cleans the screen
    
    //Prints that the game has been completed and who the winner is
    textAlign(CENTER,CENTER); 
    fill(255,255,255);
    textSize(60);
    text("Game Over",400,100);
    text("Player " + (winner + 1) + " Wins!",400,150);
    
    //Instruction for how to continue
    textSize(20);
    text("Click anywhere to start a new game",400, 700);
      
    //Logo in the center of the screen
    image(logo,80,250,640,300);
  
    
    
  }
}

void mouseClicked() {
  if (startScreen) { //Checks if the start screen
    startScreen = false; //Stops the start screen
  } else if (settingUp) { //Check if its the setup phase
    
    //Checks if the mouse is on the board in a valid placement location and left clicked
    if (mouseButton == LEFT && mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])) {
      splash.rewind(); //Resets splash sound
      splash.play(); //Plays splash sound
      
      //Assigns the location to the ship, Adds the ship to the board memory
      boards[playerTurn].ships[shipNumber].setLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
      boards[playerTurn].placeShip(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber]);
      
      //Moves onto the next ship
      shipNumber += 1;
    }
    if (mouseButton == RIGHT) { //If a right click
      boards[playerTurn].ships[shipNumber].rotateShip(); //Change the orientation of the ship (Vertical or Horizontal)
    } 
    
  } else if (winner == -1) { //Gameplay Phase
    if (playerChange) {  //Screen between turns
      playerChange = false; //Stops said screen
      
    } else if (returnStatus) { //Return status after a guess
      playerChange = true; //Change player screen is started
      playerTurn = opposite; //Changes the player 
      returnStatus = false; //Stops status
      
    } else if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
      //Checks if mouse is on opponets board
      //Sets a guess in opponents board memory
      boards[opposite].addTarget(boards[opposite].properX(locationData[playerTurn][1][0]), boards[opposite].properY(locationData[playerTurn][1][1]));
      
      //Checks if player has won yet
      if (boards[opposite].checkWin()) {
        winner = playerTurn; //Sets that player as the winner
      }
      returnStatus = true; //Starts the post fire status function
    }
  } else {
    //When game is over, Click will setup a new game
    setup(); 
  }
}

void keyPressed() {
  //Not used, but implemented in hub version
}

