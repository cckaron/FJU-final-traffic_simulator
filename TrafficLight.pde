class TrafficLight extends Thread {
  String l_color;
  TrafficLight(String clr) {
    l_color = clr;
  }

  void start() {
    println("Traffic Light Start!");
    super.start();
  }
}
