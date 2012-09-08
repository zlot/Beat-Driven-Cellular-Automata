import controlP5.*;
import beads.*;

CA ca;
BeatDetection beatAnalyser;
ControlP5 cP5;
Bang b; // used to change colour of button to visualise beats

final boolean WRAP_AROUND = false; //wrap the CA horizontally
color caColor;
color bgColor; // = color(0,0,225); nice blue color!! like Commodore64

void setup() {
  size(400,900);
  colorMode(HSB,360,100,100);
  bgColor = color(0,0,225);
  background(bgColor);
  frameRate(160); // 80 is best
  caColor = color(180,100,71); // aqua
  fill(caColor);
  noStroke();
  beatAnalyser = new BeatDetection();
  initControlP5();
  ca = new CA();
  ca.inputRule(97); // best rules: 225, 30, 99, 97?
  addColors();
}

void draw() {  
  ca.update();
  beatAnalyser.updateBeatVis();
  // hooking into the bangBrightness easing. Don't let it go below 30fps though, 
  // still need it moving even when there's no beats.
  frameRate((beatAnalyser.bangBrightness <= 30)? 30 : beatAnalyser.bangBrightness*2);
}

boolean paused = false;

void mouseClicked() {
  ca.randomRuleset();
}
void keyPressed() {
  if(key == ' ') {
    if(paused) {
      ca.update();
      paused = !paused;
    } else {
      ca.pause();
    }
  }  
}

ArrayList niceColors = new ArrayList<Integer>();
void addColors() {
  niceColors.add(color(0,0,225));
  niceColors.add(color(23,9,92));
  niceColors.add(color(23,9,92));
  niceColors.add(color(192,4,16));
  niceColors.add(color(178,70,97));
  niceColors.add(color(339,36,87));
  niceColors.add(color(106,10,89));
  niceColors.add(color(2,50,92));
  niceColors.add(color(57,25,86));
  niceColors.add(color(9,53,92));
}


