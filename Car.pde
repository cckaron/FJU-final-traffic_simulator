import java.util.LinkedList;

class Car extends Thread {
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

  Car (float[][] axis, int dir[]) {
    img = loadImage("image/dot.png");
    live = true;

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
    if (x == 700 && y == 580) {
      this.speed = 0;
    }
    keepDistance();
    if (x == nextPos[0] && y == nextPos[1]) {
      try {
        direct = directST.remove();
        move();
      } 
      catch (Exception e) {
      }
    } else if (x >= 1920 || x < 0 || y > 1080 || y < 0) {
      live = false;
    } else {
      move();
    }

    show();
  }

  void keepDistance() {
    for (Car car : carArr) {
      if (this.direct == 4 && car.direct == 4) {
        if ((car.x - this.x < 90 && car.x - this.x > 0) || (car.y - this.y < 90 && car.y - this.y > 0)) {
          //System.out.printf("x range: %f, y range: %f", car.x- this.x, car.y - this.y);
          //System.out.println("");
          this.speed = 0;
        }
      } else if (this.direct == 1 && car.direct == 4) {
        if ((abs(car.x - this.x) < 60) && (abs(car.y - this.y) < 60)) {
          System.out.printf("car(x, y): (%f, %f)", car.x, car.y);
          System.out.println("");
          System.out.printf("this(x, y): (%f, %f)", this.x, this.y);
          System.out.println("");
          this.speed = 0;
        }
      } else if (this.direct == 1 && car.direct == 1) {
        if ((car.x - this.x == 0) && (this.y - car.y < 90 && this.y - car.y > 0)) {
          //System.out.printf("x range: %f, y range: %f", car.x- this.x, car.y - this.y);
          //System.out.println("");
          this.speed = 0;
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
}
