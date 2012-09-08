import controlP5.*;
import beads.*;


CA ca;
BeatDetection beatAnalyser;
ControlP5 cP5;

final boolean WRAP_AROUND = false; //wrap the CA horizontally
color caColor;
color bgColor; // = color(0,0,225); nice blue color!! like Commodore64

void setup() {
  size(400,900);
  colorMode(HSB,360,100,100);
  bgColor = color(0,0,225);
  background(bgColor);
  frameRate(80);
  caColor = color(180,100,71); // aqua
  fill(caColor);
  noStroke();
  beatAnalyser = new BeatDetection();
  initControlP5();
  ca = new CA();
  ca.inputRule(97); // best rules: 225, 30, 99, 97?
}

Bang b;

void initControlP5() {
  cP5 = new ControlP5(this);
  cP5.addSlider("beat_threshold",0f,1f,0.2f,10,10,100,14);
  cP5.addSlider("beat_alpha",0.9f,1f,0.95f,10,10+14+10,100,14);
  cP5.addBang("beat_vis", 10, 10+14+10+14+10, 14, 14);
  b = (Bang) cP5.controller("beat_vis");
  

}

void draw() {  
  ca.update();
  beatAnalyser.updateBeatVis();

}


boolean paused = false;
void mouseClicked() {
//  if(paused) {
//    ca.update();
//    paused = !paused;
//  } else {
//    ca.pause();
//  }
  ca.randomRuleset();
  
}
