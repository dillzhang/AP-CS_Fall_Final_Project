//~~~~~~~~~~~~~~~~~~~~~~~~~Instansce variables~~~~~~~~~~~~~~~~~~~~~~~~~

private char[][] locations = new char[6][7];
private int turn = 0;
private int numTurns = 0;
private int clickLoc = 0;
private int addLoc = 0;
private int addCenter = 0;
private int addHeight = 0;
private int wr1,wr2,wr3,wr4,wc1,wc2,wc3,wc4;
private boolean winner = false;

//~~~~~~~~~~~~~~~~~~~~~~~~~The Setup~~~~~~~~~~~~~~~~~~~~~~~~~

/*
  Setup creates canvas that the whole game is to be played in. 
  It resets all the instance variables that need to be reset 
  in order to start a new game. It also creates the board,
  the new game button, and the Connect 4 title.
*/
void setup(){  
    numTurns = 0;
    turn = 0;
    winner = false;
    stroke(63,124,231);
    background(63,124,231);
    size(800,800);
    for (int r = 0; r < 6; r++){
	for (int c = 0; c < 7; c++){
	    if (locations[r][c] != 'n'){
		locations[r][c] = 'n';
	    }
	}
    }
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


//~~~~~~~~~~~~~~~~~~~~~~~~~Methods~~~~~~~~~~~~~~~~~~~~~~~~~

/* 
   centerX finds the x-component of circle/game piece (addCenter) 
   and the column (addLoc) in which the circle is to be created. 
   It is found based on where the user clicked (clickLoc).
*/
private void centerX(){
    if (clickLoc > 50 && clickLoc < 150){
        addLoc = 0;
    }
    if (clickLoc > 150 && clickLoc < 250){
        addLoc = 1;
    }
    if (clickLoc > 250 && clickLoc < 350){
        addLoc = 2;
    }
    if (clickLoc > 350 && clickLoc < 450){
        addLoc = 3;
    }if (clickLoc > 450 && clickLoc < 550){
        addLoc = 4;
    }
    if (clickLoc > 550 && clickLoc < 650){
        addLoc = 5;
    }
    if (clickLoc > 650 && clickLoc < 750){
        addLoc = 6;
    }
    addCenter = (addLoc + 1) * 100;
}
/*
  heightY finds the y-component of the center of the cicrle.
  It is based on addLoc (the column) in which the circle 
  would be at. The true or false comes to play when there
  is no more space in that column. If it cannot fit the circle
  in the column, the next method (addPiece) would not be called.
*/
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
/*
  addPiece adds the circle to the correct place based
  on the previous methods. The turn determines the color
  that the circle would be and if it would be counted as
  an additional turn. Turn 1 is the black circle; Turn 2, 
  the red one; Turn 3 the winning "grey" circle (black);
  and Turn 4 the winning "pink" color (red). 
*/
private void addPiece(){
    if (turn == 0){
	stroke(0,0,0);
	fill(0,0,0);
	ellipse(addCenter,addHeight,70,70);
	numTurns++;
	turn = 1;
    } else if (turn == 1){
	stroke(195,2,8);
	fill(195,2,8);
	ellipse(addCenter,addHeight,70,70);
	turn = 0;
	numTurns++;
    } else if (turn == 3){
	stroke(50,45,45);
	fill(50,45,45);
	ellipse(addCenter,addHeight,70,70);
    } else {
	stroke(255,35,75);
	fill(255,35,75);
	ellipse(addCenter,addHeight,70,70);
    }
}

/*
  checkWin checks whether any of all of the possible
  winning scenarios are met. If it is, it sets wr1,
  wr2, wr3, wr4, cr1, cr2, cr3, & cr4 to the correct
  winning circles as well as the instance variable 
  "winner" to be true.
*/
private void checkWin(){
    int matches = 0;
    int r = 0;
    int c = 0;
    for (r = 0; r < 6; r++){
	for (c = 0; c < 4; c++){
	    if (locations[r][c] != 'n'){
		if (locations[r][c] == locations[r][c+1]) matches++;
		if (locations[r][c] == locations[r][c+2]) matches++;
		if (locations[r][c] == locations[r][c+3]) matches++;
		if (matches == 3){
                    wr1 = wr2 = wr3 = wr4 = r;
                    wc1 = c;
                    wc2 = c + 1;
                    wc3 = c + 2;
                    wc4 = c + 3;
                    winner = true;
                }
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
		if (matches == 3){
                    wc1 = wc2 = wc3 = wc4 = c;
                    wr1 = r;
                    wr2 = r + 1;
                    wr3 = r + 2;
                    wr4 = r + 3;
                    winner = true;
                }
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
		if (matches == 3){
                    wr1 = r;
                    wr2 = r + 1;
                    wr3 = r + 2;
                    wr4 = r + 3;
                    wc1 = c;
                    wc2 = c + 1;
                    wc3 = c + 2;
                    wc4 = c + 3;
                    winner = true;
                }
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
		if (matches == 3){
                    wr1 = r;
                    wr2 = r - 1;
                    wr3 = r - 2;
                    wr4 = r - 3;
                    wc1 = c;
                    wc2 = c + 1;
                    wc3 = c + 2;
                    wc4 = c + 3;
                    winner = true;
                }
	    }
	    matches = 0;
	}
    }
}
/*
  showWin shows the winner if the instance variable
  "winner" is true. It displays a banner with the 
  winner on where "Connect 4" would be at (on the top).
  It also changes the winning circles to a slightly 
  modified color to help the user see who won.
  If it is a tie (the board is filled), a banner 
  with "Tie" written on it shows up where "Connect 4"
  would be written.
*/
private void showWin(){
    if (winner){
	if (turn == 1){
	    fill(255,255,255);
	    stroke(255,255,255);
	    rect(50,0,700,105);
	    textSize(60);
	    fill(0,0,0);
	    text("Black Wins",250,70);
	}
	if (turn == 0){
	    fill(255,255,255);
	    stroke(255,255,255);
	    rect(50,0,700,105);
	    textSize(60);
	    fill(255,0,0);
	    text("Red Wins",275,70);
	}
	if (turn == 0) turn = 4;
	if (turn == 1) turn = 3;
	addCenter = (wc1 + 1) * 100;
	addHeight = 700 - wr1*100;
	addPiece();
	addCenter = (wc2 + 1) * 100;
	addHeight = 700 - wr2*100;
	addPiece();
	addCenter = (wc3 + 1) * 100;
	addHeight = 700 - wr3*100;
	addPiece();
	addCenter = (wc4 + 1) * 100;
	addHeight = 700 - wr4*100;
	addPiece();
    } else if (numTurns == 42){
	fill(255,255,255);
	stroke(255,255,255);
	rect(50,0,700,105);
	textSize(60);
	fill(255,0,0);
	text("Tie",357,70);
    }
  
} 
//~~~~~~~~~~~~~~~~~~~~~~~~~Running the Game~~~~~~~~~~~~~~~~~~~~~~~~~
/*
  mouseClicked checks what to do depending on the location of 
  the click. It only does something when you legally play a 
  piece or if you pressed "new Game".
*/
void mouseClicked(){
    if (!winner && numTurns < 42){
	if (mouseX > 50 && mouseX < 750 && mouseY > 150){
	    clickLoc = mouseX;
	    centerX();
	    if (heightY())addPiece();
	}
	checkWin();
    }
    if (mouseX > 70 && mouseX < 208 && mouseY > 110 && mouseY < 140){
	setup();
    }
}
// if the letter "n" is pressed, a new game is setup
void keyPressed(){
    if (key == 'n') setup();
}
// it continously shows the winner if any of the conditions described above
void draw(){
    showWin();
}
