class Box {
  
  Body body;
  float rotation;
  int w = 400;
  int h = 400;
  int x = width/2;
  int y = height/2;
  ArrayList<Vec2> points;
  Box(){
    rotation =0;
    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    //STEP 2: Create Body
    body = box2d.createBody(bd);
    
    //STEP 3: Create Shape
    //PolygonShape ps = new PolygonShape();
    //float box2Dw = box2d.scalarPixelsToWorld(w/2);
    //float box2Dh = box2d.scalarPixelsToWorld(h/2);
    //ps.setAsBox(box2Dw, box2Dh);
    points = new ArrayList<Vec2>();
    points.add(new Vec2(width/6,height/6));
    points.add(new Vec2((5*width)/6,100));
    points.add(new Vec2((5*width)/6,(5*height)/6));
    points.add(new Vec2(width/6,(5*height)/6));
    points.add(new Vec2(width/6,height/6));
    
    ChainShape surface = new ChainShape();
    Vec2[] vertices = new Vec2[points.size()];
    for (int i = 0; i < vertices.length ;i++ ){
      vertices[i] = box2d.coordPixelsToWorld(points.get(i)); 
    }
    surface.createChain(vertices, vertices.length);
    //STEP 4: Create Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape  = surface;
    fd.density = 1;
    fd.friction = 0.6; 
    //fd.setTransform(fd.Position, 10);
    //fd.restitution = 0.5;
    //STEP5: attacj body to shape with fixture
    body.createFixture(fd);
    body.setAngularVelocity(0.1);

  }

  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    
    pushMatrix();
    //print(pos.x, pos.y);
    translate(pos.x,pos.y);
    rotate(-a);
    fill(255);
    //rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
    
  }
  
  void updateRotation(){
    rotation =+ 0.1;
    body.setTransform(body.getPosition(), rotation);
  }
}
