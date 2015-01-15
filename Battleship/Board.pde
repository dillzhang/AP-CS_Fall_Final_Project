class Board {
 
  private int startingX, startingY;
  private char[][] field = new char[10][10];
  
  private Ship s1 = new Ship(2), s2 = new Ship(4), s3 = new Ship(4), s4 = new Ship(5), s5 = new Ship(7);
  public final Ship[] ships = {s1, s2, s3, s4, s5};
 
  Board(int x, int y) {
    startingX = x;
    startingY = y;
    
    for (int i = 0; i < field.length ; i++) {
      for (int j = 0; j < field[i].length ; j++) {
        field[i][j] = 'o';
      }
    }
  }
  
  void drawBoard() {
    for (int i = 0; i < field.length ; i++ ) {
      for (int j = 0; j < field[i].length; j++) {
        fill(75, 100, 255);
        rect(startingX + 38 * i, startingY + 38 * j, 38,38);
      }
    }
  }
  
  void drawShips() {
    for (int i = 0; i < ships.length ; i++) {
      ships[i].drawShipLoc();
    }
  }
    
  
  boolean checkLocation(int x, int y, Ship s) {
    if (s.shipRotation()) {
      for (int i = 0; i < s.returnLength(); i++) {
        if (!(x + i < field[x].length && field[i][y] == 'o')) {
          return false;
        }
      }
    } else {
      for (int i = 0; i < s.returnLength(); i++) {
        if (!(x + i < field.length && field[x][i] == 'o')) {
          return false;
        }
      }
    }
    return true;
  }
  
  int properX() {
    return (int)((mouseX - startingX) / 38);
  }
  
  int properY() {
    return (int)((mouseY - startingY) / 38);
  }
  
}
