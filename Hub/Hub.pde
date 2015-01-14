import ddf.minim.*;

// INSTANCE VARIABLES ====================================================================================================================================================================================

private Minim loader;

//private Connect connect;
private Simon simon;
//private Trouble trouble;
//private ??? ???;

public int choice = 4;

// Setup() =============================================================================================================================================================================================

void setup() {
  loader = new Minim(this);
  
  if (choice == 4) { 
    
    //connect = new Connect();
    simon = new Simon();
    //trouble = new Trouble();
    
    size(800,800);
    background(0,0,0);
    textAlign(CENTER,CENTER);
    
    fill(255,0,0);
    rect(10,10,380,380);
    
    fill(0,255,0);
    rect(10,410,380,380);
    
    fill(0,0,255);
    rect(410,10,380,380);
    
   fill(255,255,0);
   rect(410,410,380,380);
   
   fill(204,204,204);
   ellipse(400,400,610,310);
   
   fill(0,0,0);
   ellipse(400,400,600,300);
   
   fill(255,255,255);
   textSize(55);
   text("Bob's Board Games",400,355);
   
   fill(204,204,204);
   textSize(25);
   text("Made by Sammi Wu Leung & Dillon Zhang",400,420);
   
   fill(150,150,150);
   textSize(10);
   text("A simple assortment of board and tabletop games that have been\n digitized for the modern day and age. Step into the future and\n stop worrying about pieces being lost and games being destroyed.",400,480);
    
   fill(255,255,255);
   textSize(30);
   
   //Connect 4 Quadrant
   text("Connect 4",200,50);
   
   //Simon Says Quadrant
   text("Simon Says",600,50);
   
   fill(0, 0, 0);
   ellipse(650, 180, 205, 205);

   fill(255, 0, 0);
   arc(655, 185, 170, 170, 0, HALF_PI);

   fill(0, 255, 0);
   arc(645 ,185, 170, 170, HALF_PI, PI);

   fill(0, 0, 255);
   arc(645, 175, 170, 170, PI, PI+HALF_PI);

   fill(255, 255, 0);
   arc(655, 175, 170, 170, PI+HALF_PI, 2*PI);
  
   fill(0, 0, 0);
   ellipse(650, 180, 50, 50);

   fill(204, 204, 204);
   ellipse(650, 180, 40, 40);
   
   text("Trouble!",200,750);
   
   text("COMING SOON",600,750);
   
  } else if (choice == 0) {
    //connect.setup();
  } else if (choice == 1) {
    simon.setup();
  } else if (choice == 2) {
    //trouble.setup();
  } else if (choice == 3) {
    //.setup()
  }
}

// draw() ================================================================================================================================================================================================

void draw() {
  if (choice == 4) {
    setup();
  } else if (choice == 0) {
    //connect.draw();
  } else if (choice == 1) {
    simon.draw();
  } else if (choice == 2) {
    //trouble.draw();
  } else if (choice == 3) {
    //.draw()
  }
}

// mouseClicked() ========================================================================================================================================================================================

void mouseClicked() {
  if (choice == 4) {
    if (mouseX < 400 && mouseY < 400){
      choice = 0;
      setup();
    } else if (mouseX > 400 && mouseY < 400){
      choice = 1;
      setup();
    } else if (mouseX < 400 && mouseY > 400){
      choice = 2;
      setup();
    } else if (mouseX > 400 && mouseY > 400){
      //choice = 3;
      //setup();
    }     
  } else if (choice == 0) {
    //connect.mouseClicked();
  } else if (choice == 1) {
    simon.mouseClicked();
  } else if (choice == 2) {
    //trouble.mouseClicked();
  } else if (choice == 3) {
    //.mouseClicked()
  }
}

// keyPressed() ==========================================================================================================================================================================================


void keyPressed() {
  if (choice == 4) {
    
    if (key == '1') {
      choice = 0;
      setup();
    } else if (key == '2') {
      choice = 1;
      setup();
    } else if (key == '3') {
      choice = 2;
      setup();
    } else if (key == '4') {
      //choice = 3;
      //setup();
    }
    
  } else if (choice == 0) {
    //connect.keyPressed();
  } else if (choice == 1) {
    simon.keyPressed();
  } else if (choice == 2) {
    //trouble.keyPressed();
  } else if (choice == 3) {
    //.keyPressed()
  }
}



