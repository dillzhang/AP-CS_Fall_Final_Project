AP-CS_Final_Project: Bob's Board Games
======================================

Final Project for AP Computer Science Fall 2014

Members
=======
Sammi Wu Leung & Dillon Zhang (Period 2)

Project
=======
Classic Board Games Reborn on the Computer through Processing
- [X] Connect 4  -> Completed by SWL
- [X] Simon Says -> Completed by DZ
- [X] Battleship -> Completed by DZ
- [X] Trouble -> Completed by SWL
- [ ] Go
- [ ] Chess
- [ ] Checker
- [ ] Sorry

The number of games will depend on what time allows.
If time allows, AI will be added to some games to allow for single and multiplayer.

Link games together with a central HUB with Processing
- [X] Create HUB to link games -> Completed by DZ

Usage
=====
Our project is a combination of four board games, Battleship, Connect 4, Simon Says, & Trouble. There are two main ways to run our project. 

The first method is selecting a game and downloading the corresponding folder. Each game can run on its own within its folder. To run the game, open its main Processing file. <GameName>.pde These games are slighty rudimentary compared to the final game put in the main hub, but will provide proper game play.

The second method is downloading the hub folder. Run Hub.pde in order to start the games. It will open a main menu where one can select games. One can always return to the main menu throught the clicking of the 'Return to Hub' or pressing the 'm' key. 

_Battleship_
Battleship is a 2-player game. It starts with the setup phase where users will be prompted to place their ships on the board. The next phase is the gameplay where users take turns guessing the locations of the other ships. The first person to strike all the opponent's ship wins the game. ALl gameplay is done through the mouse.

_Connect 4_
Connect 4 is a 2-player game. It starts auttomatically with a new game. The first player is the color black; the second, red. Players try to have 4 adjacent pieces that are either vertical, horizontal, or diagonal to each other. The first person to do so, wins the game. Gameplay can be done with either keyboard keys or by clicking.

_Simon Says_
Simon Says is a simple pattern memorization game. The computer will play a sequence and the user has to memorize it. You can either play with the mouse by clicking on the color sectors or using the keys 'h', 'g', 't', or 'y'. 

_Trouble_
Trouble is a simple 2-4 player board game. You first choose the amount of players then the order is randomly selected – lower rolls play first. After that, the goal is to go around the board from each player's starting point once to win. The game is purely clicking-only.

Change Log
==========
| Timestamp  | Contributor  | Description |
|:-----------|:------------:|:------------|
| 2014-12-19 | DZ           | Created Repo and README.md |
| 2014-12-23 | DZ           | Started Project Simon |
| 2014-12-23 | DZ           | Implemented Flash functions |
| 2014-12-23 | SWL          | Started Project Connect 4 |
| 2014-12-23 | SWL          | *Finished* basics for Connect 4 |
| 2014-12-24 | SWL          | Added graphics to show the winner in a clearer fashion |
| 2014-12-25 | DZ           | Able to flash colors and keep original shape |
| 2014-12-25 | DZ           | Flashing colors change back to original color after slight delay | 
| 2014-12-27 | SWL          | Added help menu onto Connect 4 and made it playable with just the keyboard keys. Also created the background for Trouble |
| 2014-12-28 | DZ           | Added level creation, Encountering delay issues with visuals - Looking for solutions |
| 2015-01-05 | DZ           | Added level creation, Resolved timing issue |
| 2015-01-05 | SWL          | Figured out how to evenly space circles around board |
| 2015-01-06 | SWL          | Created the board & background for Trouble |
| 2015-01-06 | DZ           | Added user input recording and win checker |
| 2015-01-07 | DZ           | Added Visual for losing and winning |
| 2015-01-07 | SWL          | Added random number flasher and number picker |
| 2015-01-08 | DZ           | *Finished* Game, Added Win, Lose, and Start Screen - May add sound later |
| 2015-01-08 | SWL          | Added S for start postiion & preliminary prompt menu |
| 2015-01-09 | DZ           | Added startscreen design, beep tones for four buttons, victory and lose sounds to Simon |
| 2015-01-11 | SWL          | Finished startscreen |
| 2015-01-12 | DZ           | Added Team Name |
| 2015-01-12 | DZ           | Fixed screen between levels, prevent clicking on level setup |
| 2015-01-13 | DZ           | Created Hub, Wrote new version of simon as a class, Designed Hub, Connected Simon to Hub |
| 2015-01-14 | DZ           | Created Abstract Game class for organization, Cleaned up Simon, Created pathway back to hub |
| 2015-01-14 | SWL          | Created a startup screen for Connect 4 |
| 2015-01-14 | SWL          | Added a checker for choosing players to ensure there is at least one human player and an opponent at all times |
| 2015-01-14 | DZ           | Started Battleship, Created Ship and Board Class |
| 2015-01-15 | DZ           | Integrated Connect into Hub, Added Picture for Connect, Renamed files to specific games |
| 2015-01-15 | DZ           | Fixed Hub's Strokes, Modified Simon start screen to display help info |
| 2015-01-15 | SWL          | Added a box to Connect 4 that tells the turn |
| 2015-01-15 | DZ           | Added Connect modification to Hub |
| 2015-01-16 | DZ           | Worked on Battleship, Attempted Board Setup | 
| 2015-01-17 | DZ           | Fixed Ship Placement for Battleship |
| 2015-01-19 | SWL          | Completed startscreen for Trouble | 
| 2015-01-19 | SWL          | Fixed the paths each color takes in Trouble |
| 2015-01-20 | DZ           | Started Gameplay, Draws own and opponents board, Adds targeting animation |
| 2015-01-20 | SWL          | Redid my mess with boolean variables and simplified my order-choosing for Trouble |
| 2015-01-20 | DZ           | Changed Player turns and allowed for marking of ships being hit |
| 2015-01-21 | SWL          | Began working on turns and added visual onto the board |
| 2015-01-22 | DZ           | *Finished* Battleship, Added Audio to Battleship, Cleaned up transitions, Added informational text, Modified formating |
| 2015-01-22 | DZ           | Integrated Battleship into Hub, Modified to return to hub and act as a class file, Add section in Hub |
| 2015-01-22 | DZ           | Commented for stand-alone Simon |
| 2015-01-22 | DZ           | Commented for connect-hub Simon |
| 2015-01-22 | SWL          | Removed AI from Trouble and made a basic version of it |
| 2015-01-22 | SWL          | Commented on stand-alone Trouble |
| 2015-01-23 | DZ           | Connected Trouble to Hub and added Hub image | 
| 2015-01-23 | SWL          | Added Usage to README | 
