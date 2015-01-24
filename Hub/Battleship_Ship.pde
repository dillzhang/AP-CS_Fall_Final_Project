class Battleship_Ship {
  
  //Instance Variables
  private int shipLength, xStart, yStart;
  private boolean horizontal, settled;
  
  //Constructors
  
  //Creates class based on ships length, not set on a location yet and is horizontal by default
  Battleship_Ship(int l) {
    shipLength = l;
    horizontal = true;
    settled = false;
  }
  
  //Methods
  
  //Rotates the ship (Horizontal / Vertical)
  void rotateShip() {
    horizontal = ! horizontal;
  }
  
  //Specifies a location for this ship (Easier to draw all ships on a board later)
  void setLocation(int x, int y) {
    xStart = x;
    yStart = y;
    settled = true;
  }

  //Draws the ship on a specified x and y coordinate
  void drawShip(int x, int y) {
    
    fill(204,204,204); //Silver color
    
    //Triangle head depending on orientation
    if (horizontal) {
      triangle(x + 3, y + 19, x + 38, y + 3, x + 38, y + 35); 
    } else {
      triangle(x + 19, y + 3, x + 3, y + 38, x + 35, y + 38);
    }
    
    //Rectangular body depending on orientation
    for(int i = 1; i < shipLength - 1; i ++) {
      if (horizontal) {
        rect(x + i * 38, y + 3, 38, 32);
      } else {
        rect(x + 3, y + i * 38, 32, 38);
      }
    }
    
    //Triangle tail depending on orientation
    if (horizontal) {
      triangle(x - 3 + 38 * shipLength, y + 19, x + 38 * shipLength - 38, y + 3, x + 38 * shipLength - 38, y + 35);
    } else {
      triangle(x + 19, y - 3 + 38 * shipLength, x + 3, y + 38 * shipLength - 38, x + 35, y + 38 * shipLength - 38);
    }
  }
  
  //Draws ship based on set location 
  void drawShipLoc() {
    drawShip(xStart, yStart);
  }

}
