class Car extends Thread {
  int id;
  int goParam = 120;
  int turnParam = 70;
  PImage img;
  PImage up;
  PImage down;
  PImage left;
  PImage right;
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
    up = loadImage("image/car-up.jpg");
    down = loadImage("image/car-down.jpg");
    left = loadImage("image/car-left.jpg");
    right = loadImage("image/car-right.jpg");
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
    switch (direct) {
    case 1:
      image(this.up, this.x, this.y, 44, 90);
      break;
    case 2:
      image(this.down, this.x, this.y, 44, 90);
      break;
    case 3:
      image(this.left, this.x, this.y, 90, 46);
      break;
    case 4:
      image(this.right, this.x, this.y, 90, 46);
      break;
    }
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
        } else {
          nextPos = pathST.remove();
          direct = directST.remove();
        }
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
        //if (turnLeftFromBottom(otherCar)) {
        //  return false;
        //};

        if (turnRightFromBottom(otherCar)) {
          return false;
        };

        //if (turnLeftFromTop(otherCar)) {
        //  return false;
        //};

        if (turnRightFromTop(otherCar)) {
          return false;
        };

        //if (turnLeftFromLeft(otherCar)) {
        //  return false;
        //};

        //if (turnRightFromLeft(otherCar)) {
        //  return false;
        //};

        //if (turnLeftFromRight(otherCar)) {
        //  return false;
        //};

        //if (turnRightFromRight(otherCar)) {
        //  return false;
        //};
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
      if ((this.y - otherCar.y < goParam && this.y - otherCar.y > 0)) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (this.y - otherCar.y > goParam && this.y - otherCar.y < goParam+10) { 
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
      if ((otherCar.y - this.y < goParam && otherCar.y - this.y > 0)) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (otherCar.y - this.y > goParam && otherCar.y - this.y < goParam+10) { 
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
      if ((this.x - otherCar.x < goParam && this.x - otherCar.x > 0)) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (this.x - otherCar.x > goParam && this.x - otherCar.x < goParam+10) { 
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
      if (otherCar.x - this.x < goParam && otherCar.x - this.x > 0) 
      {
        this.speed = 0;
        return true;
      } 
      //you leave me, and I will trace you.
      else if (otherCar.x - this.x > goParam && otherCar.x - this.x < goParam + 10) { 
        this.speed = 5;
        return false;
      }
    }
    return false;
  }

  boolean turnRightFromBottom(Car otherCar) {
    if (this.direct == 1 && otherCar.direct == 4) 
    {
      if ((this.y - otherCar.y  < turnParam && this.y - otherCar.y > 0) && (otherCar.x - this.x < turnParam && otherCar.x - this.x > 0)) {
        this.speed = 0;
        return true;
      } else if (otherCar.x - this.x > turnParam && otherCar.x - this.x < turnParam + 10) {
        this.speed = 5;
      }
    }
    return false;
  }

  boolean turnLeftFromBottom(Car otherCar) {
    if (this.direct == 1 && otherCar.direct == 3) 
    {
      if ((this.y - otherCar.y < turnParam) && (this.x - otherCar.x < turnParam && this.x - otherCar.x > 0)) {
        this.speed = 0;
        return true;
      } else if (this.x - otherCar.x > turnParam) {
        this.speed = 5;
      }
    }
    return false;
  }

  boolean turnLeftFromTop(Car otherCar) {
    if (this.direct == 2 && otherCar.direct == 4) 
    {
      if ((otherCar.y - this.y < turnParam) && (otherCar.x - this.x < turnParam && otherCar.x - this.x > 0)) {
        this.speed = 0;
        return true;
      } else if (otherCar.x - this.x > turnParam) {
        this.speed = 5;
      }
    }
    return false;
  }

  boolean turnRightFromTop(Car otherCar) {
    if (this.direct == 2 && otherCar.direct == 3) 
      if ((otherCar.y - this.y  < turnParam && otherCar.y - this.y > 0) && (this.x - otherCar.x < turnParam && this.x - otherCar.x > 0)) {
        this.speed = 0;
        return true;
      } else if (this.x - otherCar.x > turnParam && this.x - otherCar.x < turnParam + 10) {
        this.speed = 5;
        print("yes");
      }
    return false;
  }

  boolean turnLeftFromRight(Car otherCar) {
    if (this.direct == 3 && otherCar.direct == 2) 
    {
      if ((this.x - otherCar.x < turnParam) && (otherCar.y - this.y < turnParam && otherCar.y - this.y > 0)) {
        this.speed = 0;
        return true;
      } else if (otherCar.y - this.y > turnParam) {
        this.speed = 5;
      }
    }
    return false;
  }

  boolean turnRightFromRight(Car otherCar) {
    if (this.direct == 3 && otherCar.direct == 1) 
    {
      if ((this.x - otherCar.x < turnParam) && (this.y - otherCar.y < turnParam && this.y - otherCar.y > 0)) {
        this.speed = 0;
        return true;
      } else if (this.y - otherCar.y > turnParam) {
        this.speed = 5;
      }
    }
    return false;
  }

  boolean turnRightFromLeft(Car otherCar) {
    if (this.direct == 4 && otherCar.direct == 1) 
    {
      if ((otherCar.x - this.x < turnParam) && (otherCar.y - this.y < turnParam && otherCar.y - this.y > 0)) {
        this.speed = 0;
        return true;
      } else if (this.y - otherCar.y > turnParam) {
        this.speed = 5;
      }
    }
    return false;
  }

  boolean turnLeftFromLeft(Car otherCar) {
    if (this.direct == 4 && otherCar.direct == 1) 
    {
      if ((otherCar.x - this.x < turnParam) && (this.y - otherCar.y > 0)) {
        this.speed = 0;
        return true;
      } else if (this.y - otherCar.y > turnParam) {
        this.speed = 5;
      }
    }
    return false;
  }
}
