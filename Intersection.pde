class Intersection extends Thread {
  HashMap<String, Section> sec = new HashMap<String, Section>();

  Intersection() {
    initSection();
  }

  void start() {
    println("Intersection Start!");
    super.start();
  }

  int[] getSecCarCount(String sec1, String sec2) {
    int sec1_counter = 0;
    int sec2_counter = 0;

    Section section1 = sec.get(sec1);
    Section section2 = sec.get(sec2);

    for (Car car : carArr) {
      if (section1.inSection(car)) {
        //this car is in section1
        sec1_counter ++;
      } else if (section2.inSection(car)) {
        //this car is in section2
        sec2_counter ++;
      } else {
        //not in section
      }
    }

    //System.out.printf("car(sec1, sec2): (%d, %d)", sec1_counter, sec2_counter);
    //System.out.println();
    int[] ans = {sec1_counter, sec2_counter};
    
    showCarInfo(ans);
    return ans;
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
    down_left_x = 270;
    down_left_y = 660;
    down_right_x = 760;
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

    for (Map.Entry sec : sec.entrySet()) {
      Section section = (Section)sec.getValue();
      section.start();
    }
  }
  
  void showCarInfo(int[] count){
    fill(0);
    textSize(30);
    text("Left Section Car:"+count[0], 750, 500);
    text("Right Section Car:"+count[1], 750, 550);
  }
}
