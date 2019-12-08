import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import processing.serial.*;
int randomColor;
int screenOne = 1;
int screenTwo = 0; 
Box2DProcessing box2d;

Serial myPort;
int[] serialInArray = new int[3];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
float Xrotation, Yrotation, Zrotation;                // Starting position of the ball
boolean firstContact = false;        // Whether we've heard from the microcontroller
float angleX =0;
float angleY =0;
float angleZ =0;
boolean start;
PImage eyes_open;
PImage eyes_closed;
//PImage NYUADimg;
PImage eyes_angry ;

boolean flag = true;

ArrayList<Blobby> boxes;
Blobby character;
Boundary OuterBoundary;
Box wall;
void setup() {
  eyes_open = loadImage("black.png");
  eyes_closed = loadImage("untitled.png");
  
  fullScreen();
  //size(600, 600);
  String portName = "COM6";
  //String portName = Serial.list()[1];
  //println(Serial.list());
  myPort = new Serial(this, portName, 9600);
  myPort.buffer(3);
  boxes = new ArrayList<Blobby>();
  //character = 
  box2d = new Box2DProcessing(this);
  box2d.createWorld(); 
  wall = new Box();
  character =new Blobby(width/2, height/2 - 50); //display blobby at width/2 and height/2
  OuterBoundary = new Boundary();
}


void draw() {
  //if (screenOne ==1){
  //textSize();
 
  if (myPort.available() > 0) {
    //println("Available");
    serialEvent(myPort);
  }
  //add box2d world
  if (mousePressed) {
    if (flag == true){
      Blobby p = new Blobby(width/2, (height/2));
      boxes.add(p);
    }
  }

  box2d.step();
  background(0);
  OuterBoundary.display();
  if (screenOne ==1){
  fill(255);
  textSize(1500);

   text(boxes.size(), 0, height );
   wall.display();
  }
  else{
    fill(255);
  textSize(200);

   text("You freed 99 \nblobbies, be the \n100th", 100, 300);
    
  }
  
  
  character.display(eyes_open);

  wall.updateRotation(angleX);
  for (Blobby b : boxes) {
    
    int pick_eyes = int(random(20));
    if (pick_eyes == 0 ) {b.checkifAngry(); b.display(eyes_open);}
    else if (pick_eyes == 1 ) { b.checkifAngry();b.display(eyes_closed);}
    //else if (pick_eyes == 1) {b.display(eyes_closed);}
    //else if (b.anonymous == true) {b.checkifAngry(); b.display(eyes_closed); }
    //else if (pick_eyes == 3) {b.display(eyes_closed);}
    //else if (pick_eyes == 5) {b.display(eyes_closed);}
    //else if (pick_eyes == 7) {b.display(eyes_closed);}
    //else if (pick_eyes == 10) {b.display(eyes_closed);}
    //else if (pick_eyes == 11) {b.display(eyes_closed);}
    else {b.checkifAngry(); b.display(eyes_open);}
    
  }
  if (boxes.size() >=  99){
    flag = false;
    for(Blobby blobby: boxes){
      if(blobby.anonymous == false){
        screenTwo = 0;
        screenOne =1;
        break;
        
      }
      else{
        screenTwo = 1;
        screenOne =0;
    
      }
      
    }
    
   //box2d.destroyBody(OuterBoundary.body);
   
   //OuterBoundary = new Boundary();
   //for(Blobby b : boxes){
   //  if (b.anonymous == r){
 
   //    break;
   //  }
    
   //}
  
  }
  //}
  
}

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
    if (serialCount > 2 ) {
      Xrotation = serialInArray[0];
      Yrotation = serialInArray[1];
      Zrotation = serialInArray[2];


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
  //float yAngle = atan( ay / (sqrt((ax*ax) + (az*az))));
  //float zAngle = atan( sqrt((ax*ax) + (ay*ay)) / az);
  //xAngle *= 180.00;   
  //yAngle *= 180.00;   
  //zAngle *= 180.00;
  //xAngle /= 3.141592; 
  //yAngle /= 3.141592; 
  //zAngle /= 3.141592;
  angleX = xAngle;
  //angleY = yAngle;
  //angleZ = zAngle;
}
