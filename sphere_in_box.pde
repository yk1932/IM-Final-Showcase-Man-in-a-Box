// ball location
float x=0, y=0, z=0;
// ball speeds
float xs=3, ys=2.1, zs=1;
// rotation of scene (viewpoint)
float rotz=0, rotx=0, roty=0;

void setup() {
  size(800, 800, P3D);
}

void draw() {
  background(0);

  // Make 0,0,0 center of scene, rotate all axises
  translate(width/2, height/2, 0);
  rotateX(rotx);
  rotateY(roty);
  rotateZ(rotz);
  lights();
  directionalLight(128, 128, 128, 0, -1, -1);
  // Yellow spotlight outside cube pointing to center
  spotLight(255, 255, 0, 200, 200, 200, -1, -1, -1, PI/2, 2);
  // Red spotlight outside cube pointing to center
  spotLight(255, 0, 0, -200, -200, 200, 1, 1, -1, PI/2, 2);

  // Small yellow sphere where light is 
  pushMatrix();
  noStroke();
  fill(255, 255, 0);
  translate(200, 200, 200);
  sphere(5);
  popMatrix();

  // Small red sphere where light is 
  pushMatrix();
  noStroke();
  fill(255, 0, 0);
  translate(-200, -200, 200);
  sphere(5);
  popMatrix();

  // Wire frame box in which the ball bounces
  pushMatrix();
  stroke(255);
  noFill();
  translate(0, 0, 0);
  box(300);
  popMatrix();

  // Bouncing ball
  pushMatrix();
  rotateX(-PI/8);
  translate(x, y, z);
  rectMode(CENTER);
  noStroke();
  fill(128);
  sphere(20);
  popMatrix();

  // Update ball position, bounce if reach box edge (box is -150 to 150, ball is 20)
  x=x+xs;
  if (x>130 || x<-130) {
    x=x-xs;
    xs=-xs;
  }

  y=y+ys;
  if (y>130 || y<-130) {
    y=y-ys;
    ys=-ys;
  }

  z=z+zs;
  if (z>130 || z<-130) {
    z=z-zs;
    zs=-zs;
  }

  // Rotate scene
  rotx+=0.001;
  roty+=0.0009;
  rotz+=0.0011;
}
