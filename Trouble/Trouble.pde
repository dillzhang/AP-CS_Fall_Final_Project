import java.util.Random;

private int[][] basic = new int[][]{{770,400},{757,496},{720,585},{662,662}, {585,720},
				    {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},
				    {43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},
				    {400,30},{496,43},{585,80},{662,138},{720,215},{757,304},
				    {610,185},{570,225},{530,265},{490,305},{610,615},{570,575},
				    {530,535},{490,495},{190,615},{230,575},{270,535},{310,495},
				    {190,185},{230,225},{270,265},{310,305}};
private int[][] yellow = new int[][] {{770,400},{757,496},{720,585},{662,662}, {585,720},
				      {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},
				      {43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},
				      {400,30},{496,43},{585,80},{662,138},{720,215},{757,304},
				      {610,185},{570,225},{530,265},{490,305}};
private int[][] blue = new int[][] {{770,400},{757,496},{720,585},{662,662}, {585,720},
				    {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},
				    {43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},
				    {400,30},{496,43},{585,80},{662,138},{720,215},{757,304},
				    {610,615},{570,575},{530,535},{490,495}};
private int[][] red = new int[][] {{770,400},{757,496},{720,585},{662,662}, {585,720},
				   {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},
				   {43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},
				   {400,30},{496,43},{585,80},{662,138},{720,215},{757,304},
				   {190,615},{230,575},{270,535},{310,495}};
private int[][] green = new int[][] {{770,400},{757,496},{720,585},{662,662}, {585,720},
				     {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},	     
                                     {43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},
				     {400,30},{496,43},{585,80},{662,138},{720,215},{757,304},
				     {190,185},{230,225},{270,265},{310,305}};
private boolean clicked, circle, newGame,choose;
private int roll, time;
private Random r = new Random();
private int[][] pInfo = new int[4][5];

void setup(){
    size(800,800);
    frameRate(30);
    //PFont font;
    //font = createFont("bubble.ttf",200);
    //textFont(font);
    newGame = true;
    for (int x = 0; x < 4; x++){
	for (int y = 0; y < 5; y++){
	    if (y == 0) pInfo[x][y] = -1;
	    else pInfo[x][y] = 0;
	}
    }
    promptNewGame();
}

private void drawBoard(){
    textAlign(BASELINE);
    stroke(15,140,20);
    fill(15,140,20);
    rect(0,0,400,400);
    stroke(255,215,20);
    fill(255,215,20);
    rect(400,0,400,400);
    stroke(200,0,10);
    fill(200,0,10);
    rect(0,400,400,400);
    stroke(0,50,220);
    fill(0,50,220);
    rect(400,400,400,400);
    fill(25);
    stroke(25);
    ellipse(400,400,800,800);
    fill(64,0,128);
    arc(450,400,550,575,-QUARTER_PI,QUARTER_PI);
    arc(400,450,550,575,QUARTER_PI,(3)*QUARTER_PI);
    arc(350,400,550,575,3*QUARTER_PI,5*QUARTER_PI);
    arc(400,350,550,575,5*QUARTER_PI,7*QUARTER_PI);  
    fill(205);
    stroke(205);
    ellipse(400,400,200,200);
    strokeWeight(5);
    stroke(0);
    for (int x = 0; x < basic.length; x++){
	if (x > 23) fill(255,255,70);
	if (x > 27) fill(0,90,255);
	if (x > 31) fill(255,60,40);
	if (x > 35) fill(80,210,70);
	ellipse(basic[x][0],basic[x][1],40,40);
    }
    textSize(30);
    fill(0,50,220);
    text('S',655,675);
    fill(200,0,10);
    text('S',130,675);
    fill(15,140,20);
    text('S',130,150);
    fill(255,215,20);
    text('S',655,150);
}

private void flashR(){
    int a = r.nextInt(6) + 1;
    if (circle){
	fill(0);
	textSize(180);
	text("" + a, 355,470);
	circle = false;
    } else {
	fill(205);
	stroke(205);
	ellipse(400,400,200,200);
	circle = true;
    }
}

private void showRoll(){
    clicked = false;
    fill(205);
    stroke(205);
    ellipse(400,400,200,200);
    fill(0);
    textSize(180);
    text("" + roll,355,470);
}

private void promptNewGame(){
    newGame = true;
    stroke(0);
    fill(0);
    rect(0,0,800,800);
    fill(255);
    textAlign(CENTER,TOP);
    textSize(100);
    text("TROUBLE",400,0);
    textSize(50);
    fill(230,230,0);
    text("Start a New Game",400,110);
    fill(255);
    text("How many players are playing?",400,170);
    textSize(30);
    fill(0,50,220);
    text("Click to Change Settings",400,245);
    textSize(150);
    fill(15,140,20);
    rect(45,295,340,200);
    fill(255);
    text("N/A",212,285);
    fill(255,215,20);
    rect(415,295,340,200);
    fill(255);
    text("N/A",590,285);
    fill(200,0,10);
    rect(45,525,340,200);
    fill(255);
    text("N/A",212,520);
    fill(0,50,220);
    rect(415,525,340,200);
    fill(255);
    text("N/A",590,520);
    textSize(60);
    text("DONE",400,725);
    stroke(255);
    noFill();
    strokeWeight(5);
    rect(300,735,200,60);
    choose = true;
}

private void choosePlayer(int player){
    fill(255);
    fill(0,50,220);
    stroke(0);
    if (player == 1){
	fill(15,140,20);
	rect(45,295,340,200);
        fill(255);
        textSize(200);
        if (pInfo[0][0] == -1){
	    pInfo[0][0] = 0;
	    text("AI",210,255);
        
        } else if (pInfo[0][0] == 0){
	    text("P",210,255);
	    pInfo[0][0] = 1;
        } else if (pInfo[0][0] == 1){
	    textSize(150);
	    text("N/A",212,285);
	    pInfo[0][0] = -1;
        }
    }
    if (player == 2){
	fill(255,215,20);
	rect(415,295,340,200);
	fill(255);
	textSize(200);
        if (pInfo[1][0] == -1){
	    pInfo[1][0] = 0;
	    text("AI",590,255);
        
        } else if (pInfo[1][0] == 0){
	    text("P",590,255);
	    pInfo[1][0] = 1;
        } else if (pInfo[1][0] == 1){
	    textSize(150);
            text("N/A",590,285);
	    pInfo[1][0] = -1;
        }
    }
    if (player == 3){
	fill(200,0,10);
	rect(45,525,340,200);
	fill(255);
        textSize(200);
	if (pInfo[2][0] == -1){
	    pInfo[2][0] = 0;
	    text("AI",210,490);
        
        } else if (pInfo[2][0] == 0){
	    text("P",210,490);
	    pInfo[2][0] = 1;
        } else if (pInfo[2][0] == 1){
	    textSize(150);
	    text("N/A",212,520);
	    pInfo[2][0] = -1;
        }
    }
    if (player == 4){
	fill(0,50,220);
	rect(415,525,340,200);
	fill(255);
	textSize(200);
	if (pInfo[3][0] == -1){
	    pInfo[3][0] = 0;
	    text("AI",590,490);
        
        } else if (pInfo[3][0] == 0){
	    text("P",590,490);
	    pInfo[3][0] = 1;
        } else if (pInfo[3][0] == 1){
	    textSize(150);
	    text("N/A",590,520);
	    pInfo[3][0] = -1;
        }
    }
}
void mouseClicked(){
    if (dist(mouseX,mouseY,400,400)<= 100 && !newGame && !choose){
	roll = r.nextInt(6) + 1;
	clicked = true;
	time = second();
    }
    if (choose && mouseX >= 15 && mouseX <= 385  && mouseY >= 295 && mouseY <= 495){
	choosePlayer(1);
    }
    if (choose && mouseX >= 415 && mouseX <= 755 && mouseY >= 295 && mouseY <= 495){
	choosePlayer(2);
    }
    if (choose && mouseX >= 15 && mouseX <= 385 && mouseY >= 525 && mouseY <= 725){
	choosePlayer(3);
    }
    if (choose && mouseX >= 415 && mouseX <= 755 && mouseY >= 525 && mouseY <= 725){
	choosePlayer(4);
    }
    if (choose && mouseX >= 300 && mouseX <= 500 && mouseY >= 735 && mouseY <= 795){
	newGame = false;
	choose = false; 
	drawBoard();
    }
}

void keyPressed(){
    if (key == 's') promptNewGame();
}
void draw(){
    if (second() < (time + 2) && clicked) flashR();
    else if (clicked) showRoll();
}
