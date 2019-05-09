class TimeControl {
  HashMap<Integer, TrafficLight> trafficlight = new HashMap<Integer, TrafficLight>();
  int dir1_default_sec;
  int dir2_default_sec;
  int now_sec;
  int last_sec;
  int now_direct;

  TimeControl(int d1_sec, int d2_sec) {
    dir1_default_sec = d1_sec;
    dir2_default_sec = d2_sec;
    last_sec = millis();
    now_sec = dir1_default_sec;
    now_direct = 1;
    trafficlight.put(1, new TrafficLight("red"));
    trafficlight.put(2, new TrafficLight("red"));
    trafficlight.put(3, new TrafficLight("green"));
    trafficlight.put(4, new TrafficLight("green"));
    println("TimeControl Start!");
  }

  void countdown() {
    if (millis() - last_sec >= 1000) {
      now_sec -= 1;
      last_sec = millis();
    }
    checkDirect();
  }

  void checkDirect() {
    if (now_sec == 0) {
      if (now_direct == 1) {
        now_direct = 2;
        TrafficLight tr1 = trafficlight.get(1);
        TrafficLight tr2 = trafficlight.get(2);
        TrafficLight tr3 = trafficlight.get(3);
        TrafficLight tr4 = trafficlight.get(4);
        tr1.l_color = "green";        
        tr2.l_color = "green";        
        tr3.l_color = "red";        
        tr4.l_color = "red";
        now_sec = dir1_default_sec;
      } else {
        now_direct = 1;
        TrafficLight tr1 = trafficlight.get(1);
        TrafficLight tr2 = trafficlight.get(2);
        TrafficLight tr3 = trafficlight.get(3);
        TrafficLight tr4 = trafficlight.get(4);
        tr1.l_color = "red";        
        tr2.l_color = "red";        
        tr3.l_color = "green";        
        tr4.l_color = "green";
        now_sec = dir2_default_sec;
      }
    }
  }
}
