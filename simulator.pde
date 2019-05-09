import java.util.Map;
import java.util.LinkedList;

ArrayList<Car> carArr = new ArrayList<Car>();
Intersection intersection;
static TimeControl timer;

boolean press_a;
float[][] path = {{180, 1000}, {180, 580}, {700, 580}};
int[] direction = {1, 4};
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

  timer = new TimeControl(5, 10);

  carArr.add(new Car(carArr.size()+1, path, direction));
  for (Car car : carArr) {
    car.start();
  }
}

void draw() {
  background(img);
  drawTrafficLight();
  timer.countdown();

  if (mousePressed) {
    System.out.printf("mouseX: %d, mouseY: %d", mouseX, mouseY);
    System.out.println();
    //intersection.getSecCarCount("left", "right");
  }

  for (int i = 0; i < carArr.size(); i ++) {
    Car car = carArr.get(i);
    if (car.alive()) {
      car.go();
    } else {
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
    Car addCar = new Car(carArr.size()+1, path, direction);
    addCar.start();
    carArr.add(addCar);
  }

  if (count < 10) {
    if (millis() - lastAdd > 1500) {
      Car addCar = new Car(carArr.size()+1, path, direction);
      addCar.start();
      carArr.add(addCar);
      count++;
      lastAdd = millis();
    }
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
  //down-righy
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
