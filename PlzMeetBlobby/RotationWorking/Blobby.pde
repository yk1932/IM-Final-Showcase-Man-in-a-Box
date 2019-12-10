class Blobby {

  Body body;
  int w;
  int h;
  int blobby_color1; 
  int blobby_color2; 
  int blobby_color3; 
  int eyeColor; 
  PImage blobby_img;
  boolean free;
  boolean first_time = true;
  int index; 
  Blobby(int x, int y, int size) {
    

    w = size;
    h = size;
    eyeColor = int(random(2));
    blobby_color1 = int(random(255));
    blobby_color2 = blobby_color1;
    blobby_color3 = blobby_color1;
    free = false;


      //eyes_open = loadImage("black.png");
    
      //eyes_closed = loadImage("untitled.png");
    
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
    fd.friction = 0; 
    fd.restitution = 0.9f;

    //STEP5: attacj body to shape with fixture
    body.createFixture(fd);
    body.setAngularVelocity(random(-10, 10));


    //  int eyeColor = int(random(2));
    //  if (eyeColor ==  0) {
    //    blobby_img = loadImage("black.png");}
    //else if (eyeColor == 1) {
    //  blobby_img = loadImage("untitled.png");
    //} //load black eyes
    //  else if (eyeColor == 2) {
    //    blobby_img = loadImage("blue.png");
    //  } //load blue eyes

    // int randomColor;
    randomColor = int(random(255));
  }
  
  boolean checkifAngry(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(dist(pos.x, pos.y, width/2, height/2)> 283){
      free = true;
      body.setGravityScale(0);
      //randomColor = int(random(255));
      //this.blobby_color1 = randomColor
      if (first_time){
        first_time = false;
      blobby_color1 = int(random(255));
      blobby_color2 = int(random(255));
      blobby_color3 = int(random(255));
          w = int(random(30, 70));
          h = w;
          return true;
      }
      
    }
    return false; 
    //if (dist.pos.x)
    
    
  }

  void display(PImage eyes) {

 

    Vec2 pos = box2d.getBodyPixelCoord(body);

    //image(blobby_img, pos.x-20, pos.y-20, 40, 40);

    //rectMode(CENTER);

    float a = body.getAngle();
    //print(blobby_img);


    pushMatrix();
    fill(this.blobby_color1, this.blobby_color2, this.blobby_color3);
    //nofill(255);
    translate(pos.x, pos.y);
    rotate(-a);

    rectMode(CENTER);
    noStroke();
    ellipse(0, 0, w, h);
    //image(img, pos.x-20, pos.y-20, 40, 40);

    popMatrix();
    image(eyes, pos.x-20, pos.y-20, 40, 40);
  }
}
