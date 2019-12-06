import processing.serial.*;

int bgcolor;           // Background color
int fgcolor;           // Fill color
Serial myPort;                       // The serial port
int[] serialInArray = new int[3];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
float Xrotation, Yrotation, Zrotation;                // Starting position of the ball
boolean firstContact = false;        // Whether we've heard from the microcontroller
float angleX =0;
float angleY =0;
float angleZ =0;
boolean start;

PShape AShape;


/////////////////////////////////////////////////////////////////////////////

// ball location
float x=0, y=0, z=0;
// ball speeds
float xs=10, ys=7, zs=4;
// rotation of scene (viewpoint)
float rotz=0, rotx=0, roty=0;



class Ball{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector GravitationalForce;
  PVector NormalForce;
  PVector ForceNet;  
  int mass;
  Ball(){
    this.location = new PVector(0, 0, 0);
    this.velocity = new PVector(2,0, 2);
    //this.mass = 10;
    this.acceleration = new PVector(0.8, 0.8, 0.8);
    //this.GravitationalForce = new PVector(0, this.acceleration.y*this.mass);
    //this.ForceNet = new PVector(0, 0);
  }
  
  void display(){
    sphere(20);
  }
  void checkBoundaries(){
     if (this.location.y > 130){
         this.velocity.y = this.velocity.y*-0.8;
         this.location.y = 130;// why?
         
  }
  if (this.location.x > 130){
         this.velocity.x = this.velocity.x*-0.8;
         this.location.x = 130;// why?
         
  }
  if (this.location.z > 130 ){
         this.velocity.z = this.velocity.z*-0.8;
         this.location.z = 130;// why?
         
  }
     if (this.location.y < -130 ){
         this.velocity.y = this.velocity.y*-0.8;
         this.location.y = -130;// why?
         
  }
  if (this.location.x < -130 ){
         this.velocity.x = this.velocity.x*-0.8;
         this.location.x = -130;// why?
         
  }
  if (this.location.z < -130){
         this.velocity.z = this.velocity.z*-0.8;
         this.location.z = -130;// why?
         
  }
  }
  
  void update(){
    this.location.add(this.velocity);
    this.velocity.add(this.acceleration);
  //  if (this.location.y > 130){
  //       this.velocity.y = this.velocity.y*-0.8;
  //       this.location.y = 130;// why?
         
  //}
  //if (this.location.x > 130){
  //       this.velocity.x = this.velocity.x*-0.8;
  //       this.location.x = 130;// why?
         
  //}
  //if (this.location.z > 130 ){
  //       this.velocity.z = this.velocity.z*-0.8;
  //       this.location.z = 130;// why?
         
  //}
  //   if (this.location.y < -130 ){
  //       this.velocity.y = this.velocity.y*-0.8;
  //       this.location.y = -130;// why?
         
  //}
  //if (this.location.x < -130 ){
  //       this.velocity.x = this.velocity.x*-0.8;
  //       this.location.x = -130;// why?
         
  //}
  //if (this.location.z < -130){
  //       this.velocity.z = this.velocity.z*-0.8;
  //       this.location.z = -130;// why?
         
  //}

}

}



void setup() {
  size(800, 800, P3D);
  AShape = loadShape("BodyMesh.obj");
  println(Serial.list());
  start = false;
  ball = new Ball();

  // I know that the first port in the serial list on my Mac is always my FTDI
  // adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = "COM6";
  myPort = new Serial(this, portName, 9600);
  myPort.buffer(3);
}

void keyPressed() {
  if (key == ' ') {
    start = true;
  }
}

Ball ball;
void draw() {


  if (myPort.available() > 0) {
    //println("Available");
    serialEvent(myPort);
  }
  background(0);

  // Make 0,0,0 center of scene, rotate all axises
pushMatrix();
  translate(width/2, height/2, 0);
  pushMatrix();

  rotateX(angleX);
  rotateY(angleY);
  rotateZ(angleZ);
  lights();
  
  directionalLight(128, 128, 128, 0, -1, -1);



  // Wire frame box in which the ball bounces

  stroke(255);
  noFill();
  translate(0, 0, 0);
  box(300);
 
  //rect(0, 0, 260, 260);//debugging
  //popMatrix();

  // Bouncing ball
  //pushMatrix();
  rotateX(-PI/8);
  translate(ball.location.x, ball.location.y, z);
  //rectMode(CENTER);
  noStroke();
  fill(128);
  ball.display();
  ;
  ball.checkBoundaries();
  //scale(20);
  //shape(AShape);
  popMatrix();
 popMatrix();
  pushMatrix();
  ball.update();
  popMatrix();

  if (start == true) {
    
      
    //start =false;

    // Update ball position, bounce if reach box edge (box is -150 to 150, ball is 20)
    //pushMatrix();
    //x=x+xs;
    //if (x>130 || x<-130) { // if the x axis is hit
    
    //  x=x-xs;
    //  xs=-xs;
    //}

    //y=y+ys;
    //if (y>130 || y<-130) {
    //  y=y-ys;
    //  ys=-ys;
    //}

    //z=z+zs;
    //if (z>130 || z<-130) {
    //  z=z-zs;
    //  zs=-zs;
    //}
    
    
    //popMatrix();

    // Rotate scene
  } else {
  }
  //popMatrix();

}


/////////////////////////////////////////////////////////////////////////////


//void setup() {
//  size(500, 500, P3D);  // Stage size
//  //noStroke();      // No border on the next thing drawn

//  // Set the starting position of the ball (middle of the stage)
//  //xpos = width / 2;
//  //ypos = height / 2;

//  // Print a list of the serial ports for debugging purposes
//  // if using Processing 2.1 or later, use Serial.printArray()
//  println(Serial.list());

//  // I know that the first port in the serial list on my Mac is always my FTDI
//  // adaptor, so I open Serial.list()[0].
//  // On Windows machines, this generally opens COM1.
//  // Open whatever port is the one you're using.
//  String portName = "COM6";
//  myPort = new Serial(this, portName, 9600);
//  myPort.buffer(3);
//}

//void draw() {

//  fill(fgcolor);
//  // Draw the shape
//  pushMatrix();
//  background(255);
//  translate(width/2, height/2);
//  rotateX(angleX);
//  rotateY(angleY);
//  rotateZ(angleZ);

//  box(150);
//  popMatrix();
//  //print(myPort.readStrin gUntil('\n'));
//  if (myPort.available() > 0){
//    //println("Available");
//    serialEvent(myPort);
//  }

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
    if (serialCount > 2 ) {
      Xrotation = serialInArray[0];
      Yrotation = serialInArray[1];
      Zrotation = serialInArray[2];
      Xrotation = map(Xrotation, 0, 255, -400, 400);
      Yrotation = map(Yrotation, 0, 255, -400, 400);
      Zrotation = map(Zrotation, 0, 255, -400, 400);

      // print the values (for debugging purposes only):
      println( Xrotation/100 + "\t" + Yrotation/100 + "\t" + Zrotation/100);
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
      delay(50);
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
  angleX = xAngle;
  angleY = yAngle;
  angleZ = zAngle;
}
