void setup(){
    stroke(63,124,231);
    background(63,124,231);
    size(800,800);
    fill(231,214,26);
    rect(50,150,700,600);
    textSize(100);
    fill(255,255,255);
    text("Connect Four",75, 100);
    int x = 100;
    int y = 200;
    fill(63,124,231);
    for (int r = 0; r < 6; r++){
      for (int c = 0; c < 7; c++){
         ellipse(x,y,70,70);
         x += 100;
      }  
    x = 100;
    y += 100;
    }
}


