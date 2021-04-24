final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int INITIAL_LIFE_X = 10;
final int LIFE_SPACE = 70;
int lifeAmount = max(-1,5);

int block = 80; 
int layer;
int cameraOffset;

float soldierX,soldierY;
int soldierSpeed;

float cabbageX,cabbageY;

float groundHogX = 320, groundHogY = 80;
float actionFrame;
boolean downPressed = false,leftPressed = false,rightPressed = false;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, life, cabbage, soldier;
PImage groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;
PImage soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  lifeAmount = 2;
  playerHealth = lifeAmount;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

  translate(0, cameraOffset);  
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		  image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
  		fill(124, 204, 25);
  		noStroke();
  		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
  		//floor 1-4
        for(int i=0; i < 8*block; i+=block){
          for(int j=0; j< 4*block; j+=block){
            image(soil0, i , 2*block+j);
          }
        }
      //floor 5-8
        for(int i=0; i < 8*block; i+=block){
          for(int j=0; j< 4*block; j+=block){
            image(soil1, i , 6*block+j);
          }
        }
      //floor 9-12
        for(int i=0; i < 8*block; i+=block){
          for(int j=0; j< 4*block; j+=block){
            image(soil2, i , 10*block+j);
          }
        }
      //floor 13-16
        for(int i=0; i < 8*block; i+=block){
          for(int j=0; j< 4*block; j+=block){
            image(soil3, i , 14*block+j);
          }
        }
      //floor 17-20
        for(int i=0; i < 8*block; i+=block){
          for(int j=0; j< 4*block; j+=block){
            image(soil4, i , 18*block+j);
          }
        }
      //floor 21-24
        for(int i=0; i < 8*block; i+=block){
          for(int j=0; j< 4*block; j+=block){
            image(soil5, i , 22*block+j);
          }
        }
    //stone
      //floor 1-8
        for(int i=0; i < 8*block; i+=block){
          image(stone1, i , 2*block+i);
        } 
      //floor 9-16
        for(int i=0; i < 2*block ; i+=block){
          for(int j=0; j<8*block ; j+=block){
            if(j==0 || j==3*block || j==4*block || j==7*block){
              image(stone1,block+4*i,10*block+j);
              image(stone1,2*block+4*i,10*block+j);
            }else{
              image(stone1,4*i,10*block+j);
              image(stone1,3*block+4*i,10*block+j);
            }
          }
        } 
      //floor 17-24
        for(int i=0; i < 3*block ; i+=block){
          for(int j=0; j<8*block ; j+=block){
            if(j % (3*block) == 0){
              image(stone1,block+3*i,18*block+j);
              image(stone1,2*block+3*i,18*block+j);
              image(stone2,2*block+3*i,18*block+j);
            }else if(j % (3*block) == 1*block){
              image(stone1,3*i,18*block+j);
              image(stone1,block+3*i,18*block+j);
              image(stone2,block+3*i,18*block+j);
            }else{
              image(stone1,3*i-block,18*block+j);
              image(stone1,3*i,18*block+j);
              image(stone2,3*i,18*block+j);
            }
          }
        } 

		// Player
      actionFrame = 0;
      if(downPressed){
          if(actionFrame < 80){
            image(groundhogDown,groundHogX,groundHogY);
            actionFrame += block/15;
            groundHogY += block/15;
            cameraOffset -= block/15;
            if(groundHogY >= 25*block) groundHogY=25*block;
          }
        }else if(leftPressed){
          if(actionFrame < 80){
            image(groundhogLeft,groundHogX,groundHogY);   
            actionFrame += block/15;
            groundHogX -= block/15;
            if( groundHogX <= 0) groundHogX=0;
          }    
        }else if(rightPressed){
          if(actionFrame < 80){
            image(groundhogRight,groundHogX,groundHogY);   
            actionFrame += block/15;
            groundHogX += block/15;
            if( groundHogX >= width-block) groundHogX=width-block;
          }  
        }else{
          image(groundhogIdle,groundHogX,groundHogY);
        }
      
      
		// Health UI
    for(float i=0; i<playerHealth; i++){
     image(life,INITIAL_LIFE_X+LIFE_SPACE*i,10);
    }
    if(playerHealth <= 0){
      gameState = GAME_OVER;
     }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {
			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;

				// life initialize
        playerHealth = 2;
        
        
        //groundhod initialize
        groundHogX = 320;
        groundHogY = 80;
        
			}
		}else{
			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  if (key == CODED) { 
    switch (keyCode) {
      case DOWN:
        downPressed = true;             
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
