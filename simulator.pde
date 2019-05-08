ArrayList<Car> carArr = new ArrayList<Car>();
boolean press_a;
float[][] axis = {{10, 10}, {10, 1000}, {1000, 1000}};
int[] direction = {2, 4};

void setup() {
  size(1920, 1080);
  carArr.add(new Car(axis, direction));
  for (Car car : carArr) {
    car.start();
  }
}

void draw() {
  background(255);
  
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
    Car addCar = new Car(axis, direction);
    addCar.start();
    carArr.add(addCar);
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
