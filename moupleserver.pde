import java.awt.*;
import java.awt.event.*;
import processing.net.*;

Robot robot;
Point save_p;
Server server;

int value = 0;

void setup() {
  try {
    robot = new Robot();
    robot.setAutoDelay(0);
    server = new Server(this, 8080);
    println("start server at address: " + Server.ip());
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  fill(value);
  rect(25, 25, 100, 100);
  fill(255);
  
  Client c = server.available();
  if (c != null) {
    Point p = MouseInfo.getPointerInfo().getLocation();
    String str = p.getX() + "," + p.getY() + "\n";
    c.write(str);

    String d = c.readStringUntil('\n');
    if (d == null) return;
    println("received:" + d);
    String s = d.trim();
    String [] data = s.split(",");
    double x = parseFloat(data[0]);
    double y = parseFloat(data[1]);
    text("" + x + y, 30, 50);
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