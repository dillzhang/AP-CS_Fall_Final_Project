class Board {
  //Instance Variables

  //2D array for board
  private char[][] field = new char[10][10];

  //Ships specific to each board
  private Ship s1 = new Ship(2), s2 = new Ship(4), s3 = new Ship(4), s4 = new Ship(5), s5 = new Ship(7);
  public final Ship[] ships = {
    s1, s2, s3, s4, s5
  };


  //Setup the board, fills with 'o' by default
  Board() {
    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field[i].length; j++) {
        field[i][j] = 'o';
      }
    }
  }

  //Draws the board (Tiled blue squares)
  void drawBoard(int x, int y) {
    for (int i = 0; i < field.length; i++ ) {
      for (int j = 0; j < field[i].length; j++) {
        fill(75, 100, 255);
        rect(x + 38 * i, y + 38 * j, 38, 38);
      }
    }
  }

  //Draws all ships with set locations (Loops through each ship)
  void drawShips() {
    for (int i = 0; i < ships.length; i++) {
      if (ships[i].settled) {
        ships[i].drawShipLoc();
      }
    }
  }

  //Interprets data stored in board ('h' = red circle, 'm' = white circle
  void drawShots(int x, int y) {
    for (int i = 0; i < field.length; i++ ) {
      for (int j = 0; j < field[i].length; j++ ) {
        if (field[i][j] == 'm') {
          fill(255, 255, 255);
          ellipse(x + 38 * i + 19, y + 38 * j + 19, 24, 24);
        } else if (field[i][j] == 'h') {
          fill(255, 0, 0);
          ellipse(x + 38 * i + 19, y + 38 * j + 19, 24, 24);
        }
      }
    }
  } 


  //Draws a sprite for targeting on a board
  void drawTarget(int x, int y) {
    fill(255, 0, 0);
    ellipse(x + 19, y + 19, 28, 28);
    fill(255, 255, 255);
    ellipse(x + 19, y + 19, 24, 24);
    fill(255, 0, 0);
    rect(x + 2, y + 18, 34, 2);
    rect(x + 18, y + 2, 2, 34);
    ellipse(x + 19, y + 19, 6, 6);
  }

  //Checks if a ship can be placed at specified location, for both horizontal and vertical
  boolean checkLocation(int x, int y, Ship s) {
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

  //Adds the ships data to the 2D array of the board
  void placeShip(int x, int y, Ship s) {
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
  
  //Adds a value corresponding into the board
  void addTarget(int  x, int y) {
    if (field[x][y] == 's') {
      explode.rewind();
      explode.play();
      field[x][y] = 'h';
    } else if (field[x][y] == 'o') {
      splash.rewind();
      splash.play();
      field[x][y] = 'm';
    }
  }

  //Checks that there is no more ship data left in the board
  boolean checkWin() {
    int counter = 0;
    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field[i].length; j++) {
        if (field[i][j] == 's') {
          counter += 1;
        }
      }
    }
    return counter == 0;
  }

  //Fixes x corodinate in accordance with the board
  int properX(int x) {
    return (int)((mouseX - x) / 38);
  }

  //Fixes y coordinate in accordance with the board
  int properY(int y) {
    return (int)((mouseY - y) / 38);
  }
}

