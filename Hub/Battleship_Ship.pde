class Battleship_Ship {
  
  private int shipLength, xStart, yStart;
  private boolean horizontal, settled;
  
  Battleship_Ship(int l) {
    shipLength = l;
    horizontal = true;
    settled = false;
  }
  
  void rotateShip() {
    horizontal = ! horizontal;
  }
  
  void setLocation(int x, int y) {
    xStart = x;
    yStart = y;
    settled = true;
  }

  void drawShip(int x, int y) {
    
    fill(204,204,204);
    
    if (horizontal) {
      triangle(x + 3, y + 19, x + 38, y + 3, x + 38, y + 35);
    } else {
      triangle(x + 19, y + 3, x + 3, y + 38, x + 35, y + 38);
    }
    
    for(int i = 1; i < shipLength - 1; i ++) {
      if (horizontal) {
        rect(x + i * 38, y + 3, 38, 32);
      } else {
        rect(x + 3, y + i * 38, 32, 38);
      }
    }
    
    if (horizontal) {
      triangle(x - 3 + 38 * shipLength, y + 19, x + 38 * shipLength - 38, y + 3, x + 38 * shipLength - 38, y + 35);
    } else {
      triangle(x + 19, y - 3 + 38 * shipLength, x + 3, y + 38 * shipLength - 38, x + 35, y + 38 * shipLength - 38);
    }
  }
  
  void drawShipLoc() {
    drawShip(xStart, yStart);
  }

}


