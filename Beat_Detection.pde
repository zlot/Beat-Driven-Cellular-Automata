// Modified version of Beat Detection example
// from Evan X. Merz's book Sonifying Processing: The Beads Tutorial.
// http://www.computermusicblog.com/SonifyingProcessing/Sonifying_Processing_The_Beads_Tutorial.pdf
// Also credit to Beads creator, Ollie Bown.

class BeatDetection {
  private AudioContext ac;
  private PeakDetector beatDetector;
  private Gain g;
  float vol = 1; // volume of song. From 0 to 1
  int bangBrightness = 80;
  
  /*****CONSTRUCTOR*****/
  BeatDetection() {
    // set up the AudioContext and the master Gain object
    ac = new AudioContext();
    g = new Gain(ac, 2, vol);
    ac.out.addInput(g);
    inputSong();
    analyseSong();
  }
  void inputSong() {
    SamplePlayer player = null;
    try {
      // load up a new SamplePlayer using an included audio file
      player = new SamplePlayer(ac, new Sample(selectInput()));
      g.addInput(player); // connect SamplePlayer to master Gain (plays the song)
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  void analyseSong() {
    // Set up the ShortFrameSegmenter. This class allows us to
    // break an audio stream into discrete chunks.
    ShortFrameSegmenter sfs = new ShortFrameSegmenter(ac);
    sfs.setChunkSize(2048); // how large each chunk is.
    sfs.setHopSize(441);
    // connect the sfs to the AudioContext
    sfs.addInput(ac.out);
    FFT fft = new FFT();
    PowerSpectrum ps = new PowerSpectrum();
    sfs.addListener(fft);
    fft.addListener(ps);
    // The SpectralDifference unit generator does exactly what
    // it sounds like. It calculates the difference between two
    // consecutive spectrums returned by an FFT (through a
    // PowerSpectrum object).
    SpectralDifference sd = new SpectralDifference(ac.getSampleRate());
    ps.addListener(sd);
    beatDetector = new PeakDetector(); //PeakDetector object finds beats
    sd.addListener(beatDetector);
    // the threshold is the gain level that will trigger the beat detector
    beatDetector.setThreshold(0.2f);
    beatDetector.setAlpha(.98f);
    beatDetector.addMessageListener(new Bead() {
      protected void messageReceived(Bead b) {
         beatAnalyser.bang();
      }
    });
    // tell the AudioContext that it needs to update the ShortFrameSegmenter
    ac.out.addDependent(sfs);
    // start working with audio data
    ac.start();
  }
  
  void bang() { // beat found
    ca.randomRuleset(); println("bang!");
    bangBrightness = 80;
    b.setColorForeground(color(360,80,bangBrightness));
  }
  void updateBeatVis() {
    beatAnalyser.bangBrightness = (beatAnalyser.bangBrightness == 0) ? 0 : beatAnalyser.bangBrightness-1;
    b.setColorForeground(color(360,80,beatAnalyser.bangBrightness-1));
  }
  void setThreshold(float t) {
    beatDetector.setThreshold(t);
  }
  void setAlpha(float a) {
    beatDetector.setAlpha(a);
  }
}

