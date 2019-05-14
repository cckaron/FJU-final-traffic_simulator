import java.util.Map;
import java.util.LinkedList;
import http.requests.*;
import java.util.Random;

ArrayList<Car> carArr = new ArrayList<Car>();
Intersection intersection;
TimeControl timer;

boolean press_a;
//direction 1->up; 2->down; 3->left; 4-> right
float[][] path_a1={{180, 1000}, {180, 580}, {950, 580}, {950, 0}};
int[] direction_a1 = {1, 4, 1};
//左中下
float[][] path_a2={{180, 1000}, {180, 580}, {800, 580}, {800, 1080}};
int[] direction_a2 = {1, 4, 2};

float[][] path_a3={{180, 1000}, {180, 580}, {1680, 580}, {1680, 1080}};
int[] direction_a3 = {1, 4, 1};

float[][] path_a4={{180, 1000}, {180, 580}, {1540, 580}, {1540, 1080}};
int[] direction_a4 = {1, 4, 2};


float[][] path_b1 = {{1540, 20}, {1540, 450}, {800, 450}, {800, 0}};
int[] direction_b1 = {2, 3, 1};

float[][] path_b2 = {{1540, 20}, {1540, 450}, {215, 450}, {215, 0}};
int[] direction_b2 = {2, 3, 1};

float[][] path_b3 = {{1540, 20}, {1540, 450}, {800, 450}, {800, 1080}};
int[] direction_b3 = {2, 3, 2};

float[][] path_b4 = {{1540, 20}, {1540, 450}, {90, 450}, {90, 1080}};
int[] direction_b4 = {2, 3, 2};

PImage img;
int lastAdd;
int count = 0;

void setup() {
  size(1920, 1080);
  //fullScreen();
  lastAdd = millis();

  img = loadImage("image/background.png");
  background(img);

  intersection = new Intersection();
  intersection.start();

  timer = new TimeControl(10, 30); //dir1, dir2
}

void draw() {
  background(img);
  drawTrafficLight();
  timer.countdown();

  //show the intersection information
  intersection.getSecCarCount("left", "right");

  if (mousePressed) {
    System.out.printf("mouseX: %d, mouseY: %d", mouseX, mouseY);
    System.out.println();
    //intersection.getSecCarCount("left", "right");
    timer.judgeRule();
  }

  for (int i = 0; i < carArr.size(); i ++) {
    Car car = carArr.get(i);
    if (car.alive()) {
      car.go();
    } else {
      count -= 1;
      carArr.remove(i);
      System.out.println("remove");
    }
  }

  //keyboard
  //if (keyPressed == true){
  //  if (key == 'a'){
  //    carArr.add(new Car(axis, direction));
  //  }
  //}
  if (press_a) {
    //Car addCar = new Car(carArr.size()+1, path, direction);
    //addCar.start();
    //carArr.add(addCar);
  }


  if (millis() - lastAdd > 500) {
    Random ran = new Random();
    int pid = ran.nextInt(4)+1;
    if (count < 20) {
      if (pid == 1) {
        Car addCar = new Car(carArr.size(), path_a1, direction_a1);
        addCar.start();
        carArr.add(addCar);

        Car addCar1 = new Car(carArr.size()+1, path_b1, direction_b1);
        addCar1.start();
        carArr.add(addCar1);

        count += 2;
      } else if (pid == 2) {
        Car addCar = new Car(carArr.size(), path_a2, direction_a2);
        addCar.start();
        carArr.add(addCar);

        Car addCar1 = new Car(carArr.size()+1, path_b2, direction_b2);
        addCar1.start();
        carArr.add(addCar1);

        count += 2;
      } else if (pid == 3) {
        Car addCar = new Car(carArr.size(), path_a3, direction_a3);
        addCar.start();
        carArr.add(addCar);

        Car addCar1 = new Car(carArr.size()+1, path_b3, direction_b3);
        addCar1.start();
        carArr.add(addCar1);

        count += 2;
      } else if (pid == 4) {
        Car addCar = new Car(carArr.size(), path_a4, direction_a4);
        addCar.start();
        carArr.add(addCar);

        Car addCar1 = new Car(carArr.size()+1, path_b4, direction_b4);
        addCar1.start();
        carArr.add(addCar1);

        count += 2;
      }
    }
    lastAdd = millis();
  }
}

void keyPressed() {
  setMove(key, true);
}

void keyReleased() {
  setMove(key, false);
}

boolean setMove(char k, boolean b) {
  switch(k) {
  case 'a':
    return press_a = b;
  default:
    return b;
  }
}

void drawTrafficLight() {
  //draw the board
  fill(255);
  //up-left
  rect(630, 290, 100, 100);
  //up-right
  rect(1028, 290, 100, 100);
  //down-left
  rect(630, 690, 100, 100);
  //down-right
  rect(1028, 690, 100, 100);

  //show seconds
  fill(0);
  textSize(70);
  //up-left
  text(timer.now_sec, 635, 365);
  //up-right
  text(timer.now_sec, 1033, 365);
  //down-left
  text(timer.now_sec, 635, 765);
  //down-righy
  text(timer.now_sec, 1033, 765);

  //draw light
  if (timer.now_direct == 1) {
    fill(255, 0, 0);

    //up-left
    circle(680, 230, 70);
    //down-right
    circle(1080, 850, 70);

    fill(0, 255, 0);
    //up-right
    circle(1080, 230, 70);
    //down-left
    circle(680, 850, 70);
  } else {
    fill(0, 255, 0);
    //up-left
    circle(680, 230, 70);
    //down-right
    circle(1080, 850, 70);

    fill(255, 0, 0);
    //up-right
    circle(1080, 230, 70);
    //down-left
    circle(680, 850, 70);
  }
}
