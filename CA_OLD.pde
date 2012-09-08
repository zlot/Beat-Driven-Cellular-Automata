class CA_OLD {
  
  
  //hold grid
  
  //hold rules
  int[][] rules = new int[256][8];
  
  
  /*****CONSTRUCTOR*****/
  CA_OLD() {
    createRules();
    
  }
  

  
  void createRules() {
  //create all of wolframs rules
  //2^8

    int n = rules[0].length; // get amount of defined states per rule
    int ruleIndex = 0; // will be used to fill all 256 rules with defined states as per Wolfram. http://mathworld.wolfram.com/ElementaryCellularAutomaton.html
  
// // while(ruleIndex < rules.length) {
// for(int a=n-1; a>=0; a--) {
//    for(int i=n-1; i>=0; i--) {
//      for(int k=a; k<n; k++) { // controls the 1's to be filled out on the right side of the binary (0 0 0 0 0 0 0 1) <<
//        rules[ruleIndex][k] = 1;
//      }
//      
//      rules[ruleIndex][i] = 1;
//      print(ruleIndex + " ");
//      ruleIndex++;
      
  //    for(int j=i-1; j>=0; j--) {
  //      rules[ruleIndex][j] = 1;
  //      print(ruleIndex + " ");
  //      ruleIndex++;
  //    }
  
//    }
//   }
 // }
 
    for(int i=0; i<n; i++) {
      for(int j=n-1-i; j>=0; j--) {
        rules[ruleIndex][j] = 1;
        print(ruleIndex + " ");
        ruleIndex++;
      } 
    }
  }
  
  
  void printTest() {
    println();
    int totalRules = 0;
    for(int i=0; i<256; i++) {
      for(int j=0;j<8;j++) {
        print(rules[i][j] + " ");
      }
      println();
      totalRules++;
    }
    println("total: " + totalRules);
  }
  
}
