class Ship {
  //Instance Variables
  private int shipLength, xStart, yStart;
  private boolean horizontal, settled;
  
  //Setup ships based on length
  Ship(int l) {
    shipLength = l;
    horizontal = true;
    settled = false;
  }
  
  //Changes the orientation of ships
  void rotateShip() {
    horizontal = ! horizontal;
  }
  
  //Sets the location of the ship, Saves it in the instance
  void setLocation(int x, int y) {
    xStart = x;
    yStart = y;
    settled = true;
  }

  //Draws ship at specified location using x and y coorindates
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
  
  //Draws the ship where it was set (Using setLocation())
  void drawShipLoc() {
    drawShip(xStart, yStart);
  }

}


