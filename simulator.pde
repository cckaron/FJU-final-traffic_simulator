import java.util.Map;
import java.util.LinkedList;
import http.requests.*;

ArrayList<Car> carArr = new ArrayList<Car>();
Intersection intersection;
static TimeControl timer;

boolean press_a;
float[][] path = {{180, 1000}, {180, 580}, {1920, 580}};
int[] direction = {1, 4};

float[][] path1 = {{1540, 20}, {1540, 450}, {200, 450}, {180, 0}};
int[] direction1 = {2, 3, 1};

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

  timer = new TimeControl(10, 30);
}

void draw() {
  background(img);
  drawTrafficLight();
  timer.countdown();
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
      count -= 2;
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
    if (count < 20) {
      Car addCar = new Car(carArr.size(), path, direction);
      addCar.start();
      carArr.add(addCar);
      
      Car addCar1 = new Car(carArr.size()+1, path1, direction1);
      addCar1.start();
      carArr.add(addCar1);
      
      count += 2;
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
