import java.util.Random;
import java.util.Arrays;

private int[][] basic = new int[][]{{770,400},{757,496},{720,585},{662,662}, {585,720}, {496,757},{400,770},{304,757},{215,720},{138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304},{610,185},{570,225},{530,265},{490,305},{610,615},{570,575},{530,535},{490,495},{190,615},{230,575},{270,535},{310,495},{190,185},{230,225},{270,265},{310,305}};

private int[][] yellowPath = new int[][] {{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585},{662,662}, {585,720},{496,757},{400,770},{304,757},{215,720},{138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{610,185},{570,225},{530,265},{490,305}};

private int[][] bluePath = new int[][] {{662,662}, {585,720},{496,757},{400,770},{304,757},{215,720},{138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585},{610,615},{570,575},{530,535},{490,495}};

private int[][] redPath = new int[][] { {138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585}, {662,662}, {585,720},{496,757},{400,770},{304,757},{215,720},{190,615},{230,575},{270,535},{310,495}};

private int[][] greenPath = new int[][] { {138,138},{215,80},{304,43},{400,30},{496,43},{585,80},{662,138},{720,215},{757,304}, {770,400},{757,496},{720,585}, {662,662}, {585,720},{496,757},{400,770},{304,757},{215,720}, {138,662},{80,585},{43,496},{30,400},{43,304},{80,215},{190,185},{230,225},{270,265},{310,305}};

private boolean clicked, circle, newGame,choose,choosing,rolling,startGame;
private boolean gPlayer,yPlayer,rPlayer,bPlayer;
private int roll, time;
private Random r = new Random();
private int[][] pInfo = new int[4][5];
private int[][] order = new int[4][2];
private int turn;

void setup(){
    size(800,800);
    frameRate(30);
    PFont font;
    font = createFont("bubble.ttf",200);
    textFont(font);
    newGame = true;
    for (int x = 0; x < 4; x++){
	for (int y = 0; y < 5; y++){
	    if (y == 0) pInfo[x][y] = 1;
	    else pInfo[x][y] = 0;
	}
    }
    for (int x = 0; x < 4; x++){
	order[x][0] = 0;
        order[x][1] = 0;
    }
    gPlayer = yPlayer = rPlayer = bPlayer = clicked = circle = newGame = choose = choosing = rolling = startGame = false;
    turn = 0;
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
    stroke(0);
    strokeWeight(5);
    ellipse(400,400,200,200);
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
    choose = true;
}

private void choosePlayer(int player){
    int loc = player -1;
    if (pInfo[loc][0] == -1){
	pInfo[loc][0] = 0;
    } else if (pInfo[loc][0] == 0){
	pInfo[loc][0] = 1;
    } else if (pInfo[loc][0] == 1){
	pInfo[loc][0] = -1;
    }
}

private void showPlayers(){
    stroke(0);
    strokeWeight(5);
    fill(15,140,20);
    rect(45,295,340,200);
    fill(255);
    textSize(200);
    if (pInfo[0][0] == -1){
	text("AI",210,255);
    } else if (pInfo[0][0] == 0){
	text("P",210,255);
    } else if (pInfo[0][0] == 1){
	textSize(150);
	text("N/A",212,285);
    }
    fill(255,215,20);
    rect(415,295,340,200);
    fill(255);
    textSize(200);
    if (pInfo[1][0] == -1){
	text("AI",590,255);
    } else if (pInfo[1][0] == 0){
	text("P",590,255);
    } else if (pInfo[1][0] == 1){
	textSize(150);
	text("N/A",590,285);
    }
    fill(200,0,10);
    rect(45,525,340,200);
    fill(255);
    textSize(200);
    if (pInfo[2][0] == -1){
	text("AI",210,490);
    } else if (pInfo[2][0] == 0){
	text("P",210,490);
    } else if (pInfo[2][0] == 1){
	textSize(150);
	text("N/A",212,520);
    }
    fill(0,50,220);
    rect(415,525,340,200);
    fill(255);
    textSize(200);
    if (pInfo[3][0] == -1){
	text("AI",590,490);
    } else if (pInfo[3][0] == 0){
	text("P",590,490);
    } else if (pInfo[3][0] == 1){
	textSize(150);
	text("N/A",590,520);
    }   
    if (checkPlayer()){
	fill(255);
	textSize(60);
	text("DONE",400,725);
	stroke(255);
	noFill();
	strokeWeight(5);
	rect(300,735,200,60);
    } else {
	fill(0);
	rect(300,735,200,60);
    }
}

private boolean checkPlayer(){
    int numP = 0;
    int numAI = 0;
    for (int p = 0; p < 4; p++){
	if (pInfo[p][0] == 0) numP++;
	if (pInfo[p][0] == -1) numAI++;
    }
    if (numP >= 2) return true;
    if (numP >= 1 && numAI >= 1) return true;
    return false;
}

private boolean checkQuad(){
    int numPlayers = 0;
    int numOrdered = 0;
    for (int p = 0; p < 4; p++){
	if ((pInfo[p][0] == 0) || (pInfo[p][0] == -1)) numPlayers++;
	if (order[p][0] >= 1) numOrdered++;
    }
    if (numPlayers == numOrdered) return true;
    return false;
}

private void sortOrder(){
    for (int n = 0;n < 4; n++){
	int loc;
	int temp = order[n][0];
	for (loc = n; loc > 0 && order[n][0] < order[n-1][0]; loc--){
	    order[loc][0] = order[loc - 1][0];
	}
	order[loc][0] = temp;
    } 
}

private void chooseOrder(){
    fill(0);
    stroke(0);
    rect(0,0,800,800);
    if (pInfo[0][0] != 1) {
	fill(15,140,25);
	rect(0,0,400,400);
    }
    if (pInfo[1][0] != 1) {
	fill(255,215,20);
	rect(400,0,400,400);
    }
    if (pInfo[2][0] != 1) {
	fill(200,0,10);
	rect(0,400,400,400);
    }
    if (pInfo[3][0] != 1) {
	fill(0,50,220);
	rect(400,400,400,400);
    }
    fill(205);
    stroke(0);
    strokeWeight(5);
    ellipse(400,400,200,200);
    textAlign(CENTER,TOP);
    textSize(100);
    fill(255);
    textSize(40);
    fill(64,0,128);
    text("Click each quadrant to roll for order:",400,100);
}

private void showQuad(){
    fill(0);
    stroke(0);
    rect(0,0,800,800);
    if (pInfo[0][0] != 1) {
	fill(15,140,25);
	rect(0,0,400,400);
    }
    if (pInfo[1][0] != 1) {
	fill(255,215,20);
	rect(400,0,400,400);
    }
    if (pInfo[2][0] != 1) {
	fill(200,0,10);
	rect(0,400,400,400);
    }
    if (pInfo[3][0] != 1) {
	fill(0,50,220);
	rect(400,400,400,400);

    }
    fill(0);
    textSize(400);
    textAlign(CENTER,TOP);
    if (order[0][0] > 0){
	text(order[0][0],200,-100);
    }
    if (order[1][0] > 0){
	text(order[1][0],600,-100);
    }
    if (order[2][0] > 0){
	text(order[2][0],200,300);
    }
    if (order[3][0] >0){
	text(order[3][0],600,300);
    }
    fill(205);
    stroke(0);
    strokeWeight(5);
    ellipse(400,400,200,200);
    if (checkQuad()){
	fill(0);
	textSize(75);
	text("Done",400,350);
	sortOrder();
        print(duh());
	//Arrays.sort(order);
	startGame = true;
    }
}


private void flashR(){
    textAlign(BASELINE);
    int a = r.nextInt(6) + 1;
    if (circle){
	fill(0);
	textSize(180);
	text("" + a, 350,470);
	circle = false;
    } else {
	fill(205);
	stroke(0);
        strokeWeight(5);
	ellipse(400,400,200,200);
	circle = true;
    }
}

private void showRoll(){
    clicked = false;
    rolling = false;
    fill(205);
    stroke(0);
    strokeWeight(5);
    ellipse(400,400,200,200);
    fill(0);
    textSize(180);
    text("" + roll,350,470);
}

void mouseClicked(){
    if (dist(mouseX,mouseY,400,400)<= 100 && !newGame && !choose && !choosing){
	roll = r.nextInt(6) + 1;
        rolling = true;
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
    if (checkPlayer() && mouseX >= 300 && mouseX <= 500 && mouseY >= 735 && mouseY <= 795){
	newGame = false;
	choose = false; 
        choosing = true;
        chooseOrder();
	//drawBoard();
    }
    if (choosing && mouseX >= 0 && mouseX <= 400 && mouseY >= 0 && mouseY <= 400 && pInfo[0][0] != 1 && !gPlayer  && !choose  && !rolling){
	roll = r.nextInt(6) + 1;
	rolling = true;
	clicked = true;
	time = second();
	gPlayer = true;
	order[0][0] = roll;
	order[0][1] = 0;
    }
    if (choosing && mouseX >= 400 && mouseY <= 400 && pInfo[1][0] != 1 && !yPlayer && !choose  && !rolling){
	roll = r.nextInt(6) + 1;
	rolling = true;
	clicked = true;
	time = second();
	yPlayer = true;
	order[1][0] = roll;
	order[1][1] = 1;
    }
    if (choosing && mouseX >= 0 && mouseX <= 400 && mouseY >= 400 && pInfo[2][0] != 1 && !rPlayer && !choose  && !rolling){
	roll = r.nextInt(6) + 1;
	rolling = true;
	clicked = true;
	time = second();
	rPlayer = true;
	order[2][0] = roll;
	order[2][1] = 2;
    }
    if (choosing && mouseX >= 400 && mouseY >= 400 && pInfo[3][0] != 1 && !bPlayer && !choose && !rolling){
	roll = r.nextInt(6) + 1;
	rolling = true;
	clicked = true;
	time = second();
	bPlayer = true;
	order[3][0] = roll;
	order[3][1] = 3;
    }
    if (startGame && dist(mouseX,mouseY,400,400)<= 100 && choosing && !newGame && !choose){
	drawBoard();
    }
}

void keyPressed(){
    if (key == 's') setup();
}
void draw(){
    if (second() < (time + 2) && clicked && !newGame && !choose) flashR();
    else if (clicked) showRoll();
    if (second() > (time + 1) && choosing && !newGame && !choose && !startGame) showQuad();
    //if (second() < (time + 2) && organize && !choose & !newGame) beginGame();
    //if (order) beginGame();
    if (choose && newGame) showPlayers();
}

public String duh(){
  String s = "";
  for (int u = 0; u < 4; u++){
    s += order[u][0] + " + ";
  }
  s += "\n";
  return s;
}

