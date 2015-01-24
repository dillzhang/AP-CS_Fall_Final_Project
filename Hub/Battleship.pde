import ddf.minim.*;

class Battleship {
  
  //INSTANCE VARIABLES ===================================================================================================================================================================================
  
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
  
  //SETUP() ==============================================================================================================================================================================================
  
  void setup() {
    //Loads an image for the logo
    logo = loadImage("Battleship_logo.png");
    
    //Loads the sounds
    victory = loader.loadFile("Battleship_victory.mp3");
    splash = loader.loadFile("Battleship_splash.mp3");
    explode = loader.loadFile("Battleship_explode.mp3");
    
    //Sets up the world size
    size(800, 800);
    background(0, 0, 0);
    
    //Text for starting screen and info to continue
    textAlign(CENTER,CENTER);
    fill(255,255,255);
    textSize(60);
    text("Welcome to BattleShip!",400,100);
    text("Click anywhere to start!",400,700);
    
    //Draws the logo
    image(logo,80,250,640,300);
    
    //Game Play
    //Sets new boards for each players and stores them in an array
    player1 = new Battleship_Board();
    player2 = new Battleship_Board();
    boards[0] = player1;
    boards[1] = player2;
    
    //Sets the proper state for the game (start screen is running, setting will be running, no winner has been declared, player changing screen will be running)
    startScreen = true;
    settingUp = true;
    winner = -1;
    playerChange = true;
    
    //Starts with player 1 and their first ship
    playerTurn = 0;
    shipNumber = 0;
  }
  
  //DRAW() ===============================================================================================================================================================================================
  
  void draw() {
    
    if (startScreen) {
      //Do nothing during the start screen
    } else if (settingUp) {
      background(0,0,0); //Wipe the screen clean
      
      //Draws vertical with labels for the board and example ships
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
      
      //Checks if each individual player has finished the setup
      if (playerTurn < 2) {
        //Draws the player's board on the screen 
        boards[playerTurn].drawBoard(locationData[playerTurn][0][0],locationData[playerTurn][0][1]);
        
        //Informational text (Player's Turn)
        textAlign(CENTER,CENTER);
        textSize(60);
        fill(255,255,255);
        text("Player " + (playerTurn + 1) + "'s", locationData[playerTurn][3][0], locationData[playerTurn][3][1]);
        text("Setup Phase", locationData[playerTurn][4][0], locationData[playerTurn][4][1]);
        
        //Logo on middle side of the screen
        image(logo,locationData[playerTurn][2][0],locationData[playerTurn][2][1],320,150);
        
        //Information text on the setup phase
        textAlign(LEFT,TOP);    
        textSize(15);
        fill(255,255,255);
        text("      This is the setup phase. The ships below \nthe board are the ships you will need to place. \nLeft click to set the location of a ship. Right \nclick to rotate the ship. Once all ships have \nbeen placed, the phase will end. May the \nodds be ever in your favor!",locationData[playerTurn][5][0],500);
        
        //Creates ships to be used  as examples
        Battleship_Ship e1 = new Battleship_Ship(2), e2 = new Battleship_Ship(4), e3 = new Battleship_Ship(4), e4 = new Battleship_Ship(5), e5 = new Battleship_Ship(7);
        
        //Draws the ships on the screen, lower corner for examples
        e1.drawShip(locationData[playerTurn][6][0], 450);
        e2.drawShip(locationData[playerTurn][6][0], 500);
        e3.drawShip(locationData[playerTurn][6][0], 550);
        e4.drawShip(locationData[playerTurn][6][0], 600);
        e5.drawShip(locationData[playerTurn][6][0], 650);
        
        //Checks if there are any ships left to palce
        if (shipNumber < boards[playerTurn].ships.length) {
          
          //Draws the ships that have already been placed
          boards[playerTurn].drawShips();
          
          //Checks if the mouse is in the board and on a valid ship position
          if (mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])){
            noCursor(); //Removes the cursor
            //Draws the ship, aligned to the boards
            boards[playerTurn].ships[shipNumber].drawShip(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
          } else {
            //Otherwise, when the mouse is not on the board or the location is invalid for a ship, the cursor will be shown
            cursor();
          }
          
        } else {
         //All ships have been placed 
          playerTurn += 1; //Move to next player
          shipNumber = 0; //Restarts to the first ship that needs to be placed
   
        }
   
      } else {
        //Both players have gone
        playerTurn = 0; //Sets back to player 1 (stored as 0 in arrays)
        settingUp = false; //No longer the setting up state
        playerChange = true; //player change screen still needs to be run
   
      }
      
    } else if (winner == -1) {
      //When no winner has been decided
      if (playerTurn < 2) {
        //Checking if both players have gone
        if (playerChange) {
          //Creates a intermediate screen between player turns (to prevent each other from seeing ship location)
          background(0,0,0); //Cleans the screen
          
          //Writes who's turn it is and how to continue
          textAlign(CENTER,CENTER);
          fill(255,255,255);
          textSize(60);
          text("Player " + (playerTurn + 1) + "'s Turn" ,400,100);
          textSize(40);
          text("Click anywhere to Begin",400,700);
          
          //Adds logo in the middle of the screen
          image(logo,80,250,640,300);
    
        } else if (returnStatus) {
          //Shows status after a shot is fired 
          cursor(); //Returns the cursor back to the screen
          
          //Draws the player's board, all his ships, and the guesses of his opponents
          boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          boards[playerTurn].drawShips();
          boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          
          //Draws the opponents board and the player's guesses
          boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          
          //Informational text that a shoot has been fired and how the user can proceed
          textAlign(LEFT,TOP);    
          textSize(20);
          fill(255,255,255);
          text("            Shots Fired! \n      Click anywhere to continue",locationData[playerTurn][5][0],700);
        
        }else {
          //Main Game Play (Guessing Phase)
          background(0,0,0); //Cleans the screen
          
          opposite = Math.abs(playerTurn - 1); //Establishes the opponents array value (Just easier axcess to array)
          
          //Vertical label for player's board and opponents board
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
          
          //Text for who's turn it is 
          textSize(60);
          fill(255,255,255);
          text("Player " + (playerTurn + 1) + "'s", locationData[playerTurn][3][0], locationData[playerTurn][3][1]);
          text("Turn", locationData[playerTurn][4][0], locationData[playerTurn][4][1]);
          
          //Logo in te side middle of the screen
          image(logo,locationData[playerTurn][2][0],locationData[playerTurn][2][1],320,150);
          
          //Text on how the phase works (Instructions Basically)
          textAlign(LEFT,TOP);    
          textSize(15);
          fill(255,255,255);
          text("      This is the attack phase. Each player will take \nturns guessing the location of the opponent's \nships. Use your cursor to select a location to \ntarget and left click to fire. A red dot represent a \nhit and a white dot represents a miss. \n      Good Luck Commander!",locationData[playerTurn][5][0],500);
        
          //Draws the player's board, player's ships, and opponent's guesses
          boards[playerTurn].drawBoard(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          boards[playerTurn].drawShips();
          boards[playerTurn].drawShots(locationData[playerTurn][0][0], locationData[playerTurn][0][1]);
          
          //Draws the opponent's board and the player's guesses so far
          boards[opposite].drawBoard(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          boards[opposite].drawShots(locationData[playerTurn][1][0], locationData[playerTurn][1][1]);
          
          //Checks if the mouse is on the board
          if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
            noCursor(); //Removes the cursor
            //Sets a targets aligned to the board based on mouse location
            boards[opposite].drawTarget(boards[opposite].properX(locationData[playerTurn][1][0]) * 38 + locationData[playerTurn][1][0], boards[opposite].properY(locationData[playerTurn][1][1]) * 38 + locationData[playerTurn][1][1]);
          } else {
            //Otherwise, (Mouse is not on board)
            cursor(); //Show the cursor
          }
        }
      } else {
        //Once both players have gone
        playerTurn = 0; //Resets the player back to 1
      }
    } else {
      //WINNER SCREEN
      background(0,0,0); //Cleans the screen
      
      //Writes that the game is over and who the winner is 
      textAlign(CENTER,CENTER); 
      fill(255,255,255);
      textSize(60);
      text("Game Over",400,100);
      text("Player " + (winner + 1) + " Wins!",400,150);
      
      //Instructions on how to continue (Starting a new game)
      textSize(20);
      text("Click anywhere to start a new game",400, 700);
        
      //Adds a logo to the middle of the screen
      image(logo,80,250,640,300);
    }
    
    //Adds a little rectangular area with 'Return to Hub' (Used joining to hub)
    fill(255,255,255);
    rect(720,780,80,20);
    textSize(10);
    fill(0,0,0);
    textAlign(CENTER,CENTER);
    text("Back to Hub",760,790);
  }
  
  //MOUSECLICKED() =======================================================================================================================================================================================
  
  void mouseClicked() {
    //Checks if the mouse is on the 'Return to Hub' button
    if (mouseX > 720 && mouseY > 780) {
      choice = 4; //Sets the choice back to 4 (Hub value)
    } else if (startScreen) { //If on the start screen
      startScreen = false; //Stop the start screen
    } else if (settingUp) { //During the setup phase
      
      //Left click on the mouse, while in the board
      if (mouseButton == LEFT && mouseX > locationData[playerTurn][0][0] && mouseX < locationData[playerTurn][0][0] + 380 && mouseY > locationData[playerTurn][0][1] && mouseY < locationData[playerTurn][0][1] + 380 && boards[playerTurn].checkLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber])) {
        splash.rewind(); //Reset the splashing sound
        splash.play(); //Plays the splashing sound
        
        //Adds the ship datat to the board at corresponding location and sets the location of the ship
        boards[playerTurn].ships[shipNumber].setLocation(boards[playerTurn].properX(locationData[playerTurn][0][0]) * 38 + locationData[playerTurn][0][0], boards[playerTurn].properY(locationData[playerTurn][0][1]) * 38 + locationData[playerTurn][0][1]);
        boards[playerTurn].placeShip(boards[playerTurn].properX(locationData[playerTurn][0][0]), boards[playerTurn].properY(locationData[playerTurn][0][1]), boards[playerTurn].ships[shipNumber]);
        
        //Moves onto the next ship
        shipNumber += 1;
      }
      
      //Right Clicking during setup
      if (mouseButton == RIGHT) { 
        //Rotates the ship (Vertical or Horizontal)
        boards[playerTurn].ships[shipNumber].rotateShip();
      } 
      
    } else if (winner == -1) { //A winner has not been declared (Guessing Phase)
      
      if (playerChange) { //Checks its the player changing screen
        playerChange = false; //Stops said screen
        
      } else if (returnStatus) { //Checks if it is the return status screen
        playerChange = true; //Starts the player changing screen
        playerTurn = opposite; //Changes player
        returnStatus = false; //Stops the return status screen
        
        //Checks if the mouse is in the board
      } else if (mouseX > locationData[playerTurn][1][0] && mouseX < locationData[playerTurn][1][0] + 380 && mouseY > locationData[playerTurn][1][1] && mouseY < locationData[playerTurn][1][1] + 380) {
        
        //Adds the guess to the board memory (2D array)  
        boards[opposite].addTarget(boards[opposite].properX(locationData[playerTurn][1][0]), boards[opposite].properY(locationData[playerTurn][1][1]));
        explode.rewind(); //Rewinds the explosion sound
        explode.play(); //Plays the explosion sound
        
        //Checks to see if the player has won
        if (boards[opposite].checkWin()) { 
          winner = playerTurn; //Sets the winner to that player
          victory.rewind(); //Resets the win sound
          victory.play(); //Plays the win sound
      
        }
          //Guess has been add, starts the post firing status screen
          returnStatus = true; 
      }
    } else {
      //The starting screen, setup screen, and gameplay has been finished 
      setup(); //We start a new game
    }
  }
  
  //KEYPRESSED() =========================================================================================================================================================================================
  
  void keyPressed() {
    //Pressing the 'm' key returns back to the main hub
    if (key == 'm') {
      choice = 4;
    }
  }
}

