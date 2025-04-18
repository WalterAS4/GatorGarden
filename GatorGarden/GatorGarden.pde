import processing.sound.*;

// Plant definitions
static final int WHEAT = 1;
static final int CORN = 2;
static final int THREE = 3;
static final int FOUR = 4;
static final int FIVE = 5;
static final int SIX = 6;
static final int SEVEN = 7;
static final int EIGHT = 8;
static final int NINE = 9;

// Enemy definitions
static final int FOX = 1;
static final int WOLF = 2;
static final int DRAGON = 3;

int width, height;

//menu definitions
boolean menuOpen = false;
int selectedRow = -1;
int selectedCol = -1;

void menu() {
  if (!menuOpen) return;
  
  //menu
  fill(200, 200, 200, 230);
  stroke(0);
  rectMode(CENTER);
  int menuWidth = 300;
  int menuHeight = 400;
  rect(width/2, height/2, menuWidth, menuHeight, 10);
  fill(0);
  textSize(24);
  textAlign(CENTER);
  text("Plant Shop", width/2, height/2 - 160);
  
  //crops:
  //wheat
  fill(235, 235, 200);
  rect(width/2, height/2 - 100, menuWidth - 40, 60, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Wheat", width/2 - 120, height/2 - 95);
  text("Cost: $100", width/2 - 120, height/2 - 75);
  image(wheat6, width/2 + 100, height/2 - 90, 48, 48);
  
  //more crops:
  
  //close button
  fill(255, 200, 200);
  rect(width/2, height/2 + 140, 120, 40, 10);
  fill(0);
  textAlign(CENTER);
  text("Close", width/2, height/2 + 145);

  textAlign(BASELINE);
}

// Initializes a farmer, a farm, and the fox
Farmer farmer = new Farmer();
Farm farm = new Farm(6, 5, 100);
Mob fox = new Mob(FOX);
// Mob wolf = new Mob(WOLF);
// Mob dragon = new Mob(DRAGON);

// FOR DEBUGGING
int prevKeyCode = 0;
char prevKey = ' ';

int timer = 0;

// PImage initializations
PImage gatorWalk1, gatorWalk2, gatorWalk3, gatorWalk4;
PImage foxWalk1, foxWalk2, foxWalk3, foxWalk4;
PImage dirt;
PImage wheat1, wheat2, wheat3, wheat4, wheat5, wheat6;

// SoundFile initializations
SoundFile buttonClick, gameStart, levelUp;
SoundFile earningCoins, planting, scaring, stealing, walking;

int lastStep = 0;

void setup() {
    size(800,800);
    width = 800;
    height = 800;
    rectMode(CENTER);
    ellipseMode(CENTER);
    imageMode(CENTER);

    // Image loading
    gatorWalk1 = loadImage("ImageFiles/Gator1.png");
    gatorWalk2 = loadImage("ImageFiles/Gator2.png");
    gatorWalk3 = loadImage("ImageFiles/Gator3.png");
    gatorWalk4 = loadImage("ImageFiles/Gator4.png");
    foxWalk1 = loadImage("ImageFiles/Fox1.png");
    foxWalk2 = loadImage("ImageFiles/Fox2.png");
    foxWalk3 = loadImage("ImageFiles/Fox3.png");
    foxWalk4 = loadImage("ImageFiles/Fox4.png");
    // TODO: more mobs
    dirt = loadImage("ImageFiles/Dirt.png");
    wheat1 = loadImage("ImageFiles/Wheat1.png");
    wheat2 = loadImage("ImageFiles/Wheat2.png");
    wheat3 = loadImage("ImageFiles/Wheat3.png");
    wheat4 = loadImage("ImageFiles/Wheat4.png");
    wheat5 = loadImage("ImageFiles/Wheat5.png");
    wheat6 = loadImage("ImageFiles/Wheat6.png");

    // Sound loading
    buttonClick = new SoundFile(this, "AudioFiles/Button Click.mp3");
    gameStart = new SoundFile(this, "AudioFiles/Game Start.wav");
    levelUp = new SoundFile(this, "AudioFiles/Level Up.wav");
    earningCoins = new SoundFile(this, "AudioFiles/Earning Coins.mp3");
    planting = new SoundFile(this, "AudioFiles/Planting.wav");
    scaring = new SoundFile(this, "AudioFiles/Scaring Mobs.mp3");
    stealing = new SoundFile(this, "AudioFiles/Stealing Crops.mp3");
    walking = new SoundFile(this, "AudioFiles/Walking.mp3");
}

void draw() {
    background(161, 126, 93);
    farm.updateFarm();
    farm.drawFarm();
    farmer.drawFarmer();

    // Button Hover
    if (mouseX <= 500 && mouseX >= 460 && mouseY >= 25 && mouseY <= 45) {
        strokeWeight(2);
        fill(#b5e0f5);
        rect(480, 35, 40, 20, 0, 20, 20, 0);
        fill(0);
        textSize(15);
        text("+", 475, 40);
        strokeWeight(1.5);
    }
    if (mouseX <= 500 && mouseX >= 460 && mouseY >= 55 && mouseY <= 75) {
        strokeWeight(2);
        fill(#f5b87a);
        rect(480, 65, 40, 20, 0, 20, 20, 0);
        fill(0);
        textSize(15);
        text("+", 475, 70);
        strokeWeight(1.5);
    }

    // custom cursor
    if (mouseY <= 100) {
        cursor(ARROW);
    }
    else if ((abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20)) {
        cursor(CROSS);
    }
    else {
        cursor(ARROW);
    }

    // mob logic
    if (fox.isGone()) {
        fox.updateCooldown();
        if (fox.getCooldown() <= 0) {
            fox.resetMob();
        }
    }
    else {
        fox.updateMob();
        fox.drawMob();
    }

    menu();
}

void mousePressed() {
    //for menu
    //if menu open, handle clicks
    if (menuOpen) {
        //check if close button was clicked
        if (mouseX > width/2 - 60 && mouseX < width/2 + 60 && mouseY > height/2 + 120 && mouseY < height/2 + 160) {
            menuOpen = false;
            buttonClick.play();
        }
        // Plant crop:
        else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 130 && mouseY < height/2 - 70) {
            if (farm.getMoney() >= 100) {
                farm.plantCrop(selectedRow, selectedCol, WHEAT);
                menuOpen = false;
                planting.play();
            }
        }   
        //more crops:
    
        return;
    }

    if (mouseX <= 500 && mouseX >= 460 && mouseY >= 25 && mouseY <= 45 && farmer.upgradesAvailable > 0) {
        farmer.speed += 1;
        farmer.upgradesAvailable -= 1;
        buttonClick.play();
    }
    else if (mouseX <= 500 && mouseX >= 460 && mouseY >= 55 && mouseY <= 75 && farmer.upgradesAvailable > 0) {
        farmer.reach += 1;
        farmer.upgradesAvailable -= 1;
        buttonClick.play();
    }
    else {
        // Harvest Crop
        for (int i = 0; i < farm.getRows(); i++) {
            for (int j = 0; j < farm.getCols(); j++) {
                if (mouseX >= i*100+110 && mouseX <= i*100+190 && mouseY >= j*100+210 && mouseY <= j*100+290 && (abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20)) {
                    // if (farm.getCropType(i, j) == 0 && farm.getMoney() >= 100) {
                    //     farm.plantCrop(i, j, WHEAT);
                    // }
                    //check if plot empty to show menu
                    if (farm.getCropType(i, j) == 0) {
                        menuOpen = true;
                        selectedRow = i;
                        selectedCol = j;
                        buttonClick.play();
                    }
                    else if (farm.isCropReady(i, j)) {
                        farm.harvestCrop(i,j);
                        earningCoins.play();
                    }

                }
            }
        }
    }

}

void keyPressed() {
    if (key == CODED) {

        // FOR DEBUGGING
        /* 
        if (prevKeyCode != keyCode) {
            prevKeyCode = keyCode;
            println(keyCode);
        }
        */
        
        // Arrow key input for moving farmer
        if (keyCode == UP) {
            farmer.moveUp();
        }
        else if (keyCode == DOWN) {
            farmer.moveDown();
        }
        else if (keyCode == LEFT) {
            farmer.moveLeft();
        }
        else if (keyCode == RIGHT) {
            farmer.moveRight();
        }

        // FOR DEBUGGING
        /*
        else if (keyCode == SHIFT) {
            farmer.printPos();
        }
        */
    }
    else {

        // FOR DEBUGGING
        /*
        if (prevKey != key) {
            prevKey = key;
            println(key);
        }
        */

        // WASD alternative input for moving farmer
        if (key == 'w' || key == 'W') {
            farmer.moveUp();
        }
        else if (key == 's' || key == 'S') {
            farmer.moveDown();
        }
        else if (key == 'a' || key == 'A') {
            farmer.moveLeft();
        }
        else if (key == 'd' || key == 'D') {
            farmer.moveRight();
        }
    }
}

// TODO: Implement more functions to draw each kind of plant

// Draws wheat based on its age
void drawWheat(int x, int y, int age) {
    if (age < 20) {
        image(wheat1, x-15, y-15, 64, 64);
        image(wheat1, x-15, y+15, 64, 64);
        image(wheat1, x+15, y+15, 64, 64);
        image(wheat1, x+15, y-15, 64, 64);
    }
    else if (age < 40) {
        image(wheat2, x-15, y-15, 64, 64);
        image(wheat2, x-15, y+15, 64, 64);
        image(wheat2, x+15, y+15, 64, 64);
        image(wheat2, x+15, y-15, 64, 64);
    }
    else if (age < 60) {
        image(wheat3, x-15, y-15, 64, 64);
        image(wheat3, x-15, y+15, 64, 64);
        image(wheat3, x+15, y+15, 64, 64);
        image(wheat3, x+15, y-15, 64, 64);
    }
    else if (age < 80) {
        image(wheat4, x-15, y-15, 64, 64);
        image(wheat4, x-15, y+15, 64, 64);
        image(wheat4, x+15, y+15, 64, 64);
        image(wheat4, x+15, y-15, 64, 64);
    }
    else if (age < 100) {
        image(wheat5, x-15, y-15, 64, 64);
        image(wheat5, x-15, y+15, 64, 64);
        image(wheat5, x+15, y+15, 64, 64);
        image(wheat5, x+15, y-15, 64, 64);
    }
    else {
        image(wheat6, x-15, y-15, 64, 64);
        image(wheat6, x-15, y+15, 64, 64);
        image(wheat6, x+15, y+15, 64, 64);
        image(wheat6, x+15, y-15, 64, 64);
    }
}

// Class used to represent the player's character
class Farmer {

    int xPos, yPos;
    int upgradesAvailable;
    int speed;
    int reach;

    int walkCycle;

    // initializes farmer
    Farmer() {
        // starting location is at the center of the window
        xPos = 400;
        yPos = 400;
        upgradesAvailable = 0;
        speed = 1;
        reach = 1;
        walkCycle = 1;
    }

    // draws the farmer
    // TODO: images will be used for the farmer and movement will be animated
    void drawFarmer() {
        fill(255);
        if (walkCycle == 1) {
            image(gatorWalk1, xPos, yPos-10, 32, 32);
            if (timer % 20 == 0) {
                walkCycle = 2;
            }
        }
        else if (walkCycle == 2) {
            image(gatorWalk2, xPos, yPos-10, 32, 32);
            if (timer % 20 == 0) {
                walkCycle = 3;
            }
        }
        else if (walkCycle == 3) {
            image(gatorWalk3, xPos, yPos-10, 32, 32);
            if (timer % 20 == 0) {
                walkCycle = 4;
            }
        }
        else if (walkCycle == 4) {
            image(gatorWalk4, xPos, yPos-10, 32, 32);
            if (timer % 20 == 0) {
                walkCycle = 1;
            }
        }
        
        // rect(xPos, yPos, 16, 16);
    }

    // MOVEMENT FUNCTIONS
    // TODO: Implement a 'speed' variable
    void moveDown() {
        int nextY = yPos + (speed + 1) * 2;
        // If inside the plots area
        if ((xPos >= 110 && xPos <= 690) && (yPos >= 210 && yPos <= 690)) {
            int relativeX = xPos - 110;
            int relativeY = nextY - 210;
            // If nextY would move into a plot, restrict to top edge of nearest plot
            if ((relativeX % 100) < 80 && (relativeY % 100) < 80  && (relativeX % 100) != 0) {
                int plotIndex = relativeY / 100;
                yPos = 210 + plotIndex * 100;
                return;
            }
        }
        // Safe to move
        yPos = min(800, nextY);
        // Timing of walking sound
        if (millis() - lastStep > 500) {
            walking.play();
            lastStep = millis();
        }
    }
    void moveUp() {
        int nextY = yPos - (speed + 1) * 2;
        // If inside the plots area
        if ((xPos >= 110 && xPos <= 690) && (yPos >= 210 && yPos <= 690)) {
            int relativeX = xPos - 110;
            int relativeY = nextY - 210;
            // If nextY would move into a plot, restrict to bottom edge of nearest plot
            if ((relativeX % 100) < 80 && (relativeY % 100) < 80 && (relativeX % 100) != 0) {
                int plotIndex = relativeY / 100;
                yPos = 210 + plotIndex * 100 + 80;
                return;
            }
        }
        // Safe to move
        yPos = max(100, nextY);
        // Timing of walking sound
        if (millis() - lastStep > 500) {
            walking.play();
            lastStep = millis();
        }
    }
    void moveLeft() {
        int nextX = xPos - (speed + 1) * 2;
        // If inside the plots area
        if ((xPos >= 110 && xPos <= 690) && (yPos >= 210 && yPos <= 690)) {
            int relativeX = nextX - 110;
            int relativeY = yPos - 210;
            // If nextX would move into a plot, restrict to right edge of nearest plot
            if ((relativeX % 100) < 80 && (relativeY % 100) < 80 && (relativeY % 100) != 0) {
                int plotIndex = relativeX / 100;
                xPos = 110 + plotIndex * 100 + 80;
                return;
            }
        }
        // Safe to move
        xPos = max(0, nextX);
        // Timing of walking sound
        if (millis() - lastStep > 500) {
            walking.play();
            lastStep = millis();
        }
    }
    void moveRight() {
        int nextX = xPos + (speed + 1) * 2;
        // If inside the plots area
        if ((xPos >= 110 && xPos <= 690) && (yPos >= 210 && yPos <= 690)) {
            int relativeX = nextX - 110;
            int relativeY = yPos - 210;
            // If nextX would move into a plot, restrict to right edge of nearest plot
            if ((relativeX % 100) < 80 && (relativeY % 100) < 80 && (relativeY % 100) != 0) {
                int plotIndex = relativeX / 100;
                xPos = 110 + plotIndex * 100;
                return;
            }
        }
        // Safe to move
        xPos = min(800, nextX);
        // Timing of walking sound
        if (millis() - lastStep > 500) {
            walking.play();
            lastStep = millis();
        }
    }

    // FOR DEBUGGING
    void printPos() {
        println(xPos + ", " + yPos);
    }

    // GETTERS
    int getXPos() { return xPos; }
    int getYPos() { return yPos; }
}

// TODO: Change to function with fox, wolf, and dragon enemies
class Mob {
    int mob;
    int xPos, yPos;
    int xHome, yHome;
    int targetRow, targetCol;
    int fullThreat, currThreat;
    int fullFear, currFear;
    int speed;
    int cooldown;

    boolean prefersX;
    boolean isRetreating;
    boolean isGone;

    int walkCycle;
    

    Mob(int mob_type) {
        mob = mob_type;
        
        if (mob == FOX) {
            cooldown = 1000;
        }
        else if (mob == WOLF) {
            cooldown = 1000;
        }
        else if (mob == DRAGON) {
            cooldown = 1000;
        }
        else {
            cooldown = 0;
            println("ERROR: Not a valid mob type.");
        }

        resetMob();
    }

    // Resets the mob so it can return after it is dealt with by the player
    void resetMob() {
        if (mob == FOX) {
            fullThreat = 60;
            currThreat = 60;
            fullFear = 50;
            currFear = 0;
            speed = 1;
        }
        else if (mob == WOLF) {
            fullThreat = 60;
            currThreat = 60;
            fullFear = 50;
            currFear = 0;
            speed = 1;
        }
        else if (mob == DRAGON) {
            fullThreat = 60;
            currThreat = 60;
            fullFear = 50;
            currFear = 0;
            speed = 1;
        }
        else {
            fullThreat = 0;
            currThreat = 0;
            speed = 0;  
        }

        SetSpawnAndTarget();

        int r = int(random(2));
        if (r == 0) { prefersX = true; }
        else if (r == 1) { prefersX = false; }

        walkCycle = 1;

    }

    void SetSpawnAndTarget() {
        int spawn_loc = int(random(23));
        switch(spawn_loc) {
            case 0: xPos = 200; yPos = 100; xHome = 200; yHome = 100; break;
            case 1: xPos = 100; yPos = 100; xHome = 100; yHome = 100; break;
            case 2: xPos = 0; yPos = 200; xHome = 0; yHome = 200; break;
            case 3: xPos = 0; yPos = 300; xHome = 0; yHome = 300; break;
            case 4: xPos = 0; yPos = 400; xHome = 0; yHome = 400; break;
            case 5: xPos = 0; yPos = 500; xHome = 0; yHome = 500; break;
            case 6: xPos = 0; yPos = 600; xHome = 0; yHome = 600; break;
            case 7: xPos = 0; yPos = 700; xHome = 0; yHome = 700; break;
            case 8: xPos = 100; yPos = 800; xHome = 100; yHome = 800; break;
            case 9: xPos = 200; yPos = 800; xHome = 200; yHome = 800; break;
            case 10: xPos = 300; yPos = 800; xHome = 300; yHome = 800; break;
            case 11: xPos = 400; yPos = 800; xHome = 400; yHome = 800; break;
            case 12: xPos = 500; yPos = 800; xHome = 500; yHome = 800; break;
            case 13: xPos = 600; yPos = 800; xHome = 600; yHome = 800; break;
            case 14: xPos = 700; yPos = 800; xHome = 700; yHome = 800; break;
            case 15: xPos = 800; yPos = 700; xHome = 800; yHome = 700; break;
            case 16: xPos = 800; yPos = 600; xHome = 800; yHome = 600; break;
            case 17: xPos = 800; yPos = 500; xHome = 800; yHome = 500; break;
            case 18: xPos = 800; yPos = 400; xHome = 800; yHome = 400; break;
            case 19: xPos = 800; yPos = 300; xHome = 800; yHome = 300; break;
            case 20: xPos = 800; yPos = 200; xHome = 800; yHome = 200; break;
            case 21: xPos = 700; yPos = 100; xHome = 700; yHome = 100; break;
            case 22: xPos = 600; yPos = 100; xHome = 600; yHome = 100; break;
            default: break;
        }

        targetRow = -1;
        targetCol = -1;
        isGone = true;
        isRetreating = true;
        
        int randomRow = int(random(farm.getRows()));
        int randomCol = int(random(farm.getCols()));
        for (int i = 0; i < farm.getRows(); i++) {
            for (int j = 0; j < farm.getCols(); j++) {
                if (farm.getCropType((i+randomRow) % farm.getRows(), (j+randomCol) % farm.getCols()) != 0) {
                    targetRow = (i+randomRow) % farm.getRows();
                    targetCol = (j+randomCol) % farm.getCols();
                    isGone = false;
                    isRetreating = false;

                    if (mob == FOX) {
                        cooldown = 1000;
                    }
                    if (mob == WOLF) {
                        cooldown = 1000;
                    }
                    if (mob == DRAGON) {
                        cooldown = 1000;
                    }
                }
            }
        }
    }

    void updateCooldown() {
        if (cooldown > 0) {
            cooldown--;
        }
    }

    void drawMob() {
        // fill(60, 105, 66);
        // rect(xPos, yPos, 16, 16);

        if (mob == FOX) {
            if (walkCycle == 1) {
                image(foxWalk1, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 2;
                }
            }
            else if (walkCycle == 2) {
                image(foxWalk2, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 3;
                }
            }
            else if (walkCycle == 3) {
                image(foxWalk3, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 4;
                }
            }
            else if (walkCycle == 4) {
                image(foxWalk4, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 1;
                }
            }
        }

        // fear meter
        if (currFear > 0) {
            fill(255,255,0);
            noStroke();
            rectMode(CORNERS);
            rect(xPos-fullFear/4, yPos-20, xPos-fullFear/4+currFear/2, yPos-25);
            noFill();
            stroke(0);
            rect(xPos-fullFear/4, yPos-20, xPos+fullFear/4, yPos-25);
            rectMode(CENTER);
        }

        // threat timer
        if (xPos >= targetRow*100+100 &&
            xPos <= targetRow*100+200 &&
            yPos >= targetCol*100+200 &&
            yPos <= targetCol*100+300) 
        {
            fill(255,0,0);
            noStroke();
            arc(xPos, yPos-40, 30, 30, (fullThreat-currThreat)*2*PI/fullThreat-(PI/2), 3*PI/2);
            stroke(0);
            noFill();
            ellipse(xPos, yPos-40, 30, 30);
        }
    }

    // TODO: Create function that calculates a path for the mob to take
    void updateMob() {
        if (!isRetreating) {
            if (xPos < 100) {
                xPos += speed;
            }
            else if (xPos > width-100) {
                xPos -= speed;
            }
            else if (yPos < 200) {
                yPos += speed;
            }
            else if (yPos > height-100) {
                yPos -= speed;
            }
            else if (prefersX) {
                if (xPos < targetRow*100+108) {
                    xPos += speed;
                }
                else if (xPos > targetRow*100+192) {
                    xPos -= speed;
                }
                else if (yPos < targetCol*100+208) {
                    yPos += speed;
                }
                else if (yPos > targetCol*100+292) {
                    yPos -= speed;
                }
            }
            else {
                if (yPos < targetCol*100+208) {
                    yPos += speed;
                }
                else if (yPos > targetCol*100+292) {
                    yPos -= speed;
                }
                else if (xPos < targetRow*100+108) {
                    xPos += speed;
                }
                else if (xPos > targetRow*100+192) {
                    xPos -= speed;
                }
            }
        }
        else {
            if (xPos <= 0 || xPos >= width || yPos <= 100 || yPos >= height) {
                isGone = true;
            }
            else if (xPos % 100 != 0 && xPos <= width/2) {
                xPos -= speed;
            }
            else if (xPos % 100 != 0 && xPos > width/2) {
                xPos += speed;
            }
            else if (yPos % 100 != 0) {
                yPos += speed;
            }
            else if (height-yPos < width-xPos && height-yPos < abs(xPos-width)) {
                yPos += speed;
            }
            else if (xPos <= width/2) {
                xPos -= speed;
            }
            else {
                xPos += speed;
            }
        }

        // check if target is still there
        if (farm.getCropType(targetRow, targetCol) == 0) {
            isRetreating = true;
        }

        // fear meter
        if (mouseX >= xPos-10 && mouseX <= xPos+10 && mouseY >= yPos-10 && mouseY <= yPos+10 && (abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20)) {
            if (currFear < fullFear) {
                currFear++;
            }
            else {
                if (!isRetreating) { farm.xp += 50; }
                isRetreating = true;
                scaring.play();
            }
        }
        else {
            if (currFear < fullFear) {
                currFear = 0;
            }
        }

        // threat timer
        if (xPos >= targetRow*100+100 &&
            xPos <= targetRow*100+200 &&
            yPos >= targetCol*100+200 &&
            yPos <= targetCol*100+300 &&
            !isRetreating) 
        {
            if (timer % 10 == 0) { 
                currThreat--;
                if (currThreat <= 0) {
                    farm.destroyCrop(targetRow, targetCol);
                    isRetreating = true;
                    stealing.play();
                }
            }
        }
    }

    // GETTERS
    int getCooldown() { return cooldown; }
    boolean isGone() { return isGone; }
}

// Represents an individual tile that crops can be planted on
class Plot {
    int plant; 
    int age;
    int lifespan;
    int cost;
    int sell;
    int xpval;

    Plot() {
        plant = 0;
        age = 0;
        lifespan = 0;
        cost = 0;
        sell = 0;
        xpval = 0;
    }

    // returns true if the crop is ready to be harvested / can be sold
    boolean harvestable() {
        return age >= lifespan;
    }

    // increments age by 1
    void incAge() { age++; }
    
    // GETTERS
    int getPlant() { return plant; }
    int getAge() { return age; }
    int getLifespan() { return lifespan; }
    int getCost() { return cost; }
    int getSell() { return sell; }
    int getXpval() { return xpval; }

    // SETTERS
    void setPlant(int plant) { this.plant = plant; }
    void setAge(int age) { this.age = age; }
    void setLifespan(int lifespan) { this.lifespan = lifespan; }
    void setCost(int cost) { this.cost = cost; }
    void setSell(int sell) { this.sell = sell; }
    void setXpval(int xpval) { this.xpval = xpval; }

}

// Contains an array of Plots, a timer, and money
class Farm {
    Plot[][] plots;
    int rows;
    int cols;
    int money;
    int xp;
    int xpForNextLevel;
    int xpForPrevLevel;
    int level;

    // Creates a farm with the number of Plots and staring money specified
    Farm(int rows, int cols, int start_money) {
        this.rows = rows;
        this.cols = cols;
        plots = new Plot[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                plots[i][j] = new Plot();
            }
        }
        money = start_money;
        xp = 0;
        xpForNextLevel = 400;
        xpForPrevLevel = 0;
        level = 1;
        
    }

    // draws the farm
    void drawFarm() {

        // farm plots
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                fill(92, 64, 38);
                rect(i*100+150, j*100+250, 80, 80);
                if (plots[i][j].getPlant() == WHEAT) {
                    drawWheat(i*100+150, j*100+250, plots[i][j].getAge());
                }
            }
        }

        // tools hotbar
        fill(120);
        rect(width/2, 50, width-10, 90);

        // xp meter
        rectMode(CORNERS);
        fill(0, 127, 0);
        rect(width-90, 90, width-10, 10);
        fill(0, 255, 0);
        rect(width-90, 90, width-10, 90-80*(xp-xpForPrevLevel)/(xpForNextLevel-xpForPrevLevel));
        rectMode(CENTER);
        fill(0);
        textSize(30);
        text(farm.level, width-56, 60);

        // Timer
        fill(0);
        textSize(30);
        if (timer < 100) { text("Time: 0", width-225, 60); }
        else { text("Time: " + str(timer).substring(0, str(timer).length() - 2), width-225, 60); }

        // Money
        fill(0);
        textSize(30);
        text("Money: $" + str(money), 60, 60);
        
        // Stats
        fill(255);
        strokeWeight(2);
        rect(400, 35, 200, 20, 20);
        rect(400, 65, 200, 20, 20);
        fill(#89CFF0);
        rect(480, 35, 40, 20, 0, 20, 20, 0);
        int speed = min(5, farmer.speed);
        for (int i = 1; i < speed; i++) {
            if (i == 1) {
                rect(320, 35, 40, 20, 20, 0, 0, 20);
            }
            else {
                rect(320 + 40*(i - 1), 35, 40, 20);
            }
        }
        fill(#F28C28);
        rect(480, 65, 40, 20, 0, 20, 20, 0);
        int reach = min(5, farmer.reach);
        for (int i = 1; i < reach; i++) {
            if (i == 1) {
                rect(320, 65, 40, 20, 20, 0, 0, 20);
            }
            else {
                rect(320 + 40*(i - 1), 65, 40, 20);
            }
        }
        fill(0);
        textSize(15);
        text("Speed", 370, 40);
        text("Reach", 370, 70);
        text("+", 475, 40);
        text("+", 475, 70);
        strokeWeight(1.5); 

        // Upgrades Available
        if (farmer.upgradesAvailable > 0) {
            textSize(20);
            String upgradesAvailable = "x" + str(farmer.upgradesAvailable);
            text(upgradesAvailable, 515, 55);
        }

        // Level
        textSize(50);
        String levelMsg = "Level " + str(level);
        text(levelMsg, 325, 175);
    }

    // updates the farm when called, specifically updates the timer and reacts based on timer data
    void updateFarm() {
        timer++;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (plots[i][j].getPlant() != 0 && timer % 10 == 0) {
                    plots[i][j].incAge();
                }
            }
        }
    }

    // plants a crop of a specified type on the Plot of the given coordinate
    void plantCrop(int row, int col, int plant) {
        plots[row][col].setPlant(plant);
        if (plant == WHEAT) {
            plots[row][col].setAge(0);
            plots[row][col].setLifespan(100);
            plots[row][col].setCost(100);
            plots[row][col].setSell(200);
            plots[row][col].setXpval(100);
            money = money - 100;
        }
    }

    void destroyCrop(int row, int col) {
        plots[row][col].setPlant(0);
        plots[row][col].setAge(0);
        plots[row][col].setLifespan(0);
        plots[row][col].setCost(0);
        plots[row][col].setSell(0);
        plots[row][col].setXpval(0);
    }

    // Removes the crop from the Plot at the given coordinate
    void harvestCrop(int row, int col) {
        money = money + plots[row][col].getSell();
        xp = xp + plots[row][col].getXpval();
        destroyCrop(row, col);

        // Leveling
        if (xp >= xpForNextLevel && level < 9) {
            level++;
            farmer.upgradesAvailable += 1;
            xpForPrevLevel = xpForNextLevel;
            xpForNextLevel *= 2;
            levelUp.play();
        }
    }

    // GETTERS
    int getRows() { return rows; }
    int getCols() { return cols; }
    int getMoney() { return money; }
    int getCropType(int row, int col) { return plots[row][col].getPlant(); }
    boolean isCropReady(int row, int col) { return plots[row][col].harvestable(); }
}


