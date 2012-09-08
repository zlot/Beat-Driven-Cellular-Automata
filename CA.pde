class CA {
  

  int[] cells; // grid that holds the 1D cells of a generation.
  float scl = 1; // scale-size of the ca's. will be used when drawing the cells.
  int ruleset[] = new int[8]; // current ruleset being used.
  int generation = 0; //current generation. relates to y-axis when drawn to screen.
  
  /*****CONSTRUCTOR*****/
  CA() {
    // new array of width. This is 1dimensional!
    cells = new int[round(width/scl)];
    cells[cells.length/2] = 1;    
    inputRule(30);
  }  
  
  void inputRule(int r) {
    for(int i=0;i<ruleset.length;i++) ruleset[i] = 0; // force all values to 0.
    cells[cells.length/2] = 1;
    if(r > 255 || r < -255) {
      println("sorry, rules go up to 255 only! Generating rule 30 instead.");
      inputRule(30);
    } else {    
      String rs = Integer.toBinaryString(abs(r)); // generate the ruleset. http://mathworld.wolfram.com/ElementaryCellularAutomaton.html
      int ruleIndex = ruleset.length-1;
      for(int i=rs.length()-1; i>=0; i--) {
        ruleset[ruleIndex] = Character.getNumericValue(rs.charAt(i));
        ruleIndex--;
      }
      print("using rule " + r + ": "); for(int i=0; i<ruleset.length; i++) print(ruleset[i] + " ");
    }
  }
  
  void update() {
    if(!paused) {
      int[] nextGen = new int[cells.length];
      // for all current cells, apply rules and place in nextGen[].
      // ignore first cell and last as they don't have full neighbours.
      for(int i=1; i<cells.length-1; i++) {
        int leftOfCell = cells[i-1];
        int cell = cells[i];
        int rightOfCell = cells[i+1];
        nextGen[i] = checkRules(leftOfCell, cell, rightOfCell);
      }
      draw();
      cells = (int[]) nextGen.clone();
      
      generation++;
      if(generation % height == 0) {
        generation = 0;
        background(255);
      }
    }
  }
  void pause() {
    paused = !paused;
  }
  
  void draw() {
    // for all cells in the generation, draw if active.
    for(int i=0; i<cells.length; i++) {
      if(cells[i] == 1) rect(i*scl, generation*scl, scl,scl); //only draw the cell if its state is on
    }
  }
  
  int checkRules(int leftOfCell, int cell, int rightOfCell) {
    // see here for details: http://mathworld.wolfram.com/ElementaryCellularAutomaton.html
    if(leftOfCell==1 && cell == 1 && rightOfCell==1) return ruleset[0];
    if(leftOfCell==1 && cell == 1 && rightOfCell==0) return ruleset[1];
    if(leftOfCell==1 && cell == 0 && rightOfCell==1) return ruleset[2];
    if(leftOfCell==1 && cell == 0 && rightOfCell==0) return ruleset[3];
    if(leftOfCell==0 && cell == 1 && rightOfCell==1) return ruleset[4];
    if(leftOfCell==0 && cell == 1 && rightOfCell==0) return ruleset[5];
    if(leftOfCell==0 && cell == 0 && rightOfCell==1) return ruleset[6];
    if(leftOfCell==0 && cell == 0 && rightOfCell==0) return ruleset[7];
    return 0; //wont ever get here.
  }
    
}
