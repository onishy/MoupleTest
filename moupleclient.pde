
import java.awt.*;
import java.awt.event.*;
import processing.net.*;

Robot robot;
Point save_p;
Client client;

String serverAddress = "localhost";

int value = 0;

void setup() {
  try {
    robot = new Robot();
    robot.setAutoDelay(0);
    client = new Client(this, serverAddress, 8080);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}



void draw() {
  fill(value);
  rect(25, 25, 50, 50);

  Point p = MouseInfo.getPointerInfo().getLocation();
  String str = p.getX() + "," + p.getY() + "\n";
  client.write(str);
}

void clientEvent(Client c) {
  String s = c.readStringUntil('\n');
  if (s != null) {
    print("received from server: " + s);
    String[] data = s.trim().split(",");
    double x = parseFloat(data[0]);
    double y = parseFloat(data[1]);
  }
}

void mouseClicked() {
  if (value == 0) {
    value = 255;
    fill(0);
  } else {
    fill(255);
    value = 0;
  }
}