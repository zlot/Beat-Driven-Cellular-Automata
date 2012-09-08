void initControlP5() {
  cP5 = new ControlP5(this);
  cP5.addSlider("beat_threshold",0f,1f,0.2f,10,10,100,14);
  cP5.addSlider("beat_alpha",0.9f,1f,0.98f,10,10+14+10,100,14);
  cP5.addBang("beat_vis", 10, 10+14+10+14+10, 14, 14);
  b = (Bang) cP5.controller("beat_vis");
}

public void beat_threshold(float value) {
  beatAnalyser.setThreshold(value);
}

public void beat_alpha(float value) {
  beatAnalyser.setAlpha(value);
}
