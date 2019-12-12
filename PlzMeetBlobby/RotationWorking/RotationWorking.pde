import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import processing.serial.*;
int randomColor;
int screen = 1;
int round = 0;
int size =0;
//int sizeh =0;
int beginGame = 0;
int free = 0;
int currentTime = 0;
boolean GameOver = false;
int NumberOfBlobbies = 60;


int GameBegin = 0;

Box2DProcessing box2d;

Serial myPort;
int[] serialInArray = new int[4];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
float Xrotation, Yrotation, Zrotation, pushButton;                // Starting position of the ball
boolean firstContact = false;        // Whether we've heard from the microcontroller
float angleX =0;
float angleY =0;
float angleZ =0;
boolean start;
PImage eyes_open;
PImage eyes_closed;
//PImage NYUADimg;
PImage eyes_angry ;
int timer = 30000;
int startTime;

boolean flag = true;

ArrayList<Blobby> boxes;
//Blobby character;
Boundary OuterBoundary;
Box wall;
void setup() {
  pushButton = 0;
  eyes_open = loadImage("black.png");
  eyes_closed = loadImage("untitled.png");

  fullScreen();
  //size(600, 600);
  String portName = "COM6";
  //String portName = Serial.list()[1];
  //println(Serial.list());
  myPort = new Serial(this, portName, 9600);
  myPort.buffer(4);
  boxes = new ArrayList<Blobby>();
  //character = 
  box2d = new Box2DProcessing(this);
  box2d.createWorld(); 
  wall = new Box();
  //character =new Blobby(width/2, height/2 - 50); //display blobby at width/2 and height/2
  OuterBoundary = new Boundary();
}



void reset() {
  for (Blobby delete : boxes) {
    box2d.destroyBody(delete.body);
    //if (round ==3) {
    //  screen = 3;
    //}
    //screen = 2;
    flag = true;
  }
  boxes.clear();
  startTime = millis();
  t = 30;
}

void keyPressed() {

  if (key == ' ') {
    if (screen == 1 && GameBegin !=0) {
      screen = 4;
    }
    if (screen ==3 || screen ==6) {
      screen = 1;
    }
  }
}


void hello() {
  if (pushButton ==0.0) {
    //if (screen == 1 && GameBegin !=0) {
    //  screen = 4;
    //}
    // if (screen ==3 || screen ==6) {
    //  screen = 1;
    //}
    if (screen ==4) {

      if (round ==0) {
        fill(255);
        textSize(200);
        text("Round 1", 100, height/4);
        textSize(100);
        text("Shake the blobbies out of their boundaires!!", 100, height*2/4);
        textSize(100);
        text("Tap the bottom of the box to start", 100, height*3/4);
        //delay(2000);
        //print("delay is happening");
        screen = 2;

        beginGame = 1;
        reset();
      } else  if (round ==1) {

        fill(255);
        textSize(200);
        text("Round 2", 100, height/4);
        textSize(100);
        text("Bigger Blobbies, shake harder", 100, height*2/4);
        textSize(100);
        text("Tap the bottom of the box to start", 100, height*3/4);
        screen = 2;

        beginGame = 1;
        reset();
      } else  if (round ==2) {
        fill(255);
        textSize(200);
        text("Round 3", 100, height/4);
        textSize(100);
        text("Eeeeeven Bigger, KEEP SHAKING", 100, height*2/4);
        textSize(100);
        text("Tap the bottom of the box to start", 100, height*3/4);
        screen = 2;

        beginGame = 1;
        reset();
      } else {
        //println("FAIL ");
      }
      //delay(3000);
    }
  }

  if (pushButton == 1.0) {

    //if (screen ==3) {
    //  //reset();
    //} else 
    if (screen ==1 && GameBegin == 0) {
      screen = 4;
      GameBegin =GameBegin +1;
      //pushButton = 0.0;
      //screen = 2;
      //println("screen and round", screen, round);
      //beginGame = 1;
      //reset();
    }
  }
}

int t;
//String time = "010";
int interval = 10;



void draw() {

  //if (mousePressed) {
  //  //if (screen ==3 || screen ==6) {
  //  //  screen = 1;
  //  //}
  //}

  //time = nf(t,2);


  if (myPort.available() > 0) {
    //println("Available");
    serialEvent(myPort);
  }
  hello();

  background(125);

  // if (mousePressed) {


  //}



  if (screen ==4) {
    //reset(); 
    //println("round and screen", round, screen);
    if (round ==0) {
      fill(255);
      textSize(200);
      text("Round 1", 100, height/4);
      textSize(100);
      text("Break our of your boundaires!!", 100, height*2/4);
      textSize(100);
      text("Tap the bottom of the box to start", 100, height*3/4);
      //delay(2000);
      //print("delay is happening");
      // screen = 2;
      //beginGame = 1;
      //reset();
    } else  if (round ==1) {

      fill(255);
      textSize(200);
      text("Round 2", 100, height/4);
      textSize(100);
      text("It's never the walls, it's you", 100, height*2/4);
      textSize(100);
      text("Tap the bottom of the box to start", 100, height*3/4);
      //screen = 2;
    } else  if (round ==2) {
      fill(255);
      textSize(200);
      text("Round 3", 100, height/4);
      textSize(100);
      text("Keep Going", 100, height*2/4);
      textSize(100);
      text("Pick up the black box to start!", 100, height*3/4);
    } else {
      //println("FAIL ");
    }
    //delay(2000);
  }

  //if (screenOne ==1){
  //textSize();
  //To reset game

  //To begin game 
  //display the first screen
  if (screen ==1) {
    //background(0);

    fill(255);
    textSize(200);
    text("Free the blobbies!!", 100, height/2);
    if (GameBegin ==0) {
      textSize(100);
      text("Pick up the black box to start!", 100, height*3/4);
    } else {
      textSize(100);
      text("Hit the spacebar", 100, height*3/4);
    }
  } else if (screen == 2) {

    //add box2d world
    if (beginGame == 1 && screen == 2) {


      //beginGame = 0;

      if (flag == true) {

        if (round == 0) {
          size = 30;
        } else if (round ==1) {
          size = 40;
        } else if (round ==2) {
          size = 60;
        }
        //for (int i = 0; i< 99; i++) {
        Blobby p = new Blobby(width/2, (height/2), size);


        boxes.add(p);
        //println("Size", boxes.size());
        //println("Screen", screen);

        if (boxes.size() >=  NumberOfBlobbies) {
          flag = false;
        }
        //}
      }
    }
    //
    box2d.step();
    background(125);


    OuterBoundary.display();

    //display for different screens
    //fo screen 2
    if (screen ==2  ) {

      fill(255);
      textSize(1500);
      //t = interval - int(millis()/1000);
      currentTime = millis();
      //println("start and current",   currentTime - startTime);

      if ( (currentTime - startTime)  > 1000 ) {
        startTime = currentTime;
        t = t-1;
        GameOver = true;
      }


      if (t < 10) {
        text("0"+(t), 0, height );
      } else {
        text(t, 0, height );
      }
      wall.display();

      //display the blobbies
      //update the angle of the black box
      wall.updateRotation(angleX);

      for (Blobby b : boxes) {

        int pick_eyes = int(random(20));
        if (pick_eyes == 0 ) {

          b.display(eyes_open);
        } else if (pick_eyes == 1 ) { 

          b.display(eyes_closed);
        }

        b.display(eyes_open);
        if (b.checkifAngry()) {
          free = free + 1;
          //print("ugh");
        }
      }
      //if all the balls have been realeased


      //for (Blobby blobby : boxes) {
      if (free < NumberOfBlobbies && t < 0) {
        screen = 3;
      }

      if (free >=NumberOfBlobbies ) {
        if (round >=2) {
          reset();
          screen = 6;
          free = 0;
        } else {

          round = round + 1;
          //interval = interval + 30;
          screen = 4;
          reset();
          free = 0;
        }
      }
      //free = 0;
      //if (blobby.free == false) {
      //  screen =2;
      //  break;
      //} else {
      //  if (round == 3) {
      //    screen = 3;
      //  }
      //  round =+1;
      //  reset();
    }
    //}
    //for screen 3
  } 
  if (screen == 6) {
    fill(255);
    textSize(200);
    println("freed", free);
    //if (free == NumberOfBlobbies) {
    text("Congratulations!\nYou freed yourself!!!!", 400, height/4);
    round = 0;
    free = 0;
    //}
  }
  if (screen ==3) {
    //print("hello");
    fill(255);
    textSize(200);
    //println("freed", free);
    //if (free == NumberOfBlobbies) {
    //  text("You freed all the blobbies!!!!", 400, height/2);
    //} else {
    //for (Blobby blob : boxes) {
    //  blob.body.setGravityScale(10);
    //}

    //OuterBoundary.display();
    text("Game Over", 100, height/4);
    textSize(100);
    text((NumberOfBlobbies - free)+" blobbies\n have yet to be freed!!", 100, height*2/4);
    round = 0;
    free = 0;
    //}
  }
}



//}
//}


int inByte;
void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  inByte = myPort.read();
  //myPort.clear();
  //println(inByte + "is read");
  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    //println("Hello",serialCount, inByte);
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 3 ) {
      Xrotation = serialInArray[0];
      Yrotation = serialInArray[1];
      Zrotation = serialInArray[2];
      pushButton = serialInArray[3];
      //print("PushButton",int(pushButton));

      Xrotation = map(Xrotation, 0, 255, -400, 400);
      Yrotation = map(Yrotation, 0, 255, -400, 400);
      Zrotation = map(Zrotation, 0, 255, -400, 400);

      // print the values (for debugging purposes only):
      //println( Xrotation/100 + "\t" + Yrotation/100 + "\t" + Zrotation/100);
      calcAngles(Xrotation/100, Yrotation/100, Zrotation/100);
      //angleX += Xrotation;
      //angleY += Yrotation;
      //angleZ += Zrotation;

      // Send a capital A to request new sensor readings:
      myPort.clear();
      myPort.write('A');
      //delay(1000);
      //println("Ask for more");
      // Reset serialCount:
      serialCount = 0;
      //delay(50);
    }
  }
}

void calcAngles(float ax, float ay, float az) {
  float xAngle = atan( ax / (sqrt((ay*ay) + (az*az))));
  float yAngle = atan( ay / (sqrt((ax*ax) + (az*az))));
  float zAngle = atan( sqrt((ax*ax) + (ay*ay)) / az);
  //xAngle *= 180.00;   
  //yAngle *= 180.00;   
  //zAngle *= 180.00;
  //xAngle /= 3.141592; 
  //yAngle /= 3.141592; 
  //zAngle /= 3.141592;
  angleX = (xAngle + yAngle+zAngle)/3;
  //angleY = yAngle;
  //angleZ = zAngle;
}
