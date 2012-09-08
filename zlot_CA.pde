
CA ca;

void setup() {
  size(400,900);
  background(235);
  frameRate(60);
  fill(0);
  noStroke();
  ca = new CA();
  ca.inputRule(57); // best rules: 255, 30
}


void draw() {  
  ca.update();
}


boolean paused = false;
void mouseClicked() {
  if(paused) {
    ca.update();
    paused = !paused;
  } else {
    ca.pause();
  }
   
  
  
  
}
