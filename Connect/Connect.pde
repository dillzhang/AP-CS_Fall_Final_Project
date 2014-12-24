private char[][] locations = new char[6][7];
private int turn = 0;
private int numTurns = 0;
private int clickLoc = 0;
private int addLoc = 0;
private int addCenter = 0;
private int addHeight = 0;
public void setClickLoc(int xLoc){
    clickLoc = xLoc;
}
  
public Connect(){
    for (int r = 0; r < 6; r++){
	for (int c = 0; c < 7; c++){
	    locations[r][c] = 'n';
	}
    }
}

    
public void setupGame(){
    for (int r = 0; r < 6; r++){
	for (int c = 0; c < 7; c++){
	    if (locations[r][c] != 'n'){
		locations[r][c] = 'n';
	    }
	}
    }
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
    stroke(255,255,255);
    rect(70,110,138,30);
    textSize(25);
    fill(255,255,255);
    text("New Game",75,135);
}
  
private void centerX(){
    if (clickLoc > 50 && clickLoc < 150){
        addLoc = 0;
        addCenter = 100;
    }
    if (clickLoc > 150 && clickLoc < 250){
        addLoc = 1;
        addCenter = 200;
    }
    if (clickLoc > 250 && clickLoc < 350){
        addLoc = 2;
        addCenter = 300;
    }
    if (clickLoc > 350 && clickLoc < 450){
        addLoc = 3;
        addCenter = 400;
    }if (clickLoc > 450 && clickLoc < 550){
        addLoc = 4;
        addCenter = 500;
    }
    if (clickLoc > 550 && clickLoc < 650){
        addLoc = 5;
        addCenter = 600;
    }
    if (clickLoc > 650 && clickLoc < 750){
        addLoc = 6;
        addCenter = 700;
    }
}
  
private boolean heightY(){
    for (int r = 0; r < 6; r++){
	if (locations[r][addLoc] == 'n'){
	    if (turn == 0) locations[r][addLoc] = 'b';
	    if (turn == 1) locations[r][addLoc] = 'r';
	    addHeight = 700 - r*100;
	    return true;
	}
    }
    return false;
}
  
private void addPiece(){
    if (turn == 0){
	stroke(0,0,0);
	fill(0,0,0);
	ellipse(addCenter,addHeight,70,70);
	numTurns++;
	turn = 1;
    } else{
	stroke(195,2,8);
	fill(195,2,8);
	ellipse(addCenter,addHeight,70,70);
	turn = 0;
	numTurns++;
    }
}
  
private boolean checkWin(){
    int matches = 0;
    int r = 0;
    int c = 0;
    for (r = 0; r < 6; r++){
	for (c = 0; c < 4; c++){
	    if (locations[r][c] != 'n'){
		if (locations[r][c] == locations[r][c+1]) matches++;
		if (locations[r][c] == locations[r][c+2]) matches++;
		if (locations[r][c] == locations[r][c+3]) matches++;
		if (matches == 3) return true;
	    }
	    matches = 0;
	}
    }
    for (c = 0; c < 7; c++){
	for (r = 0; r < 3; r++){
	    if (locations[r][c] != 'n'){
		if (locations[r][c] == locations[r+1][c]) matches++;
		if (locations[r][c] == locations[r+2][c]) matches++;
		if (locations[r][c] == locations[r+3][c]) matches++;
		if (matches == 3) return true;
	    }
	    matches = 0;
	}
    } 
    
    for (r = 0; r < 3; r++){
	for (c = 0; c < 4;c++){
	    if (locations[r][c] != 'n'){
		if (locations[r][c] == locations[r+1][c+1]) matches++;
		if (locations[r][c] == locations[r+2][c+2]) matches++;
		if (locations[r][c] == locations[r+3][c+3]) matches++;
		if (matches == 3) return true;
	    }
	    matches = 0;
	}
    }
    
    for (r = 3; r < 6; r++){
	for (c = 0; c < 4; c++){
	    if (locations[r][c] != 'n'){
		if (locations[r][c] == locations[r-1][c+1]) matches++;
		if (locations[r][c] == locations[r-2][c+2]) matches++;
		if (locations[r][c] == locations[r-3][c+3]) matches++;
		if (matches == 3) return true;
	    }
	    matches = 0;
	}
    }
    return false;
}
private void newGame(){
    setupGame();
    numTurns = 0;
    turn = 0;
}   


void setup(){
    setupGame();
}

void mouseClicked(){
    if (!checkWin() && numTurns < 42){
	if (mouseX > 50 && mouseX < 750 && mouseY > 150){
	    setClickLoc(mouseX);
	    centerX();
	    if (heightY())addPiece();
	}
    }
    if (mouseX > 70 && mouseX < 208 && mouseY > 110 && mouseY < 140){
	newGame();
    }
}

void keyPressed(){
    if (key == 'n') newGame();
}
void draw(){
}
