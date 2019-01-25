import java.util.Collection;
import javax.sound.midi.*;

AMidiPlayer midiPlayer;


// array that stores note velocities
int[] myNotes = new int[128];
float step = 0;
float stepwidth = 2;
int moveback = 0;


void setup() {
  size(1600, 1000);
  background(0);
  smooth();
  
  midiPlayer = new AMidiPlayer();
  midiPlayer.load(dataPath("evo.mid"));
  midiPlayer.start();
  
  //fastforward through the sequence
  midiPlayer.setBPM(5800);
  println("BPM IS: "+midiPlayer.getBPM());
  
  textSize(20);
}

void draw() {
 
  // read actual notelist
  myNotes = midiPlayer.NoteList();
      
  //pushMatrix();
  //translate(moveback,0);

  for (int i = 0; i < myNotes.length; i++) {
    float col = myNotes[i];
    float y = map(i, 0, 127, height-10, 10 );
    
     if(col > 0){
      col = map(col, 0, 127, 50, 255);   
     }
     else {
       col = 0;
     }
     
      noStroke();
      fill(col);
      rect(step, y, stepwidth, 10);

  }
  
  step += stepwidth;
 
  // clean status bar
  fill(0);
  rect(0,0,width,60);
  
  // status bar
  fill(200);
  rect(0,0,step,20);
  
 
  float counter = map(step,0, width, 0, 7000);
  
  if(counter <= 7000)text("training iterations: "+int(counter), 10,50);
  else text("training iterations: "+7000, 10,50);


 
  //popMatrix();
//  if (step % width == 0) {
//    //clear screen very rudimentary :)
//    background(0)
    
//    //push matrix back as soon as stepper hits width;
//     moveback-= width;

//  }
  
  


}
