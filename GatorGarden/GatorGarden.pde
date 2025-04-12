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

void setup() {
    size(800,800);
    width = 800;
    height = 800;
    rectMode(CENTER);
    ellipseMode(CENTER);
}

void draw() {
    background(161, 126, 93);
    farm.updateFarm();
    farm.drawFarm();
    farmer.drawFarmer();

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
}

void mousePressed() {

    if (mouseX <= 500 && mouseX >= 460 && mouseY >= 25 && mouseY <= 45 && farmer.upgradesAvailable > 0) {
        farmer.speed += 1;
        farmer.upgradesAvailable -= 1;
    }
    else if (mouseX <= 500 && mouseX >= 460 && mouseY >= 55 && mouseY <= 75 && farmer.upgradesAvailable > 0) {
        farmer.reach += 1;
        farmer.upgradesAvailable -= 1;
    }
    else {
        // Plant/Harvest Crop
        for (int i = 0; i < farm.getRows(); i++) {
            for (int j = 0; j < farm.getCols(); j++) {
                if (mouseX >= i*100+110 && mouseX <= i*100+190 && mouseY >= j*100+210 && mouseY <= j*100+290 && (abs(farmer.xPos - mouseX) <= farmer.reach*30 + 20) && (abs(farmer.yPos - mouseY) <= farmer.reach*30 + 20)) {
                    if (farm.getCropType(i, j) == 0 && farm.getMoney() >= 100) {
                        farm.plantCrop(i, j, WHEAT);
                    }
                    else if (farm.isCropReady(i, j)) {
                        farm.harvestCrop(i,j);
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
    // TODO: Use images to draw the flower
    if (age < 100) {
        fill(53, 135, 41);
        ellipse(x, y, 20, 20);
    }
    else {
        fill(222);
        ellipse(x, y, 40, 40);
    }
}

// Class used to represent the player's character
class Farmer {

    // TODO: Implement a 'speed' variable

    int xPos, yPos;
    int upgradesAvailable;
    int speed;
    int reach;

    // initializes farmer
    Farmer() {
        // starting location is at the center of the window
        xPos = 400;
        yPos = 400;
        upgradesAvailable = 0;
        speed = 1;
        reach = 1;
    }

    // draws the farmer
    // TODO: images will be used for the farmer and movement will be animated
    void drawFarmer() {
        fill(255);
        rect(xPos, yPos, 16, 16);
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
    }

    // FOR DEBUGGING
    void printPos() {
        println(xPos + ", " + yPos);
    }

    // TODO: create functions for upgrading stats

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
        fill(60, 105, 66);
        rect(xPos, yPos, 16, 16);

        // fear meter
        if (currFear > 0) {
            fill(255,255,0);
            noStroke();
            rectMode(CORNERS);
            rect(xPos-fullFear/4, yPos-10, xPos-fullFear/4+currFear/2, yPos-15);
            noFill();
            stroke(0);
            rect(xPos-fullFear/4, yPos-10, xPos+fullFear/4, yPos-15);
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
            arc(xPos, yPos-30, 30, 30, (fullThreat-currThreat)*2*PI/fullThreat-(PI/2), 3*PI/2);
            stroke(0);
            noFill();
            ellipse(xPos, yPos-30, 30, 30);
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

    Plot() {
        plant = 0;
        age = 0;
        lifespan = 0;
        cost = 0;
        sell = 0;
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

    // SETTERS
    void setPlant(int plant) { this.plant = plant; }
    void setAge(int age) { this.age = age; }
    void setLifespan(int lifespan) { this.lifespan = lifespan; }
    void setCost(int cost) { this.cost = cost; }
    void setSell(int sell) { this.sell = sell; }

}

// Contains an array of Plots, a timer, and money
class Farm {
    Plot[][] plots;
    int rows;
    int cols;
    int money;
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

        // Timer
        fill(246, 246, 67);
        rect(width-50, 50, 80, 80);
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
            money = money - 100;
        }
    }

    // Removes the crop from the Plot at the given coordinate
    void harvestCrop(int row, int col) {
        money = money + plots[row][col].getSell();
        destroyCrop(row, col);

                // Leveling (may need to change later)
        if (money >= 51200) {
            if (level < 9) {
                level = 9;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 25600) {
            if (level < 8) {
                level = 8;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 12800) {
            if (level < 7) {
                level = 7;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 6400) {
            if (level < 6) {
                level = 6;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 3200) {
            if (level < 5) {
                level = 5;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 1600) {
            if (level < 4) {
                level = 4;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 800) {
            if (level < 3) {
                level = 3;
                farmer.upgradesAvailable += 1;
            }
        }
        else if (money >= 400) {
            if (level < 2) {
                level = 2;
                farmer.upgradesAvailable += 1;
            }
        }
    }

    void destroyCrop(int row, int col) {
        plots[row][col].setPlant(0);
        plots[row][col].setAge(0);
        plots[row][col].setLifespan(0);
        plots[row][col].setCost(0);
        plots[row][col].setSell(0);
    }

    // GETTERS
    int getRows() { return rows; }
    int getCols() { return cols; }
    int getMoney() { return money; }
    int getCropType(int row, int col) { return plots[row][col].getPlant(); }
    boolean isCropReady(int row, int col) { return plots[row][col].harvestable(); }
}


