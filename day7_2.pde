import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;
color c;

int tileCount = 80;
int actRandomSeed = 0;

void setup() {
  size(960, 600);
}


void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  background(0);
  smooth();
  noFill();
  noStroke();

  randomSeed(actRandomSeed);
  translate(-width/2, width - 150);
  rotate(-PI/2);

  for (int gridY=0; gridY<width / 2; gridY+=random(1.5, 2.5)) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      
      int posX = width/tileCount*gridX;
      int posY = height/tileCount*gridY;

      int toggle = (int) random(0,7);
      
      c = color(posX / 2, gridY / 4, tileCount / (gridX + 1));
      if (toggle == 0 || toggle == 4 || toggle == 7) {
        fill(c);
        ellipse(posX, posY, posX+width/tileCount, posY+width/tileCount*2);
        rotate(-PI/2);
      }
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
  if (key == 'h' || key == 'H') saveHiRes(3);
}

void saveHiRes(int scaleFactor) {
  PGraphics hires = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);
  beginRecord(hires);
  hires.scale(scaleFactor);
  draw();
  endRecord();
  hires.save("hires" + timestamp() + ".png");
  println("hires saved");
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
