// Plant definitions
static final int MOONFLOWER = 1;

// Enemy definitions
static final int FOX = 1;

int width, height;

// Initializes a farmer, a farm, and the fox
Farmer farmer = new Farmer();
Farm farm = new Farm(6, 5, 100);
Mob fox = new Mob(FOX, int(random(23)));
// TODO: Initialize the other mobs

// FOR DEBUGGING
int prevKeyCode = 0;
char prevKey = ' ';

// TODO: Get rid of day/night cycle (scrapped idea)
boolean isDay = true;
int dayCount = 0;

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
    if (!isDay) {
        fox.moveMob();
        fox.drawMob();
    }
}

void mousePressed() {
    // Day/Night Button
    if (mouseX >= width-90 && mouseX <= width-10 && mouseY >= 10 && mouseY <= 90) {
        if (isDay) {
            isDay = !isDay;
            farm.setNightTimer(1000);
        }
    }

    // Plant/Harvest Crop
    else {
        for (int i = 0; i < farm.getRows(); i++) {
            for (int j = 0; j < farm.getCols(); j++) {
                if (mouseX >= i*100+110 && mouseX <= i*100+190 && mouseY >= j*100+210 && mouseY <= j*100+290 && isDay) {
                    if (farm.getCropPlant(i, j) == 0 && farm.getMoney() >= 100) {
                        farm.plantCrop(i, j, MOONFLOWER);
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

// Draws a moonflower based on its age and health
void drawMoonflower(int x, int y, int age, int health) {
    // TODO: Use images to draw the flower
    if (age == 0) {
        fill(53, 135, 41);
        ellipse(x, y, 20, 20);
    }
    else {
        fill(222);
        ellipse(x, y, 40, 40);
    }
    if (health < 100) {
        rectMode(CORNERS);
        noFill();
        rect(x-25, y-40, x+25, y-30);
        fill(33, 255, 0);
        rect(x-25, y-40, x-25+health/2, y-30);
        rectMode(CENTER);
    }
}

// Class used to represent the player's character
class Farmer {

    // TODO: Implement a 'speed' variable

    int xPos, yPos;
    int health; // TODO: Health is a scrapped feature

    // initializes farmer
    Farmer() {
        // starting location is at the center of the window
        xPos = 400;
        yPos = 400;
        health = 100;
    }

    // draws the farmer
    // TODO: images will be used for the farmer and movement will be animated
    void drawFarmer() {
        fill(255);
        rect(xPos, yPos, 10, 10);
        
        // TODO: remove health feature
        if (health < 100) {
            noStroke();
            fill(33, 255, 0);
            rect(xPos, yPos-15, 50, 5);
            stroke(0);
        }
    }

    // MOVEMENT FUNCTIONS
    // TODO: Implement a 'speed' variable
    void moveDown() {
        if (yPos % 100 >= 92 || yPos % 100 <= 4 || xPos % 100 <= 8 || xPos % 100 >= 92) {
            yPos = yPos + 4;
        }
    }
    void moveUp() {
        if (yPos % 100 >= 96 || yPos % 100 <= 8 || xPos % 100 <= 8 || xPos % 100 >= 92) {
            yPos = yPos - 4;
        }
    }
    void moveLeft() {
        if (xPos % 100 >= 96 || xPos % 100 <= 8 || yPos % 100 <= 8 || yPos % 100 >= 92) {
            xPos = xPos - 4;
        }
    }
    void moveRight() {
        if (xPos % 100 >= 92 || xPos % 100 <= 4 || yPos % 100 <= 8 || yPos % 100 >= 92) {
            xPos = xPos + 4;
        }
    }

    // FOR DEBUGGING
    void printPos() {
        println(xPos + ", " + yPos);
    }

    // TODO: create functions for upgrading stats

    // GETTERS
    int getXPos() { return xPos; }
    int getYPos() { return yPos; }
    int getHealth() { return health; }

    // SETTERS
    void setHealth(int health) { this.health = health; }

    // TODO: remove due to scrapped health feature
    void takeDamage(int damage) { health = health - damage; }
}

// TODO: Change to function with fox, wolf, and dragon enemies
class Mob {
    int mob;
    int xPos, yPos;
    int xTarget, yTarget;
    int health;
    int damage;
    int speed;

    Mob(int mob_type, int spawn_loc) {
        mob = mob_type;
        if (mob_type == FOX) {
            health = 100;
            damage = 4;
            speed = 1;
        }
        else {
            health = 100;
            damage = 0;
            speed = 0;
        }

        // TODO: Find an equation to simplify spawn location
        switch(spawn_loc) {
            case 0: xPos = 200; yPos = 100; break;
            case 1: xPos = 100; yPos = 100; break;
            case 2: xPos = 0; yPos = 200; break;
            case 3: xPos = 0; yPos = 300; break;
            case 4: xPos = 0; yPos = 400; break;
            case 5: xPos = 0; yPos = 500; break;
            case 6: xPos = 0; yPos = 600; break;
            case 7: xPos = 0; yPos = 700; break;
            case 8: xPos = 100; yPos = 800; break;
            case 9: xPos = 200; yPos = 800; break;
            case 10: xPos = 300; yPos = 800; break;
            case 11: xPos = 400; yPos = 800; break;
            case 12: xPos = 500; yPos = 800; break;
            case 13: xPos = 600; yPos = 800; break;
            case 14: xPos = 700; yPos = 800; break;
            case 15: xPos = 800; yPos = 700; break;
            case 16: xPos = 800; yPos = 600; break;
            case 17: xPos = 800; yPos = 500; break;
            case 18: xPos = 800; yPos = 400; break;
            case 19: xPos = 800; yPos = 300; break;
            case 20: xPos = 800; yPos = 200; break;
            case 21: xPos = 700; yPos = 100; break;
            case 22: xPos = 600; yPos = 100; break;
            default: break;
        }

        xTarget = farmer.getXPos();
        yTarget = farmer.getYPos();
    }

    // Resets the mob so it can return after it is dealt with by the player
    void resetMob() {
        if (mob == FOX) {
            health = 100;
            damage = 4;
            speed = 1;
        }
        else {
            health = 100;
            damage = 0;
            speed = 0;
        }

        int spawn_loc = int(random(23));
        switch(spawn_loc) {
            case 0: xPos = 200; yPos = 100; break;
            case 1: xPos = 100; yPos = 100; break;
            case 2: xPos = 0; yPos = 200; break;
            case 3: xPos = 0; yPos = 300; break;
            case 4: xPos = 0; yPos = 400; break;
            case 5: xPos = 0; yPos = 500; break;
            case 6: xPos = 0; yPos = 600; break;
            case 7: xPos = 0; yPos = 700; break;
            case 8: xPos = 100; yPos = 800; break;
            case 9: xPos = 200; yPos = 800; break;
            case 10: xPos = 300; yPos = 800; break;
            case 11: xPos = 400; yPos = 800; break;
            case 12: xPos = 500; yPos = 800; break;
            case 13: xPos = 600; yPos = 800; break;
            case 14: xPos = 700; yPos = 800; break;
            case 15: xPos = 800; yPos = 700; break;
            case 16: xPos = 800; yPos = 600; break;
            case 17: xPos = 800; yPos = 500; break;
            case 18: xPos = 800; yPos = 400; break;
            case 19: xPos = 800; yPos = 300; break;
            case 20: xPos = 800; yPos = 200; break;
            case 21: xPos = 700; yPos = 100; break;
            case 22: xPos = 600; yPos = 100; break;
            default: break;
        }

        xTarget = farmer.getXPos();
        yTarget = farmer.getYPos();
    }

    void drawMob() {
        fill(60, 105, 66);
        rect(xPos, yPos, 10, 10);
        if (health < 100) {
            noStroke();
            fill(33, 255, 0);
            rect(xPos, yPos-15, 50, 5);
            stroke(0);
        }
    }

    // TODO: Create function that calculates a path for the mob to take
    void moveMob() {
        xTarget = farmer.getXPos();
        yTarget = farmer.getYPos();
    }
}

// Represents an individual tile that crops can be planted on
class Plot {
    int plant; 
    int health;
    int age;
    int lifespan;
    int cost;
    int sell;
    int base_attraction;

    Plot() {
        plant = 0;
        health = 100;
        age = 0;
        lifespan = 0;
        cost = 0;
        sell = 0;
        base_attraction = 0;
    }

    // returns true if the crop is ready to be harvested / can be sold
    boolean harvestable() {
        return age >= lifespan;
    }

    // increments age by 1
    void incAge() { age++; }
    
    // GETTERS
    int getPlant() { return plant; }
    int getHealth() { return health; }
    int getAge() { return age; }
    int getLifespan() { return lifespan; }
    int getCost() { return cost; }
    int getSell() { return sell; }
    int getAttraction() { return base_attraction; }

    // SETTERS
    void setPlant(int plant) { this.plant = plant; }
    void setHealth(int health) { this.health = health; }
    void setAge(int age) { this.age = age; }
    void setLifespan(int lifespan) { this.lifespan = lifespan; }
    void setCost(int cost) { this.cost = cost; }
    void setSell(int sell) { this.sell = sell; }
    void setAttraction(int base_attraction) { this.base_attraction = base_attraction; }

}

// Contains an array of Plots, a timer, and money
class Farm {
    Plot[][] plots;
    int rows;
    int cols;
    int money;
    int nightTimer;

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
        nightTimer = 0;
    }

    // draws the farm
    void drawFarm() {

        // farm plots
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                fill(92, 64, 38);
                rect(i*100+150, j*100+250, 80, 80);
                if (plots[i][j].getPlant() == MOONFLOWER) {
                    drawMoonflower(i*100+150, j*100+250, plots[i][j].getAge(), plots[i][j].getHealth());
                }
            }
        }

        // tools hotbar
        fill(120);
        rect(width/2, 50, width-10, 90);

        // day/night button
        if (isDay) {
            fill(255, 225, 28);
            rect(width-50, 50, 80, 80);
        }
        else {
            fill(18, 18, 74);
            rect(width-50, 50, 80, 80);
            fill(67, 158, 168);
            textSize(30);
            if (nightTimer < 100) {
                text("00", width-65, 60);
            }
            else if (nightTimer < 1000) { 
                text("0", width-65, 60);
                text(str(nightTimer).substring( 0, str(nightTimer).length()-2 ), width-50, 60); 
            }
            else {
                text(str(nightTimer).substring( 0, str(nightTimer).length()-2 ), width-65, 60);
            }
        }

        // Day counter
        fill(0);
        textSize(30);
        if (dayCount < 10) {
            text("Day: 00" + str(dayCount), width-225, 60);
        }
        else if (dayCount < 100) {
            text("Day: 0" + str(dayCount), width-225, 60);
        }
        else {
            text(str(dayCount), width-100, 60);
        }

        // Money
        fill(0);
        textSize(30);
        text("Money: $" + str(money), 60, 60);
        
    }

    // updates the farm when called, specifically updates the timer and reacts based on timer data
    void updateFarm() {
        if (!isDay && nightTimer == 0) {
            isDay = true;
            dayCount++;
            for (int i = 0; i < rows; i++) {
                for (int j = 0; j < cols; j++) {
                    if (plots[i][j].getPlant() != 0) {
                        plots[i][j].incAge();
                    }
                }
            }
            fox.resetMob();
        }
        else {
            nightTimer = nightTimer - 1;
        }
    }

    // plants a crop of a specified type on the Plot of the given coordinate
    void plantCrop(int row, int col, int plant) {
        plots[row][col].setPlant(plant);
        if (plant == MOONFLOWER) {
            plots[row][col].setHealth(100);
            plots[row][col].setAge(0);
            plots[row][col].setLifespan(1);
            plots[row][col].setCost(100);
            plots[row][col].setSell(200);
            plots[row][col].setAttraction(1);
        }
        // TODO: Adjust money spent based on plant type
        money = money - 100;
    }

    // Removes the crop from the Plot at the given coordinate
    void harvestCrop(int row, int col) {
        money = money + plots[row][col].getSell();
        plots[row][col].setPlant(0);
        plots[row][col].setHealth(100);
        plots[row][col].setAge(0);
        plots[row][col].setLifespan(0);
        plots[row][col].setCost(0);
        plots[row][col].setSell(0);
        plots[row][col].setAttraction(0);
    }

    // GETTERS
    int getRows() { return rows; }
    int getCols() { return cols; }
    int getMoney() { return money; }
    int getCropPlant(int row, int col) { return plots[row][col].getPlant(); }
    boolean isCropReady(int row, int col) { return plots[row][col].harvestable(); }

    // SETTERS
    void setNightTimer(int nightTimer) { this.nightTimer = nightTimer; }
}

