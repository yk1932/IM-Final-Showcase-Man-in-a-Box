class Box {
  
  Body body;
  float rotation;
  int w = (43*height)/64; //width of the box
  int h = (43*height)/64; //height of the box
  int x = width/2;
  int y = height/2;
  ArrayList<Vec2> points;
  //ArrayList<Vec2> tempPoints;
  ChainShape surface;
    Vec2[] vertices;
    float[] rotations = {3*PI/4, PI/4, 7*PI/4, 5*PI/4, 3*PI/4 };
  Box(){
    rotation =0;
    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    //STEP 2: Create Body
    body = box2d.createBody(bd);
    
    //STEP 3: Create Shape
    //PolygonShape ps = new PolygonShape();
    //float box2Dw = box2d.scalarPixelsToWorld(w/2);
    //float box2Dh = box2d.scalarPixelsToWorld(h/2);
    //ps.setAsBox(box2Dw, box2Dh);
    points = new ArrayList<Vec2>();
    //tempPoints = new ArrayList<Vec2>();
    
    //points.add(new Vec2(width/6,height/6));
    //points.add(new Vec2((5*width)/6,100));
    //points.add(new Vec2((5*width)/6,(5*height)/6));
    //points.add(new Vec2(width/6,(5*height)/6));
    //points.add(new Vec2(width/6,height/6));
    
    points.add(new Vec2(width/4,height/4)); //left vertice
    points.add(new Vec2((3*width)/4,100));
    points.add(new Vec2((3*width)/4,(3*height)/4));
    points.add(new Vec2(width/4,(3*height)/4));
    points.add(new Vec2(width/4,height/4));
    
    
    
    CreateShape();
    //surface.createChain(vertices, vertices.length);
    //STEP 4: Create Fixture
    //FixtureDef fd = new FixtureDef();
    //fd.shape  = surface;
    //fd.density = 1;
    //fd.friction = 0.6; 
    ////fd.setTransform(fd.Position, 10);
    ////fd.restitution = 0.5;
    ////STEP5: attacj body to shape with fixture
    //body.createFixture(fd);
    //body.setAngularVelocity(0.1);

  }

  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    
    pushMatrix();
    //print(pos.x, pos.y);
    translate(pos.x,pos.y);
    rotate(rotation);
    fill(255);
    //rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
    
  }
  void CreateShape(){
    
    surface = new ChainShape();
    vertices = new Vec2[points.size()];
    //verticess = new Vec2[points.size()];
    //Vec2 tempPoint =  new Vec2(0,0);
    //Vec2 tempVector = new Vec2(0,0);
    Vec2 centVec=new Vec2(width/2,height/2);
    Vec2 radiusVector = points.get(0).sub(centVec);
    int count = 0;
    for (int i = 0; i < vertices.length ;i++ ){
      //println(rotation);
      
      //println(radiusVector.length());
      Vec2 tempVector = new Vec2(radiusVector.length()*(cos(rotations[count]+rotation)),radiusVector.length()*(sin(rotations[count]+rotation)));
  
      if (count < 4) count++;
     
     //println(points.get(i));
      //Vec2 newVec=new Vec2(tempVec.x,tempVec.y);
      vertices[i] = box2d.coordPixelsToWorld(tempVector.add(centVec)); 
      //verticess[i] = new Vec2(vertices[i].length()*(cos(rotation)),vertices[i].length()*(sin(rotation))); //comment
      //println(verticess);
    }
    
    //println(points.size());
    surface.createChain(vertices, vertices.length);
    FixtureDef fd = new FixtureDef();
    fd.shape  = surface;
    fd.density = 1;
    fd.friction = 0.6; 
    //fd.setTransform(fd.Position, 10);
    //fd.restitution = 0.5;
    //STEP5: attacj body to shape with fixture
    body.createFixture(fd);

    
  }
  
  void updateRotation(float angle){
    body.destroyFixture(body.getFixtureList());
    //vertices=new Vec2[surface.size()];
    CreateShape();
    rotation = angle;
    //if (rotation > 2*PI){
    //  rotation =0;
    //}
    //body.setTransform(body.getPosition(), rotation);
    //chain=new ChainShape();
    //PVector centVec=new PVector(width/2,height/2);
    //for(int i=0;i<vertices.length;i++){
    //  PVector tempVec=new PVector(surface.get(i).x,surface.get(i).y);
    //  PVector oprimea=PVector.sub(tempVec,centVec);
    //  PVector goal=tempVec.sub(oprimea).add(oprimea.rotate(rAngle));
    //  Vec2 newVec=new Vec2(tempVec.x,tempVec.y);

    //  vertices[i]=box2d.coordPixelsToWorld(newVec);
    //}
    //chain.createChain(vertices,vertices.length);
    //body.createFixture(chain,1);
    //body.setUserData(this);
  }
}
