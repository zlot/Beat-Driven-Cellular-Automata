class CA {
  

  int[] cells; // grid that holds the 1D cells of a generation.
  int cLength; // length of cells array. So as to not have to compute each time.
  float scl = 1; // scale-size of the ca's. will be used when drawing the cells.
  int ruleset[] = new int[8]; // current ruleset being used.
  int generation = 0; //current generation. relates to y-axis when drawn to screen.
  
  PImage scrollingImage;
  boolean scrolling = false;
  
  /*****CONSTRUCTORS*****/
  CA() {
    // array that holds the cells. 1dimensional.
    cells = new int[round(width/scl)];
    cLength = cells.length;
    inputRule(30); // use rule30 by default. Because it's cool.
  }  
  CA(int r) {
    cells = new int[round(width/scl)];
    cLength = cells.length;
    inputRule(r);
  }
  
  void inputRule(int r) {
    for(int i=0;i<ruleset.length;i++) ruleset[i] = 0; // force all values to 0.
    initialStateSetup();
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
  private void initialStateSetup() {
    if(RANDOM_INITIAL_CONDITION) {
      // decide on a random number from 1 to width/4 (max 75% could possibly be all active. This is arbitrary!)
      int r = round(random(1,width/scl/4));
      //loop this many times and randomly assign active states
      for(int i=0;i<r;i++) cells[round(random(cLength-1))] = 1;
    } else {
      cells[cLength/2] = 1;
    }
  }
  
  void update() {
    if(!paused) {
      int[] nextGen = new int[cells.length];
      // for all current cells, apply rules and place in nextGen[].
      if(WRAP_AROUND) { // gives the first and last cells neighbours.
        nextGen[0] = checkRules(cells[cLength-1], cells[0], cells[1]);
        nextGen[cLength-1] = checkRules(cells[cLength-2], cells[cLength-1], cells[0]);
      }   
      // ignore first and last cell.
      for(int i=1; i<cLength-1; i++) {
        nextGen[i] = checkRules(cells[i-1], cells[i], cells[i+1]); // leftOfCell, cell, rightOfCell
      }
      draw();
      cells = (int[]) nextGen.clone();
      if(!scrolling) generation++;
      
      if(generation == height-1) {
        if(SCROLLING) {
          scrolling = true; // flag that from now on, we scroll!
        } else {
          generation = 0;
          if(CHANGE_COLORS) bgColor = (Integer) niceColors.get(round(random(niceColors.size()-1)));
          background(bgColor);
        }
      } 
    }
  }
  void pause() {
    paused = !paused;
  }
  
  void randomRuleset() {
    inputRule(round(random(255)));
  }
  
  
  void draw() {
    if(scrolling) {
      scrollingImage = get(0,0,width,height); // get PImage of screen
      background(bgColor); //clear bg
      set(0,-1,scrollingImage); // place back image
    }
    // for all cells in the generation, draw if active.
    for(int i=0; i<cLength; i++) {
      fill(caColor);
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
