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
        //start point
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
    if (safe()) {
      move();
    }

    //meet destination
    if (x == nextPos[0] && y == nextPos[1]) {
      try {
        if (pathST.size() == 0) {
          //!!!!! important !!!!!!
          //before car died, it should be moved one more time to pretend error occur
          move();

          live = false;
          System.out.printf("Car %d end", id);
        }
        nextPos = pathST.remove();
        direct = directST.remove();
        //move();
      } 
      catch (Exception e) {
      }
    }

    show();
  }

  boolean safe() {
    for (Car otherCar : carArr) {
      //compare the distance with other car
      //shouldn't compare with itself
      if (otherCar != this) {

        //two car go in the same direction
        if (direct1NotSafe(otherCar)) {
          return false;
        };
        if (direct2NotSafe(otherCar)) {
          return false;
        };
        if (direct3NotSafe(otherCar)) {
          return false;
        };
        if (direct4NotSafe(otherCar)) {
          return false;
        };

        //two car in the corner
        //turn right from bottom
        if (turnRightFromBottom(otherCar)) {
          return false;
        };
        if (turnRightFromTop(otherCar)) {
          return false;
        };
      }
    }
    return true;
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
    //section
    if (x == 700 && y == 580 && direct == 4 && timer.now_direct == 2) {
      this.speed = 0;
    } else if (x == 700 && y == 580 && direct == 4 && timer.now_direct == 1) {
      this.speed = 5;
    }

    if (x == 1025 && y == 450 && direct == 3 && timer.now_direct == 2) {
      //System.out.println("stop");
      this.speed = 0;
    } else if (x == 1025 && y == 450 && direct == 3 && timer.now_direct == 1) {
      this.speed = 5;
    }
  }

  boolean direct1NotSafe(Car otherCar) {
    //go in the same direction
    if (this.direct == 1 && otherCar.direct == 1) 
    {
      //compare distance with the front car, stop when not safe
      // you are in front of me.
      if ((this.y - otherCar.y < 90 && this.y - otherCar.y > 0)) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (this.y - otherCar.y > 90 && this.y - otherCar.y < 120) { 
        this.speed = 5;
        return false;
      }
    }
    return false;
  }
  
    boolean direct2NotSafe(Car otherCar) {
    //go in the same direction
    if (this.direct == 2 && otherCar.direct == 2) 
    {
      //compare distance with the front car, stop when not safe
      // you are in front of me.
      if ((otherCar.y - this.y < 90 && otherCar.y - this.y > 0)) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (otherCar.y - this.y > 90 && otherCar.y - this.y < 120) { 
        this.speed = 5;
        return false;
      }
    }
    return false;
  }

  boolean direct3NotSafe(Car otherCar) {
    if (this.direct == 3 && otherCar.direct == 3) {
      //compare distance with the front car, stop when not safe
      // you are in front of me.
      if ((this.x - otherCar.x < 90 && this.x - otherCar.x > 0)) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (this.x - otherCar.x > 90 && this.x - otherCar.x < 120) { 
        this.speed = 5;
        return false;
      }
    }
    return false;
  }
  
  boolean direct4NotSafe(Car otherCar) {
    if (this.direct == 4 && otherCar.direct == 4) {
      //compare distance with the front car, stop when not safe
      // you are in front of me.
      if (otherCar.x - this.x < 90 && otherCar.x - this.x > 50) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (otherCar.x - this.x > 120 && otherCar.x - this.x < 150) { 
        this.speed = 5;
        return false;
      }
    }
    return false;
  }

  boolean turnRightFromBottom(Car otherCar) {
    if (this.direct == 1 && otherCar.direct == 4) 
    {
      if ((abs(otherCar.x - this.x) < 70) && (abs(otherCar.y - this.y) < 70)) {
        this.speed = 0;
        return true;
      } else if (abs(otherCar.x - this.x) > 70) {
        this.speed = 5;
      }
    }
    return false;
  }
  
  boolean turnRightFromTop(Car otherCar) {
    if (this.direct == 2 && otherCar.direct == 3) 
    {
      if ((abs(otherCar.x - this.x) < 70) && (abs(otherCar.y - this.y) < 70)) {
        this.speed = 0;
        return true;
      } else if (abs(otherCar.x - this.x) > 70) {
        this.speed = 5;
      }
    }
    return false;
  }
}
