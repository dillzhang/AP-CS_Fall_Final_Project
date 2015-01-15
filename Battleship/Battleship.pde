PImage logo;

Board player1, player2;
boolean startScreen, settingUp, playerChange;
int winner;

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
  
  //Game Play
  startScreen = true;
  settingUp = true;
  winner = -2;
  playerChange = true;
}

void draw() {
  if (startScreen) {
    
  } else if (settingUp) {
    
    for (int i = 0; i < 2; i++) {
    
    }
    
  } else if (winner == -1) {
    
    for (int i = 0; i < 2; i++) {
      if(playerChange) {
        background(0,0,0);
        
      } else {
        
      }
      
    }
  
}
}

void mouseClicked() {

}

void keyPressed() {
  
}

