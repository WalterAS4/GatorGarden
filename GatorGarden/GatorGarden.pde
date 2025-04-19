import processing.sound.*;

// Plant definitions
static final int WHEAT = 1;
static final int CORN = 2;
static final int BLUEBERRY = 3;
static final int CHILIPEPPER = 4;
static final int STRAWBERRY = 5;
static final int BELLPEPPER = 6;
static final int SUGARCANE = 7;
static final int APPLETREE = 8;

// Enemy definitions
static final int FOX = 1;
static final int WOLF = 2;
static final int DRAGON = 3;

int width, height;

//menu definitions
boolean menuOpen = false;
int selectedRow = -1;
int selectedCol = -1;
boolean gameMenuOpen = false;

// 1 = start menu, 2 = level select, 3 = gameplay, 4 = pause menu, 4 = end menu
int gameState = 1;

boolean gamePaused = false;

// Initializes a farmer, a farm, and the fox
Farmer farmer = new Farmer();
Farm farm = new Farm(6, 5, 100);
Mob fox = new Mob(FOX);
Mob wolf = new Mob(WOLF);
Mob dragon = new Mob(DRAGON);

// FOR DEBUGGING
int prevKeyCode = 0;
char prevKey = ' ';

int timer = 0;

// PImage initializations
PImage gatorWalk1, gatorWalk2, gatorWalk3, gatorWalk4;
PImage foxWalk1, foxWalk2, foxWalk3, foxWalk4;
PImage wolfWalk1, wolfWalk2, wolfWalk3, wolfWalk4;
PImage dragonWalk1, dragonWalk2, dragonWalk3, dragonWalk4;
PImage dirt;
PImage wheat1, wheat2, wheat3, wheat4, wheat5, wheat6, wheatIcon;
PImage corn1, corn2, corn3, corn4, corn5, corn6, cornIcon;
PImage blueberry1, blueberry2, blueberry3, blueberry4, blueberry5, blueberry6, blueberryIcon;
PImage chilipepper1, chilipepper2, chilipepper3, chilipepper4, chilipepper5, chilipepper6, chilipepperIcon;
PImage strawberry1, strawberry2, strawberry3, strawberry4, strawberry5, strawberry6, strawberryIcon;
PImage bellpepper1, bellpepper2, bellpepper3, bellpepper4, bellpepper5, bellpepper6, bellpepperIcon;
PImage sugarcane1, sugarcane2, sugarcane3, sugarcane4, sugarcane5, sugarcane6, sugarcaneIcon;
PImage appletree1, appletree2, appletree3, appletree4, appletree5, appletree6, appletreeIcon;
PImage backButton, menuButton;

// SoundFile initializations
SoundFile backgroundMusic;
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
    wolfWalk1 = loadImage("ImageFiles/Wolf1.png");
    wolfWalk2 = loadImage("ImageFiles/Wolf2.png");
    wolfWalk3 = loadImage("ImageFiles/Wolf3.png");
    wolfWalk4 = loadImage("ImageFiles/Wolf4.png");
    dragonWalk1 = loadImage("ImageFiles/Dragon1.png");
    dragonWalk2 = loadImage("ImageFiles/Dragon2.png");
    dragonWalk3 = loadImage("ImageFiles/Dragon3.png");
    dragonWalk4 = loadImage("ImageFiles/Dragon4.png");
    dirt = loadImage("ImageFiles/Dirt.png");
    wheat1 = loadImage("ImageFiles/Wheat1.png");
    wheat2 = loadImage("ImageFiles/Wheat2.png");
    wheat3 = loadImage("ImageFiles/Wheat3.png");
    wheat4 = loadImage("ImageFiles/Wheat4.png");
    wheat5 = loadImage("ImageFiles/Wheat5.png");
    wheat6 = loadImage("ImageFiles/Wheat6.png");
    wheatIcon = loadImage("ImageFiles/WheatIcon.png");
    corn1 = loadImage("ImageFiles/Corn1.png");
    corn2 = loadImage("ImageFiles/Corn2.png");
    corn3 = loadImage("ImageFiles/Corn3.png");
    corn4 = loadImage("ImageFiles/Corn4.png");
    corn5 = loadImage("ImageFiles/Corn5.png");
    corn6 = loadImage("ImageFiles/Corn6.png");
    cornIcon = loadImage("ImageFiles/CornIcon.png");
    blueberry1 = loadImage("ImageFiles/Blueberry1.png");
    blueberry2 = loadImage("ImageFiles/Blueberry2.png");
    blueberry3 = loadImage("ImageFiles/Blueberry3.png");
    blueberry4 = loadImage("ImageFiles/Blueberry4.png");
    blueberry5 = loadImage("ImageFiles/Blueberry5.png");
    blueberry6 = loadImage("ImageFiles/Blueberry6.png");
    blueberryIcon = loadImage("ImageFiles/BlueberryIcon.png");
    chilipepper1 = loadImage("ImageFiles/Pepper1.png");
    chilipepper2 = loadImage("ImageFiles/Pepper2.png");
    chilipepper3 = loadImage("ImageFiles/Pepper3.png");
    chilipepper4 = loadImage("ImageFiles/Pepper4.png");
    chilipepper5 = loadImage("ImageFiles/Pepper5.png");
    chilipepper6 = loadImage("ImageFiles/Pepper6.png");
    chilipepperIcon = loadImage("ImageFiles/PepperIcon.png");
    strawberry1 = loadImage("ImageFiles/Strawberry1.png");
    strawberry2 = loadImage("ImageFiles/Strawberry2.png");
    strawberry3 = loadImage("ImageFiles/Strawberry3.png");
    strawberry4 = loadImage("ImageFiles/Strawberry4.png");
    strawberry5 = loadImage("ImageFiles/Strawberry5.png");
    strawberry6 = loadImage("ImageFiles/Strawberry6.png");
    strawberryIcon = loadImage("ImageFiles/StrawberryIcon.png");
    bellpepper1 = loadImage("ImageFiles/BellPepper1.png");
    bellpepper2 = loadImage("ImageFiles/BellPepper2.png");
    bellpepper3 = loadImage("ImageFiles/BellPepper3.png");
    bellpepper4 = loadImage("ImageFiles/BellPepper4.png");
    bellpepper5 = loadImage("ImageFiles/BellPepper5.png");
    bellpepper6 = loadImage("ImageFiles/BellPepper6.png");
    bellpepperIcon = loadImage("ImageFiles/BellPepperIcon.png");
    sugarcane1 = loadImage("ImageFiles/SugarCane1.png");
    sugarcane2 = loadImage("ImageFiles/SugarCane2.png");
    sugarcane3 = loadImage("ImageFiles/SugarCane3.png");
    sugarcane4 = loadImage("ImageFiles/SugarCane4.png");
    sugarcane5 = loadImage("ImageFiles/SugarCane5.png");
    sugarcane6 = loadImage("ImageFiles/SugarCane6.png");
    sugarcaneIcon = loadImage("ImageFiles/SugarCaneIcon.png");
    appletree1 = loadImage("ImageFiles/Tree1.png");
    appletree2 = loadImage("ImageFiles/Tree2.png");
    appletree3 = loadImage("ImageFiles/Tree3.png");
    appletree4 = loadImage("ImageFiles/Tree4.png");
    appletree5 = loadImage("ImageFiles/Tree5.png");
    appletree6 = loadImage("ImageFiles/Tree6.png");
    appletreeIcon = loadImage("ImageFiles/AppleIcon.png");

    backButton = loadImage("ImageFiles/Back Button.png");
    menuButton = loadImage("ImageFiles/Menu Button.png");

    // Sound loading
    backgroundMusic = new SoundFile(this, "AudioFiles/Chill Farm Music.mp3");
    buttonClick = new SoundFile(this, "AudioFiles/Button Click.mp3");
    gameStart = new SoundFile(this, "AudioFiles/Game Start.wav");
    levelUp = new SoundFile(this, "AudioFiles/Level Up.wav");
    earningCoins = new SoundFile(this, "AudioFiles/Earning Coins.mp3");
    planting = new SoundFile(this, "AudioFiles/Planting.wav");
    scaring = new SoundFile(this, "AudioFiles/Scaring Mobs.mp3");
    stealing = new SoundFile(this, "AudioFiles/Stealing Crops.mp3");
    walking = new SoundFile(this, "AudioFiles/Walking.mp3");
    
    // backgroundMusic.loop();
}

void draw() {
    background(161, 126, 93);
    // Start Menu
    if (gameState == 1) {
        fill(0);
        textSize(84);
        textAlign(CENTER);
        text("GatorGarden", 400, 200);
        fill(255);
        rect(400, 325, 390, 90, 50);
        rect(400, 450, 390, 90, 50);
        rect(400, 575, 390, 90, 50);
        fill(0);
        textSize(48);
        text("Start Game", 400, 335);
        text("Level Select", 400, 460);
        text("Exit", 400, 590);
        textAlign(BASELINE);
    }
    // Level Select
    else if (gameState == 2) {
        fill(0);
        textSize(72);
        textAlign(CENTER);
        text("Level Select", 400, 175);
        fill(255);
        rect(255, 300, 100, 100, 25);
        translate(150, 0);
        rect(255, 300, 100, 100, 25);
        translate(150, 0);
        rect(255, 300, 100, 100, 25);
        resetMatrix();
        rect(255, 450, 100, 100, 25);
        translate(150, 0);
        rect(255, 450, 100, 100, 25);
        translate(150, 0);
        rect(255, 450, 100, 100, 25);
        resetMatrix();
        rect(255, 600, 100, 100, 25);
        translate(150, 0);
        rect(255, 600, 100, 100, 25);
        translate(150, 0);
        rect(255, 600, 100, 100, 25);
        resetMatrix();
        fill(0);
        textSize(48);
        text("1", 255, 315);
        translate(150, 0);
        text("2", 255, 315);
        translate(150, 0);
        text("3", 255, 315);
        resetMatrix();
        text("4", 255, 465);
        translate(150, 0);
        text("5", 255, 465);
        translate(150, 0);
        text("6", 255, 465);
        resetMatrix();
        text("7", 255, 615);
        translate(150, 0);
        text("8", 255, 615);
        translate(150, 0);
        text("9", 255, 615);
        resetMatrix();

        // Back Button
        image(backButton, 75, 75);
        textAlign(BASELINE);
    }
    // Gameplay
    else {
        farm.drawFarm();
        farmer.drawFarmer();
        if (!gamePaused) {
            farm.updateFarm();

            // custom cursor
              if (mouseY <= 100 || menuOpen) {
                  cursor(ARROW);
              }
              else if ((abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20) && !menuOpen) {
                  cursor(CROSS);
                  for (int i = 0; i < farm.getRows(); i++) {
                      for (int j = 0; j < farm.getCols(); j++) {
                          if (mouseX >= i*100+110 && mouseX <= i*100+190 && mouseY >= j*100+210 && mouseY <= j*100+290 && (abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20)) {
                              //check if plot empty to show menu
                              if (farm.getCropType(i, j) != 0 && farm.isCropReady(i, j)) {
                                  noCursor();
                                  if (farm.getCropType(i, j) == WHEAT) {
                                      image(wheatIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == CORN) {
                                      image(cornIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == BLUEBERRY) {
                                      image(blueberryIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == CHILIPEPPER) {
                                      image(chilipepperIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == STRAWBERRY) {
                                      image(strawberryIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == BELLPEPPER) {
                                      image(bellpepperIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == SUGARCANE) {
                                      image(sugarcaneIcon, mouseX, mouseY, 32, 32);
                                  }
                                  if (farm.getCropType(i, j) == APPLETREE) {
                                      image(appletreeIcon, mouseX, mouseY, 32, 32);
                                  }
                              }
                          }
                      }
                  }
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
            }
            // wolf mob logic
            if (wolf.isGone()) {
                wolf.updateCooldown();
                if (wolf.getCooldown() <= 0) {
                    wolf.resetMob();
                }
            }
            else {
                wolf.updateMob();
            }

            // dragon mob logic
            if (dragon.isGone()) {
                dragon.updateCooldown();
                if (dragon.getCooldown() <= 0) {
                    dragon.resetMob();
                }
            }
            else {
                dragon.updateMob();
            }
        }
        }
        // Keep mob drawn even when paused
        if (!fox.isGone()) {
            fox.drawMob();
        }
        if(!wolf.isGone()) {
            wolf.drawMob();
        }
        if (!dragon.isGone()) {
            dragon.drawMob();
        }

        menu();
        gameMenu();

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
        else if (mouseX <= 500 && mouseX >= 460 && mouseY >= 55 && mouseY <= 75) {
            strokeWeight(2);
            fill(#f5b87a);
            rect(480, 65, 40, 20, 0, 20, 20, 0);
            fill(0);
            textSize(15);
            text("+", 475, 70);
            strokeWeight(1.5);
        }
        else if (mouseX >= 25 && mouseX <= 75 && mouseY >= 25 && mouseY <= 75) {
            fill(#d3d3d3, 80);
            rect(50, 50, 50, 50);
        }
        // if (menuOpen) {
        //     //crops:
        //     //wheat
        //     if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 130 && mouseY < height/2 - 70) {
        //         fill(235, 235, 200);
        //         rect(width/2, height/2 - 100, 260, 60, 5);
        //         fill(0);
        //         textAlign(LEFT);
        //         textSize(18);
        //         text("Wheat", width/2 - 120, height/2 - 95);
        //         text("Cost: $100", width/2 - 120, height/2 - 75);
        //         image(wheat6, width/2 + 100, height/2 - 90, 48, 48);
        //         textAlign(BASELINE);
        //     }
        //     //close button
        //     else if (mouseX > width/2 - 60 && mouseX < width/2 + 60 && mouseY > height/2 + 120 && mouseY < height/2 + 160) {
        //         fill(255, 200, 200);
        //         rect(width/2, height/2 + 140, 120, 40, 10);
        //         fill(0);
        //         textAlign(CENTER);
        //         text("Close", width/2, height/2 + 145);
        //         textAlign(BASELINE);
        //     }
        // }

        if (gameMenuOpen) {
            textAlign(CENTER);
            textSize(20);
            if (mouseX >= 230 && mouseX <= 570 && mouseY >= 230 && mouseY <= 290) {
                fill(235, 235, 200);
                rect(width/2, height/2 - 140, 340, 60, 5);
                fill(0);
                text("Resume", width/2, height/2 - 140);
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 305 && mouseY <= 365) {
                fill(235, 235, 200);
                rect(width/2, height/2 - 65, 340, 60, 5);
                fill(0);
                text("Restart", width/2, height/2 - 65);
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 380 && mouseY <= 440) {
                fill(235, 235, 200);
                rect(width/2, height/2 + 10, 340, 60, 5);
                fill(0);
                text("Main Menu", width/2, height/2 + 10);
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 455 && mouseY <= 515) {
                fill(235, 235, 200);
                rect(width/2, height/2 + 85, 340, 60, 5);
                fill(0);
                text("Level Select", width/2, height/2 + 85);
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 530 && mouseY <= 590) {
                fill(235, 235, 200);
                rect(width/2, height/2 + 160, 340, 60, 5);
                fill(0);
                text("Quit Game", width/2, height/2 + 160);
            }
            textAlign(BASELINE);
        }
}

void menu() {
  if (!menuOpen) return;
  
  //menu
  fill(200, 200, 200, 230);
  stroke(0);
  rectMode(CENTER);
  int menuWidth = 300;
  int menuHeight = 500;
  rect(width/2, height/2+50, menuWidth, menuHeight, 10);
  fill(0);
  textSize(24);
  textAlign(CENTER);
  text("Plant Shop", width/2, height/2 - 160);
  
  //crops:
  //wheat
  fill(235, 235, 200);
  rect(width/2, height/2 - 130, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Wheat", width/2 - 120, height/2 - 131);
  if (farm.money < 100) { fill(255, 0, 0); }
  text("Cost: $100", width/2 - 120, height/2 - 113);
  image(wheatIcon, width/2 + 100, height/2 - 128, 32, 32);
  
  //corn
  fill(235, 235, 200);
  rect(width/2, height/2 - 85, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Corn", width/2 - 120, height/2 - 86);
  if (farm.money < 200) { fill(255, 0, 0); }
  text("Cost: $200", width/2 - 120, height/2 - 68);
  image(cornIcon, width/2 + 100, height/2 - 83, 32, 32);
  
  //blueberry
  fill(235, 235, 200);
  rect(width/2, height/2 - 40, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Blueberry", width/2 - 120, height/2 - 41);
  if (farm.money < 400) { fill(255, 0, 0); }
  text("Cost: $400", width/2 - 120, height/2 - 23);
  image(blueberryIcon, width/2 + 100, height/2 - 38, 32, 32);

  //chilipepper
  fill(235, 235, 200);
  rect(width/2, height/2 + 5, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Chili Pepper", width/2 - 120, height/2 + 4);
  if (farm.money < 800) { fill(255, 0, 0); }
  text("Cost: $800", width/2 - 120, height/2 + 22);
  image(chilipepperIcon, width/2 + 100, height/2 + 7, 32, 32);

  //strawberry
  fill(235, 235, 200);
  rect(width/2, height/2 + 50, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Strawberry", width/2 - 120, height/2 + 49);
  if (farm.money < 1600) { fill(255, 0, 0); }
  text("Cost: $1600", width/2 - 120, height/2 + 67);
  image(strawberryIcon, width/2 + 100, height/2 + 52, 32, 32);

  //bellpepper
  fill(235, 235, 200);
  rect(width/2, height/2 + 95, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Bell Pepper", width/2 - 120, height/2 + 94);
  if (farm.money < 3200) { fill(255, 0, 0); }
  text("Cost: $3200", width/2 - 120, height/2 +112);
  image(bellpepperIcon, width/2 + 100, height/2 + 97, 32, 32);

  //sugarcane
  fill(235, 235, 200);
  rect(width/2, height/2 + 140, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Sugar Cane", width/2 - 120, height/2 + 139);
  if (farm.money < 6400) { fill(255, 0, 0); }
  text("Cost: $6400", width/2 - 120, height/2 + 157);
  image(sugarcaneIcon, width/2 + 100, height/2 + 142, 32, 32);

  //apple
  fill(235, 235, 200);
  rect(width/2, height/2 + 185, menuWidth - 40, 40, 5);
  fill(0);
  textAlign(LEFT);
  textSize(18);
  text("Apple Tree", width/2 - 120, height/2 + 184);
  if (farm.money < 12800) { fill(255, 0, 0); }
  text("Cost: $12800", width/2 - 120, height/2 + 202);
  image(appletreeIcon, width/2 + 100, height/2 + 187, 32, 32);

  for (int i = 0; i < abs(farm.level-8) && farm.level < 9; i++) {
    fill(110);
    rect(width/2, height/2 + 185 - i*45, menuWidth - 40, 40, 5);
    fill(190);
    rect(width/2, height/2 + 185 - i*45, 15, 20, 7);
    fill(110);
    rect(width/2, height/2 + 185 - i*45, 7, 12, 3);
    fill(135, 118, 39);
    rect(width/2, height/2 + 195 - i*45, 20, 15);
  }
  
  //close button
  fill(255, 200, 200);
  rect(width/2, height/2 + 240, 120, 40, 10);
  fill(0);
  textAlign(CENTER);
  text("Close", width/2, height/2 + 245);

  textAlign(BASELINE);
}

// Game Menu
void gameMenu() {
    if (!gameMenuOpen) return;

    fill(200, 200, 200, 230);
    stroke(0);
    rectMode(CENTER);
    int menuWidth = 400;
    int menuHeight = 500;
    rect(width/2, height/2, menuWidth, menuHeight, 10);
    fill(0);
    textSize(24);
    textAlign(CENTER);
    text("Paused", width/2, height/2 - 200);
    
    // Buttons
    fill(232, 232, 165);
    rect(width/2, height/2 - 140, menuWidth - 60, 60, 5);
    translate(0, 75);
    rect(width/2, height/2 - 140, menuWidth - 60, 60, 5);
    translate(0, 75);
    rect(width/2, height/2 - 140, menuWidth - 60, 60, 5);
    translate(0, 75);
    rect(width/2, height/2 - 140, menuWidth - 60, 60, 5);
    translate(0, 75);
    rect(width/2, height/2 - 140, menuWidth - 60, 60, 5);
    resetMatrix();

    textSize(20);
    fill(0);
    text("Resume", width/2, height/2 - 140);
    translate(0, 75);
    text("Restart", width/2, height/2 - 140);
    translate(0, 75);
    text("Main Menu", width/2, height/2 - 140);
    translate(0, 75);
    text("Level Select", width/2, height/2 - 140);
    translate(0, 75);
    text("Quit Game", width/2, height/2 - 140);
    resetMatrix();

    textAlign(BASELINE);
}

void mousePressed() {
    if (gameState == 1) {
        if (mouseX >= 205 && mouseX <= 595 && mouseY >= 280 && mouseY <= 370) {
            gameState = 3;
            gamePaused = false;
        }
        else if (mouseX >= 205 && mouseX <= 595 && mouseY >= 405 && mouseY <= 495) {
            gameState = 2;
        }
        else if (mouseX >= 205 && mouseX <= 595 && mouseY >= 530 && mouseY <= 620) {
            exit();
        }
    }
    else if (gameState == 2) {
        // TODO: implement level buttons

        // Back Button
        if (mouseX >= 37 && mouseX <= 113 && mouseY >= 37 && mouseY <= 113) {
            gameState = 1;
        }
    }
    else if (gameState == 3) {
        // For Menu
        // If menu open, handle clicks
        if (menuOpen) {
            // Check if close button was clicked
            if (mouseX > width/2 - 60 && mouseX < width/2 + 60 && mouseY > height/2 + 220 && mouseY < height/2 + 260) {
                menuOpen = false;
                buttonClick.play();
            }
            //wheat
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 150 && mouseY < height/2 - 110) {
                if (farm.getMoney() >= 100) {
                    farm.plantCrop(selectedRow, selectedCol, WHEAT);
                    menuOpen = false;
                    planting.play();
                }
            }
            //corn
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 105 && mouseY < height/2 - 65) {
                if (farm.getMoney() >= 200 && farm.level >= CORN) {
                    farm.plantCrop(selectedRow, selectedCol, CORN);
                    menuOpen = false;
                    planting.play();
                }
            }
            //blueberry
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 60 && mouseY < height/2 - 20) {
                if (farm.getMoney() >= 400 && farm.level >= BLUEBERRY) {
                    farm.plantCrop(selectedRow, selectedCol, BLUEBERRY);
                    menuOpen = false;
                    planting.play();
                }
            }
            //chili pepper
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 - 15 && mouseY < height/2 + 25) {
                if (farm.getMoney() >= 800 && farm.level >= CHILIPEPPER) {
                    farm.plantCrop(selectedRow, selectedCol, CHILIPEPPER);
                    menuOpen = false;
                    planting.play();
                }
            }
            //strawberry
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 30 && mouseY < height/2 + 70) {
                if (farm.getMoney() >= 1600 && farm.level >= STRAWBERRY) {
                    farm.plantCrop(selectedRow, selectedCol, STRAWBERRY);
                    menuOpen = false;
                    planting.play();
                }
            }
            //bell pepper
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 75 && mouseY < height/2 + 115) {
                if (farm.getMoney() >= 3200 && farm.level >= BELLPEPPER) {
                    farm.plantCrop(selectedRow, selectedCol, BELLPEPPER);
                    menuOpen = false;
                    planting.play();
                }
            }
            //sugar cane
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 120 && mouseY < height/2 + 160) {
                if (farm.getMoney() >= 6400 && farm.level >= SUGARCANE) {
                    farm.plantCrop(selectedRow, selectedCol, SUGARCANE);
                    menuOpen = false;
                    planting.play();
                }
            }
            //apple tree
            else if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > height/2 + 165 && mouseY < height/2 + 205) {
                if (farm.getMoney() >= 12800 && farm.level >= APPLETREE) {
                    farm.plantCrop(selectedRow, selectedCol, APPLETREE);
                    menuOpen = false;
                    planting.play();
                }
            }
        }

        // For GameMenu
        // If menu open, handle clicks
        if (gameMenuOpen) {
            if (mouseX >= 230 && mouseX <= 570 && mouseY >= 230 && mouseY <= 290) {
                gameMenuOpen = false;
                gamePaused = false;
                buttonClick.play();
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 305 && mouseY <= 365) {
                gameMenuOpen = false;
                menuOpen = false;
                //TODO: implement restarting current level
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 380 && mouseY <= 440) {
                gameMenuOpen = false;
                menuOpen = false;
                gameState = 1;
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 455 && mouseY <= 515) {
                gameMenuOpen = false;
                menuOpen = false;
                gameState = 2;
            }
            else if (mouseX >= 230 && mouseX <= 570 && mouseY >= 530 && mouseY <= 590) {
                exit();
            }
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
        else if (mouseX >= 25 && mouseX <= 75 && mouseY >= 25 && mouseY <= 75) {
            if (!gameMenuOpen) {
                gameMenuOpen = true;
                gamePaused = true;
                buttonClick.play();
            }
        }
        else {
            // Plant/Harvest Crop
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
        
    }
}

void keyPressed() {
    if (gameState == 3) {
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
}


// -----------------------------------------------------------------------------------------
// 
//                           CLASS FUNCTIONS AND DEFINITIONS
//
// -----------------------------------------------------------------------------------------

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
            cooldown = 750;
        }
        else if (mob == DRAGON) {
            cooldown = 500;
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
            if (farm.level > 1) { speed = 2; }
            if (farm.level > 2) { speed = 3; }
        }
        else if (mob == WOLF) {
            fullThreat = 60;
            currThreat = 60;
            fullFear = 150;
            currFear = 0;
            speed = 1;
            if (farm.level > 4) { fullFear = 200; }
            if (farm.level > 5) { fullFear = 250; }
        }
        else if (mob == DRAGON) {
            fullThreat = 50;
            currThreat = 50;
            fullFear = 100;
            currFear = 0;
            speed = 2;
            if (farm.level > 6) { fullThreat = 40; currThreat = 40; }
            if (farm.level > 7) { fullThreat = 30; currThreat = 30; }
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
                        cooldown = 750;
                    }
                    if (mob == DRAGON) {
                        cooldown = 500;
                    }
                }
            }
        }
    }

    void updateCooldown() {
        if (cooldown > 0) {
            if (mob == FOX || (mob == WOLF && farm.level > 3) || (mob == DRAGON && farm.level > 6)) {
                cooldown--;
            }
        }
    }

    void drawMob() {
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
        else if (mob == WOLF) {
            if (walkCycle == 1) {
                image(wolfWalk1, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 2;
                }
            }
            else if (walkCycle == 2) {
                image(wolfWalk2, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 3;
                }
            }
            else if (walkCycle == 3) {
                image(wolfWalk3, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 4;
                }
            }
            else if (walkCycle == 4) {
                image(wolfWalk4, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 1;
                }
            }
        }
        else if (mob == DRAGON) {
            if (walkCycle == 1) {
                image(dragonWalk1, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 2;
                }
            }
            else if (walkCycle == 2) {
                image(dragonWalk2, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 3;
                }
            }
            else if (walkCycle == 3) {
                image(dragonWalk3, xPos, yPos-10, 32, 32);
                if (timer % 20 == 0) {
                    walkCycle = 4;
                }
            }
            else if (walkCycle == 4) {
                image(dragonWalk4, xPos, yPos-10, 32, 32);
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
            rect(xPos-20, yPos-20, xPos-20+40*currFear/fullFear, yPos-25);
            noFill();
            stroke(0);
            rect(xPos-20, yPos-20, xPos+20, yPos-25);
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

    void updateMob() {
        if (!isRetreating) {
            if (xPos < 100) {
                xPos += speed;
                if (xPos > 100) {
                    xPos = 100;
                }
            }
            else if (xPos > width-100) {
                xPos -= speed;
                if (xPos < width-100) {
                    xPos = width-100;
                }
            }
            else if (yPos < 200) {
                yPos += speed;
                if (yPos > 200) {
                    yPos = 200;
                }
            }
            else if (yPos > height-100) {
                yPos -= speed;
                if (yPos < height-100) {
                    yPos = height-100;
                }
            }
            else if (prefersX) {
                if (xPos < targetRow*100+108) {
                    xPos += speed;
                    if (xPos > targetRow*100+108) {
                        xPos = targetRow*100+108;
                    }
                }
                else if (xPos > targetRow*100+192) {
                    xPos -= speed;
                    if (xPos < targetRow*100+192) {
                        xPos = targetRow*100+192;
                    }
                }
                else if (yPos < targetCol*100+208) {
                    yPos += speed;
                    if (yPos > targetCol*100+208) {
                        yPos = targetCol*100+208;
                    }
                }
                else if (yPos > targetCol*100+292) {
                    yPos -= speed;
                    if (yPos < targetCol*100+192) {
                        yPos = targetCol*100+192;
                    }
                }
            }
            else {
                if (yPos < targetCol*100+208) {
                    yPos += speed;
                    if (yPos > targetCol*100+208) {
                        yPos = targetCol*100+208;
                    }
                }
                else if (yPos > targetCol*100+292) {
                    yPos -= speed;
                    if (yPos < targetCol*100+292) {
                        yPos = targetCol*100+292;
                    }
                }
                else if (xPos < targetRow*100+108) {
                    xPos += speed;
                    if (xPos > targetRow*100+108) {
                        xPos = targetRow*100+108;
                    }
                }
                else if (xPos > targetRow*100+192) {
                    xPos -= speed;
                    if (xPos < targetRow*100+192) {
                        xPos = targetRow*100+192;
                    }
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
        if (mouseX >= xPos-30 && mouseX <= xPos+30 && mouseY >= yPos-30 && mouseY <= yPos+30 && (abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20)) {
            if (currFear < fullFear) {
                currFear++;
            }
            else {
                if (!isRetreating) { 
                    if (mob == FOX) {
                        farm.xp += 50; 
                    }
                    else if (mob == WOLF) {
                        farm.xp += 200;
                    }
                    else if(mob == DRAGON) {
                        farm.xp += 800;
                    }
                    scaring.play();
                }
                isRetreating = true;
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
                if (plots[i][j].getPlant() == CORN) {
                    drawCorn(i*100+150, j*100+250, plots[i][j].getAge());
                }
                if (plots[i][j].getPlant() == BLUEBERRY) {
                    drawBlueberry(i*100+150, j*100+250, plots[i][j].getAge());
                }
                if (plots[i][j].getPlant() == CHILIPEPPER) {
                    drawChiliPepper(i*100+150, j*100+250, plots[i][j].getAge());
                }
                if (plots[i][j].getPlant() == STRAWBERRY) {
                    drawStrawberry(i*100+150, j*100+250, plots[i][j].getAge());
                }
                if (plots[i][j].getPlant() == BELLPEPPER) {
                    drawBellPepper(i*100+150, j*100+250, plots[i][j].getAge());
                }
                if (plots[i][j].getPlant() == SUGARCANE) {
                    drawSugarCane(i*100+150, j*100+250, plots[i][j].getAge());
                }
                if (plots[i][j].getPlant() == APPLETREE) {
                    drawAppleTree(i*100+150, j*100+250, plots[i][j].getAge());
                }
            }
        }

        // tools hotbar
        fill(150);
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
        if (timer < 100) { text("Time: 0", width-250, 60); }
        else { text("Time: " + str(timer).substring(0, str(timer).length() - 2), width-250, 60); }

        // Money
        fill(0);
        textSize(30);
        text("Money: $" + str(money), 100, 60);
        
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

        // Game Menu Button
        image(menuButton, 50, 50);

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
        plots[row][col].setAge(0);
        if (plant == WHEAT) {
            plots[row][col].setLifespan(100);
            plots[row][col].setCost(100);
            plots[row][col].setSell(200);
            plots[row][col].setXpval(50);
            money = money - 100;
        }   
        if (plant == CORN) {
            plots[row][col].setLifespan(175);
            plots[row][col].setCost(200);
            plots[row][col].setSell(400);
            plots[row][col].setXpval(100);
            money = money - 200;
        }
        if (plant == BLUEBERRY) {
            plots[row][col].setLifespan(300);
            plots[row][col].setCost(400);
            plots[row][col].setSell(800);
            plots[row][col].setXpval(200);
            money = money - 400;
        }
        if (plant == CHILIPEPPER) {
            plots[row][col].setLifespan(50);
            plots[row][col].setCost(800);
            plots[row][col].setSell(900);
            plots[row][col].setXpval(35);
            money = money - 800;
        }
        if (plant == STRAWBERRY) {
            plots[row][col].setLifespan(400);
            plots[row][col].setCost(1600);
            plots[row][col].setSell(3200);
            plots[row][col].setXpval(300);
            money = money - 1600;
        }
        if (plant == BELLPEPPER) {
            plots[row][col].setLifespan(500);
            plots[row][col].setCost(3200);
            plots[row][col].setSell(6400);
            plots[row][col].setXpval(400);
            money = money - 3200;
        }
        if (plant == SUGARCANE) {
            plots[row][col].setLifespan(600);
            plots[row][col].setCost(6400);
            plots[row][col].setSell(12800);
            plots[row][col].setXpval(600);
            money = money - 6400;
        }
        if (plant == APPLETREE) {
            plots[row][col].setLifespan(1000);
            plots[row][col].setCost(12800);
            plots[row][col].setSell(25600);
            plots[row][col].setXpval(2000);
            money = money - 12800;
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


// -----------------------------------------------------------------------------------------
// 
//                           THE GREAT WALL OF DRAW FUNCTIONS
//
// -----------------------------------------------------------------------------------------

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

// Draws corn based on its age
void drawCorn(int x, int y, int age) {
    if (age < 35) {
        image(corn1, x-15, y-15, 64, 64);
        image(corn1, x-15, y+15, 64, 64);
        image(corn1, x+15, y+15, 64, 64);
        image(corn1, x+15, y-15, 64, 64);
    }
    else if (age < 70) {
        image(corn2, x-15, y-15, 64, 64);
        image(corn2, x-15, y+15, 64, 64);
        image(corn2, x+15, y+15, 64, 64);
        image(corn2, x+15, y-15, 64, 64);
    }
    else if (age < 105) {
        image(corn3, x-15, y-15, 64, 64);
        image(corn3, x-15, y+15, 64, 64);
        image(corn3, x+15, y+15, 64, 64);
        image(corn3, x+15, y-15, 64, 64);
    }
    else if (age < 140) {
        image(corn4, x-15, y-15, 64, 64);
        image(corn4, x-15, y+15, 64, 64);
        image(corn4, x+15, y+15, 64, 64);
        image(corn4, x+15, y-15, 64, 64);
    }
    else if (age < 175) {
        image(corn5, x-15, y-15, 64, 64);
        image(corn5, x-15, y+15, 64, 64);
        image(corn5, x+15, y+15, 64, 64);
        image(corn5, x+15, y-15, 64, 64);
    }
    else {
        image(corn6, x-15, y-15, 64, 64);
        image(corn6, x-15, y+15, 64, 64);
        image(corn6, x+15, y+15, 64, 64);
        image(corn6, x+15, y-15, 64, 64);
    }
}

// Draws blueberry based on its age
void drawBlueberry(int x, int y, int age) {
    if (age < 60) {
        image(blueberry1, x-15, y-15, 64, 64);
        image(blueberry1, x-15, y+15, 64, 64);
        image(blueberry1, x+15, y+15, 64, 64);
        image(blueberry1, x+15, y-15, 64, 64);
    }
    else if (age < 120) {
        image(blueberry2, x-15, y-15, 64, 64);
        image(blueberry2, x-15, y+15, 64, 64);
        image(blueberry2, x+15, y+15, 64, 64);
        image(blueberry2, x+15, y-15, 64, 64);
    }
    else if (age < 180) {
        image(blueberry3, x-15, y-15, 64, 64);
        image(blueberry3, x-15, y+15, 64, 64);
        image(blueberry3, x+15, y+15, 64, 64);
        image(blueberry3, x+15, y-15, 64, 64);
    }
    else if (age < 240) {
        image(blueberry4, x-15, y-15, 64, 64);
        image(blueberry4, x-15, y+15, 64, 64);
        image(blueberry4, x+15, y+15, 64, 64);
        image(blueberry4, x+15, y-15, 64, 64);
    }
    else if (age < 300) {
        image(blueberry5, x-15, y-15, 64, 64);
        image(blueberry5, x-15, y+15, 64, 64);
        image(blueberry5, x+15, y+15, 64, 64);
        image(blueberry5, x+15, y-15, 64, 64);
    }
    else {
        image(blueberry6, x-15, y-15, 64, 64);
        image(blueberry6, x-15, y+15, 64, 64);
        image(blueberry6, x+15, y+15, 64, 64);
        image(blueberry6, x+15, y-15, 64, 64);
    }
}

// Draws chili pepper based on its age
void drawChiliPepper(int x, int y, int age) {
    if (age < 10) {
        image(chilipepper1, x-15, y-15, 64, 64);
        image(chilipepper1, x-15, y+15, 64, 64);
        image(chilipepper1, x+15, y+15, 64, 64);
        image(chilipepper1, x+15, y-15, 64, 64);
    }
    else if (age < 20) {
        image(chilipepper2, x-15, y-15, 64, 64);
        image(chilipepper2, x-15, y+15, 64, 64);
        image(chilipepper2, x+15, y+15, 64, 64);
        image(chilipepper2, x+15, y-15, 64, 64);
    }
    else if (age < 30) {
        image(chilipepper3, x-15, y-15, 64, 64);
        image(chilipepper3, x-15, y+15, 64, 64);
        image(chilipepper3, x+15, y+15, 64, 64);
        image(chilipepper3, x+15, y-15, 64, 64);
    }
    else if (age < 40) {
        image(chilipepper4, x-15, y-15, 64, 64);
        image(chilipepper4, x-15, y+15, 64, 64);
        image(chilipepper4, x+15, y+15, 64, 64);
        image(chilipepper4, x+15, y-15, 64, 64);
    }
    else if (age < 50) {
        image(chilipepper5, x-15, y-15, 64, 64);
        image(chilipepper5, x-15, y+15, 64, 64);
        image(chilipepper5, x+15, y+15, 64, 64);
        image(chilipepper5, x+15, y-15, 64, 64);
    }
    else {
        image(chilipepper6, x-15, y-15, 64, 64);
        image(chilipepper6, x-15, y+15, 64, 64);
        image(chilipepper6, x+15, y+15, 64, 64);
        image(chilipepper6, x+15, y-15, 64, 64);
    }
}

// Draws strawberry based on its age
void drawStrawberry(int x, int y, int age) {
    if (age < 80) {
        image(strawberry1, x-15, y-15, 64, 64);
        image(strawberry1, x-15, y+15, 64, 64);
        image(strawberry1, x+15, y+15, 64, 64);
        image(strawberry1, x+15, y-15, 64, 64);
    }
    else if (age < 160) {
        image(strawberry2, x-15, y-15, 64, 64);
        image(strawberry2, x-15, y+15, 64, 64);
        image(strawberry2, x+15, y+15, 64, 64);
        image(strawberry2, x+15, y-15, 64, 64);
    }
    else if (age < 240) {
        image(strawberry3, x-15, y-15, 64, 64);
        image(strawberry3, x-15, y+15, 64, 64);
        image(strawberry3, x+15, y+15, 64, 64);
        image(strawberry3, x+15, y-15, 64, 64);
    }
    else if (age < 320) {
        image(strawberry4, x-15, y-15, 64, 64);
        image(strawberry4, x-15, y+15, 64, 64);
        image(strawberry4, x+15, y+15, 64, 64);
        image(strawberry4, x+15, y-15, 64, 64);
    }
    else if (age < 400) {
        image(strawberry5, x-15, y-15, 64, 64);
        image(strawberry5, x-15, y+15, 64, 64);
        image(strawberry5, x+15, y+15, 64, 64);
        image(strawberry5, x+15, y-15, 64, 64);
    }
    else {
        image(strawberry6, x-15, y-15, 64, 64);
        image(strawberry6, x-15, y+15, 64, 64);
        image(strawberry6, x+15, y+15, 64, 64);
        image(strawberry6, x+15, y-15, 64, 64);
    }
}

// Draws bell pepper based on its age
void drawBellPepper(int x, int y, int age) {
    if (age < 100) {
        image(bellpepper1, x-15, y-15, 64, 64);
        image(bellpepper1, x-15, y+15, 64, 64);
        image(bellpepper1, x+15, y+15, 64, 64);
        image(bellpepper1, x+15, y-15, 64, 64);
    }
    else if (age < 200) {
        image(bellpepper2, x-15, y-15, 64, 64);
        image(bellpepper2, x-15, y+15, 64, 64);
        image(bellpepper2, x+15, y+15, 64, 64);
        image(bellpepper2, x+15, y-15, 64, 64);
    }
    else if (age < 300) {
        image(bellpepper3, x-15, y-15, 64, 64);
        image(bellpepper3, x-15, y+15, 64, 64);
        image(bellpepper3, x+15, y+15, 64, 64);
        image(bellpepper3, x+15, y-15, 64, 64);
    }
    else if (age < 400) {
        image(bellpepper4, x-15, y-15, 64, 64);
        image(bellpepper4, x-15, y+15, 64, 64);
        image(bellpepper4, x+15, y+15, 64, 64);
        image(bellpepper4, x+15, y-15, 64, 64);
    }
    else if (age < 500) {
        image(bellpepper5, x-15, y-15, 64, 64);
        image(bellpepper5, x-15, y+15, 64, 64);
        image(bellpepper5, x+15, y+15, 64, 64);
        image(bellpepper5, x+15, y-15, 64, 64);
    }
    else {
        image(bellpepper6, x-15, y-15, 64, 64);
        image(bellpepper6, x-15, y+15, 64, 64);
        image(bellpepper6, x+15, y+15, 64, 64);
        image(bellpepper6, x+15, y-15, 64, 64);
    }
}

// Draws sugar cane based on its age
void drawSugarCane(int x, int y, int age) {
    if (age < 120) {
        image(sugarcane1, x-15, y-15, 64, 64);
        image(sugarcane1, x-15, y+15, 64, 64);
        image(sugarcane1, x+15, y+15, 64, 64);
        image(sugarcane1, x+15, y-15, 64, 64);
    }
    else if (age < 240) {
        image(sugarcane2, x-15, y-15, 64, 64);
        image(sugarcane2, x-15, y+15, 64, 64);
        image(sugarcane2, x+15, y+15, 64, 64);
        image(sugarcane2, x+15, y-15, 64, 64);
    }
    else if (age < 360) {
        image(sugarcane3, x-15, y-15, 64, 64);
        image(sugarcane3, x-15, y+15, 64, 64);
        image(sugarcane3, x+15, y+15, 64, 64);
        image(sugarcane3, x+15, y-15, 64, 64);
    }
    else if (age < 480) {
        image(sugarcane4, x-15, y-15, 64, 64);
        image(sugarcane4, x-15, y+15, 64, 64);
        image(sugarcane4, x+15, y+15, 64, 64);
        image(sugarcane4, x+15, y-15, 64, 64);
    }
    else if (age < 600) {
        image(sugarcane5, x-15, y-15, 64, 64);
        image(sugarcane5, x-15, y+15, 64, 64);
        image(sugarcane5, x+15, y+15, 64, 64);
        image(sugarcane5, x+15, y-15, 64, 64);
    }
    else {
        image(sugarcane6, x-15, y-15, 64, 64);
        image(sugarcane6, x-15, y+15, 64, 64);
        image(sugarcane6, x+15, y+15, 64, 64);
        image(sugarcane6, x+15, y-15, 64, 64);
    }
}

// Draws apple tree based on its age
void drawAppleTree(int x, int y, int age) {
    if (age < 200) {
        image(appletree1, x+5, y, 80, 80);
    }
    else if (age < 400) {
        image(appletree2, x+5, y, 80, 80);
    }
    else if (age < 600) {
        image(appletree3, x+5, y, 80, 80);
    }
    else if (age < 800) {
        image(appletree4, x+5, y, 80, 80);
    }
    else if (age < 1000) {
        image(appletree5, x+5, y, 80, 80);
    }
    else {
        image(appletree6, x+5, y, 80, 80);
    }
}
