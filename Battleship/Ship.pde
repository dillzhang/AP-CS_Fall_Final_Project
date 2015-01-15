class Ship {
  
  private int shipLength, xStart, yStart;
  private boolean horizontal;
  
  Ship(int l) {
    shipLength = l;
    horizontal = true;
  }
  
  int returnLength() {
    return shipLength;
  }
  
  void rotateship() {
    horizontal = ! horizontal;
  }
  
  boolean shipRotation() {
    return horizontal;
  }
  
  void setLocation(int x, int y) {
    xStart = x;
    yStart = y;
  }
  
  int returnX() {
    return xStart;
  }
  
  int returnY() {
    return yStart;
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


