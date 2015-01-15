PImage logo;

Board player1, player2;
boolean settingUp = false, startScreen = false;
int winner = -2;

void setup() {
  logo = loadImage("battleshiplogo.png");
  
  size(800, 800);
  background(0, 0, 0);
  textAlign(CENTER,CENTER);
  fill(255,255,255);
  textSize(60);
  text("Welcome to BattleShip!",400,100);
  text("Click anywhere to start!",400,700);
  
  image(logo,80,250,640,300);
}

void draw() {
  if (startScreen) {
  } else if (settingUp) {
  } else if (winner == -1) {
    for (int i = 0; i < 2; i++) {
      background(0,0,0);
      image(logo,0,0);
      
    }
  }
}

void mouseClicked() {

}

void keyPressed() {
  
}

