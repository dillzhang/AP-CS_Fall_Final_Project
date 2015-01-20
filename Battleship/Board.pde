class Board{
  
  private char[][] field = new char[10][10];
  
  private Ship s1 = new Ship(2), s2 = new Ship(4), s3 = new Ship(4), s4 = new Ship(5), s5 = new Ship(7);
  public final Ship[] ships = {s1, s2, s3, s4, s5};
 
  Board() {
    for (int i = 0; i < field.length ; i++) {
      for (int j = 0; j < field[i].length ; j++) {
        field[i][j] = 'o';
      }
    }
  }
  
  void drawBoard(int x, int y) {
    for (int i = 0; i < field.length ; i++ ) {
      for (int j = 0; j < field[i].length; j++) {
        fill(75, 100, 255);
        rect(x + 38 * i, y + 38 * j, 38,38);
      }
    }
  }
  
  void drawShips() {
    for (int i = 0; i < ships.length ; i++) {
      if (ships[i].settled) {
        ships[i].drawShipLoc();
      }
    }
  }
  
  void drawShots(int x, int y) {
    for (int i = 0; i < field.length ; i++ ) {
      for (int j = 0; j < field[i].length; j++ ) {
        if (field[i][j] == 'm') {
          fill(255,255,255);
          ellipse(x + 38 * i, y + 38 * j, 32, 32);
        } else if (field[i][j] == 'h') {
          fill(255,0,0);
          ellipse(x + 38 * i, y + 38 * j, 32, 32);
        }
      }
    }
  } 
  
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
  
  int properX(int x) {
    return (int)((mouseX - x) / 38);
  }
  
  int properY(int y) {
    return (int)((mouseY - y) / 38);
  }
  
}
