class Car extends Thread {
  int id;
  PImage img;
  float x;
  float y;
  int direct;
  float[] startPos = new float [2];
  float[] nextPos = new float [2];
  float speed = 5;
  boolean live;
  LinkedList<float[]> pathST=new LinkedList<float[]>();
  LinkedList<Integer> directST=new LinkedList<Integer>();

  Car (int _id, float[][] axis, int dir[]) {
    img = loadImage("image/dot.png");
    live = true;
    id = _id;

    //add axises to queue
    for (int i=0; i<axis.length; i++) {
      if (i==0) {
        x = axis[i][0];
        y = axis[i][1];
        direct = dir[0];
      }
      pathST.add(axis[i]);
    }

    //add directions to queue
    for (int j=0; j<dir.length; j++) {
      directST.add(dir[j]);
    }

    pathST.remove();
    directST.remove();
  }

  void start() {
    nextPos = pathST.remove();
    super.start();
  }

  void show() {
    image(this.img, this.x, this.y, 50, 50);
  }

  void go() {
    followRule();
    keepDistance();
    if (x == nextPos[0] && y == nextPos[1]) {
      try {
        direct = directST.remove();
        move();
      } 
      catch (Exception e) {
      }
    } else if (x >= 1890 || x < 0 || y > 1080 || y < 0) {
      
      System.out.printf("Car %d end", id);
      
      //!!!!! important !!!!!!
      //before car died, it should be moved one more time to pretend error occur
      move();
      live = false;
    } else {
      move();
    }

    show();
  }

  void keepDistance() {
    for (Car otherCar : carArr) {
      //shouldn't compare with itself
      if (this.id != otherCar.id) {
        //go in the same direction
        if (this.direct == 4 && otherCar.direct == 4) {
          if (this.id == 3) {
            System.out.printf("(ot, this):(%f, %f)", otherCar.x, this.x);
            System.out.println();
          }

          //not safe distance should stop
          if ((otherCar.x - this.x < 90 && otherCar.x - this.x > 0) || (otherCar.y - this.y < 90 && otherCar.y - this.y > 0)) 
          {
            this.speed = 0;
          } 
          //if distance is safe, can restart
          else if (otherCar.x - this.x > 90 && otherCar.x - this.x > 0 && otherCar.x - this.x < 120|| otherCar.y - this.y > 90) { 
            //System.out.printf("(x,y):(%f, %f)", car.x - this.x, car.y - this.y);
            //System.out.println();
            this.speed = 5;
          }
        } else if (this.direct == 1 && otherCar.direct == 4) {
          if ((abs(otherCar.x - this.x) < 70) && (abs(otherCar.y - this.y) < 70)) {
            System.out.printf("car(x, y): (%f, %f)", otherCar.x, otherCar.y);
            System.out.println("");
            System.out.printf("this(x, y): (%f, %f)", this.x, this.y);
            System.out.println("");
            this.speed = 0;
          }
        } else if (this.direct == 1 && otherCar.direct == 1) {
          if ((otherCar.x - this.x == 0) && (this.y - otherCar.y < 90 && this.y - otherCar.y > 0)) {
            //System.out.printf("x range: %f, y range: %f", car.x- this.x, car.y - this.y);
            //System.out.println("");
            this.speed = 0;
          }
        }
      }
    }
  }


  void move() {
    switch(direct) {
    case 1:
      y -= speed;
      break;
    case 2:
      y += speed;
      break;
    case 3:
      x -= speed;
      break;
    case 4:
      x += speed;
      break;
    }
  }

  boolean alive() {
    return this.live;
  }

  void followRule() {
    if (x == 700 && y == 580 && direct == 4 && simulator.timer.now_direct == 2) {
      //System.out.println("stop");
      this.speed = 0;
    } else if (x == 700 && y == 580 && direct == 4 && simulator.timer.now_direct == 1) {
      this.speed = 5;
    }
  }
}
