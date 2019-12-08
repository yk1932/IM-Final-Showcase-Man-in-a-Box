class Blobby {

  Body body;
  int w = 50;
  int h = 50;

  Blobby(int x, int y) {



    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    //STEP 2: Create Body
    //bd.bullet = false;
    body = box2d.createBody(bd);
    body.setGravityScale(10);
    //STEP 3: Create Shape
    //PolygonShape ps = new PolygonShape();
    //float box2Dw = box2d.scalarPixelsToWorld(w/2);
    //float box2Dh = box2d.scalarPixelsToWorld(h/2);
    //ps.setAsBox(box2Dw, box2Dh);
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(w/2);
    //STEP 4: Create Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape  = cs;
    fd.density = 100;
    fd.friction = 0.3; 
    fd.restitution = 0.3f;

    //STEP5: attacj body to shape with fixture
    body.createFixture(fd);
    body.setAngularVelocity(random(-10, 10));
    blobby_img = loadImage("black.png");

    
    //int eyeColor = int(random(2));
    //if (eyeColor ==  0) {
    //  blobby_img = loadImage("black.png");
   //load black eyes
  //else if (eyeColor == 1) {
  //  blobby_img = loadImage("untitled.png");
  //} //load black eyes
  //  else if (eyeColor == 2) {
  //    blobby_img = loadImage("blue.png");
  //  } //load blue eyes
  
  int randomColor;
  randomColor = int(random(255));
}

void display() {
  Vec2 pos = box2d.getBodyPixelCoord(body);

  //image(blobby_img, pos.x-20, pos.y-20, 40, 40);

  //rectMode(CENTER);

  float a = body.getAngle();
  print(blobby_img);


  pushMatrix();
  fill(int(random(255)), int(random(255)), int(random(255)));
  //nofill(255);
  translate(pos.x, pos.y);
  rotate(-a);

  rectMode(CENTER);
  ellipse(0, 0, w, h);
  //image(img, pos.x-20, pos.y-20, 40, 40);

  popMatrix();
  image(blobby_img, pos.x-20, pos.y-20, 40, 40);
}
}
