class TrafficLight extends Thread {
  HashMap<String, Section> sec = new HashMap<String, Section>();

  TrafficLight() {
    initSection();
  }
  
  void start() {
    System.out.println("Traffic Light Start!");
    super.start();
  }

  int getSecCarCount(String sec1, String sec2) {
    Section section1 = sec.get(sec1);
    Section section2 = sec.get(sec2);

    for (Car car : carArr) {
      if (section1.inSection(car)) {
        //this car is in section1
      } else if (section2.inSection(car)) {
        //this car is in section2
      } else {
        //not in section
      }
    }
    return 1;
  }

  void initSection() {
    float up_left_x, up_left_y, up_right_x, up_right_y;
    float down_left_x, down_left_y, down_right_x, down_right_y;

    //up section
    up_left_x = 760;
    up_left_y = 10;
    up_right_x = 870;
    up_right_y = 10;
    down_left_x = 760;
    down_left_y = 410;
    down_right_x = 870;
    down_right_y = 410;
    sec.put("up", new Section("up", up_left_x, up_left_y, up_right_x, up_right_y, down_left_x, down_left_y, down_right_x, down_right_y));

    //down section
    up_left_x = 900;
    up_left_y = 1070;
    up_right_x = 1000;
    up_right_y = 670;
    down_left_x = 890;
    down_left_y = 670;
    down_right_x = 1000;
    down_right_y = 1070;
    sec.put("down", new Section("down", up_left_x, up_left_y, up_right_x, up_right_y, down_left_x, down_left_y, down_right_x, down_right_y));

    //left section
    up_left_x = 270;
    up_left_y = 550;
    up_right_x = 760;
    up_right_y = 550;
    down_left_x = 760;
    down_left_y = 660;
    down_right_x = 270;
    down_right_y = 660;
    sec.put("left", new Section("left", up_left_x, up_left_y, up_right_x, up_right_y, down_left_x, down_left_y, down_right_x, down_right_y));

    //right section
    up_left_x = 1000;
    up_left_y = 420;
    up_right_x = 1470;
    up_right_y = 420;
    down_left_x = 1000;
    down_left_y = 530;
    down_right_x = 1470;
    down_right_y = 530;
    sec.put("right", new Section("right", up_left_x, up_left_y, up_right_x, up_right_y, down_left_x, down_left_y, down_right_x, down_right_y));
  }
}
