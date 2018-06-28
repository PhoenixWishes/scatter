import java.util.*;

PImage image;
PGraphics pg;
color pix;
ArrayList<Scatterpoint> scatterpoints;
int inc, type;
int r, g, b;
float rX, rY, speed, sensitivity, size;
String setting, persp;

void setup() {
  size(1300, 900, P3D);
  type = 1;
  sensitivity = 2;
  scatterpoints = new ArrayList<Scatterpoint>();
  image=loadImage("monarch.jpg");
  setting = "fixed";
  persp = "ligh";
  if (setting == "fixed" && persp != "light") {
    size = 1.58;
  } else {
    if (setting == "fixed") {
      size = 1.5;
    } else {
      size = 1.5;
    }
  }
  if (setting == "fixed") {
    speed = 1;
  } else {
    speed = 1;
  }
  rY= 0;
  noSmooth();
  //noCursor();

  strokeWeight(1);
  background(0);

  float distance = 0;


  for (int i = 0; i < image.pixels.length; i++) {
    pix = image.pixels[inc];
    r = pix >> 16 & 0xFF;
    g = pix >> 8 & 0xFF;
    b = pix & 0xFF;
    distance = abs(r-g+b)/sqrt(3);

    scatterpoints.add(new Scatterpoint(r, g, b, distance));
    inc++;
  }
  inc = 0;
  if (persp == "light") {
    Collections.sort(scatterpoints, new Measurer());
  } else {
    Collections.sort(scatterpoints, new MeasurerG());
  }
}

void draw() {
  if (inc < image.pixels.length-1) {
    if (setting == "time") {
      background(0);
    }

    for (int i = 0; i < speed * image.width; i++) {
      if (inc > image.pixels.length-1) {
        break;
      }
      r = scatterpoints.get(inc).r;
      g = scatterpoints.get(inc).g;
      b = scatterpoints.get(inc).b;

      pushMatrix();
      setAngle();
      if (inc == 0 || setting != "fixed") {
        drawBox(1);
      }


      stroke(r, g, b);
      point(r*size, -b*size, g*size);
      // gb, rg
      popMatrix();

      inc++;
    }
    //camera(mouseX, mouseY, (height/2.0) / tan(PI*30.0 / 180.0), mouseX, mouseY, 0, 0, 1, 0);
  }
}

void drawThree() {
  pushMatrix();
  translate(mouseX, mouseY, 0);
  point(r, -b, -g);
  translate(255*size, 0);
  point(g, -b, -r);
  translate(-255*size, -255*size);
  point(r, -g, -b);
  popMatrix();
}

void drawBox(int s) {

  strokeWeight(1);
  stroke(40, 1000);

  line(0, 0, 0, 255*size, 0, 0);
  line(0, 0, 0, 0, -255*size, 0);
  line(0, -255*size, 0, 255*size, -255*size, 0);
  line(255*size, 0, 0, 255*size, -255*size, 0);

  line(0, 0, 0, 0, 0, 255*size);
  line(0, -255*size, 0, 0, -255*size, 255*size);
  line(255*size, 0, 0, 255*size, 0, 255*size);
  line(255*size, -255*size, 0, 255*size, -255*size, 255*size);

  line(0, 0, 255*size, 255*size, 0, 255*size);
  line(0, 0, 255*size, 0, -255*size, 255*size);
  line(0, -255*size, 255*size, 255*size, -255*size, 255*size);
  line(255*size, 0, 255*size, 255*size, -255*size, 255*size);
  strokeWeight(s);
}

void setAngle() {
  translate(485, 620, 0);
  translate(127.5*size, -127.5*size, 127.5*size);
  if (setting == "fixed") {
    if (persp == "light") {
      rotateX(radians(350-height/2)/(5/sensitivity));
      rotateY(radians(484-width/2)/(7/sensitivity));
      translate(-10, -30, 0);
    } else {
      translate(-28, 33, 0);
    }
  } else {
    rotateX(radians(mouseY-height/2)/(5/sensitivity));
    rotateY(radians(mouseX-width/2)/(7/sensitivity));
    translate(-10, -30, 0);
  }
  translate(-127.5*size, 127.5*size, -127.5*size);
}

void keyPressed() {
  switch(keyCode) {
  }
}

void mousePressed() {
  println(mouseX, mouseY);
  println(inc, image.pixels.length);
  println((float(inc)/image.pixels.length *100) + "% done.");
}