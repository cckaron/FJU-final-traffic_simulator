import java.util.Map;
import java.util.LinkedList;

ArrayList<Car> carArr = new ArrayList<Car>();
Intersection intersection;
TimeControl timer;

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
  
  timer = new TimeControl(30, 90);

  carArr.add(new Car(path, direction));
  for (Car car : carArr) {
    car.start();
  }
}

void draw() {
  background(img);
  timer.countdown();

  if (mousePressed) {
    //System.out.printf("mouseX: %d, mouseY: %d", mouseX, mouseY);
    //System.out.println();
    intersection.getSecCarCount("left", "right");
  }

  for (int i = 0; i < carArr.size(); i ++) {
    Car car = carArr.get(i);
    if (car.alive()) {
      car.go();
    } else {
      carArr.remove(i);
    }
  }

  //keyboard
  //if (keyPressed == true){
  //  if (key == 'a'){
  //    carArr.add(new Car(axis, direction));
  //  }
  //}
  if (press_a) {
    Car addCar = new Car(path, direction);
    addCar.start();
    carArr.add(addCar);
  }

  if (count < 10) {
    if (millis() - lastAdd > 800) {
      Car addCar = new Car(path, direction);
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
