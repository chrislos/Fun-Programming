
// Open new array that will store actual note velcocities
int[] activeNotes = new int[128];

class AMidiPlayer implements Receiver {
  Sequencer sequencer;

  public void load(String path) {
    File midiFile = new File(path);
    try {
      sequencer = MidiSystem.getSequencer();
      if (sequencer == null) {
        println("No midi sequencer");
        exit();
      } else {
        sequencer.open();
        Transmitter transmitter = sequencer.getTransmitter();
        transmitter.setReceiver(this);
        Sequence seq = MidiSystem.getSequence(midiFile);
        sequencer.setSequence(seq);
            
      }
    } 
    catch(Exception e) {
      e.printStackTrace();
      exit();
    }
  }
  public float getBPM() {
    return sequencer.getTempoInBPM();
  }
  
  public void setBPM(float tempo) {
    sequencer.setTempoInBPM(tempo);
  }
  
  public void start() {
    
    for(int i = 0; i < activeNotes.length; i++){
    activeNotes[i]= 0;
    }

    sequencer.start();
  }
  
  // GIVE ME MY ARRAY OF NOTES!
  int[] NoteList() {
   return activeNotes;
  }
  
  // When I say "send" I mean "receive" :)
  @Override public void send(MidiMessage message, long t) {
    if (message instanceof ShortMessage) {
      ShortMessage sm = (ShortMessage) message;
      int cmd = sm.getCommand(); 

    for(int i = 0; i < activeNotes.length; i++){
    activeNotes[i]= 0;
    }

      if (cmd == ShortMessage.NOTE_ON || cmd == ShortMessage.NOTE_OFF) {
 
        int note = sm.getData1();
        int velocity = sm.getData2();

        activeNotes[note] = velocity;

      }
    }
  }

  @Override public void close() {
  }
}
