class Battleship_Board{

  //Instance Variables  
  private char[][] field = new char[10][10]; //2D array to store the board 
  
  //Ships designated to be a part of the board
  private Battleship_Ship s1 = new Battleship_Ship(2), s2 = new Battleship_Ship(4), s3 = new Battleship_Ship(4), s4 = new Battleship_Ship(5), s5 = new Battleship_Ship(7);
  //Array to store all the ship
  public final Battleship_Ship[] ships = {s1, s2, s3, s4, s5};
 
  //Constructor
  
  //Fills board with 'o' by default
  Battleship_Board() {
    for (int i = 0; i < field.length ; i++) {
      for (int j = 0; j < field[i].length ; j++) {
        field[i][j] = 'o';
      }
    }
  }
  
  //Methods
  
  //Tiles rectangles in order to visually display a board
  void drawBoard(int x, int y) {
    for (int i = 0; i < field.length ; i++ ) {
      for (int j = 0; j < field[i].length; j++) {
        fill(75, 100, 255);
        rect(x + 38 * i, y + 38 * j, 38,38);
      }
    }
  }
  
  //Draws all ships that have been set already
  void drawShips() {
    for (int i = 0; i < ships.length ; i++) {
      if (ships[i].settled) {
        ships[i].drawShipLoc();
      }
    }
  }
  
  //Draws white dots at location where guesses result in misses and red dots at location where guesses result in hits
  void drawShots(int x, int y) {
    for (int i = 0; i < field.length ; i++ ) {
      for (int j = 0; j < field[i].length; j++ ) {
        if (field[i][j] == 'm') {
          fill(255,255,255);
          ellipse(x + 38 * i + 19, y + 38 * j + 19, 24, 24);
        } else if (field[i][j] == 'h') {
          fill(255,0,0);
          ellipse(x + 38 * i + 19, y + 38 * j + 19, 24, 24);
        }
      }
    }
  } 
  
  //Drawing of a target, Spite for a mouse during the guessing phase
  void drawTarget(int x, int y) {
    fill(255,0,0);
    ellipse(x + 19, y + 19, 28, 28);
    fill(255,255,255);
    ellipse(x + 19, y + 19, 24, 24);
    fill(255,0,0);
    rect(x + 2, y + 18, 34, 2);
    rect(x + 18, y + 2, 2, 34);
    ellipse(x + 19, y + 19, 6, 6);
  }
  
  //Checks a ship can be placed at a certain x and y coordinate
  boolean checkLocation(int x, int y, Battleship_Ship s) {
    if (s.horizontal) {
      for (int i = 0; i < s.shipLength; i++) {
        if (!(x + i < field.length && field[i + x][y] == 'o')) {
          return false;
        }
      }
    } else {
      for (int i = 0; i < s.shipLength; i++) {
        if (!(y + i < field[x].length && field[x][i + y] == 'o')) {
          return false;
        }
      }
    }
    return true;
  }
  
  //Adds the ship to the information stored in the 2D array
  void placeShip(int x, int y, Battleship_Ship s) {
    if (s.horizontal) {
      for (int i = 0; i < s.shipLength; i++) {
        field[i + x][y] = 's';
      }
    } else {
      for (int i = 0; i < s.shipLength; i++) {
        field[x][i + y] = 's';
      }      
    }
  }
  
  //Stores data of hitting or missing based on the location of a guess
  void addTarget(int  x, int y) {
    if (field[x][y] == 's') {
      //explode.rewind();
      //explode.play();
      field[x][y] = 'h';
    } else if (field[x][y] == 'o') {
      //splash.rewind();
      //splash.play();
      field[x][y] = 'm';
    }
  }
  
  //Check theres is no more ship data and declares if a player has won
  boolean checkWin() {
    int counter = 0;
    for (int i = 0; i < field.length; i++) {
      for (int j = 0 ; j < field[i].length; j++) {
        if (field[i][j] == 's') {
          counter += 1;
        }
      }
    }
    return counter == 0;
  }
  
  //Fixes the x coordinate of the mouse to be used relative to the board
  int properX(int x) {
    return (int)((mouseX - x) / 38);
  }
  
  //Fixes the y coordinate of the mouse to be used relative to the board
  int properY(int y) {
    return (int)((mouseY - y) / 38);
  }
  
}
