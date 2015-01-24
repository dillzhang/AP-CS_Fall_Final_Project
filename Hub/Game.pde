//Old idea to simplify hub code, No real purpose, but allows for consistancy when coding Games as classes

abstract class Game {
  //Forces the game to have the following functions as a class
  abstract void setup();
  abstract void draw();
  abstract void mouseClicked();
  abstract void keyPressed();
}
