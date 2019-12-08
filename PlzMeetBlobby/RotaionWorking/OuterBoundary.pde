class Boundary {
  
  Body body;

  int w = width;
  int h = height;
  int x = width/2;
  int y = height/2;
  ChainShape surface;
  Vec2[] vertices;
  ArrayList<Vec2> points;

  BodyDef bd;


  //ArrayList<Vec2> tempPoints;

 Boundary(){
    
    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    //STEP 2: Create Body
    body = box2d.createBody(bd);
     points = new ArrayList<Vec2>();
    //tempPoints = new ArrayList<Vec2>();
    points.add(new Vec2(0, 0));
    points.add(new Vec2(width, 0));
    points.add(new Vec2(width, height));
    points.add(new Vec2(0, height));
    points.add(new Vec2(0, 0));
    
    //STEP 3: Create Shape
    surface = new ChainShape();
    vertices = new Vec2[points.size()];
    
    //PolygonShape ps = new PolygonShape();
    //float box2Dw = box2d.scalarPixelsToWorld(w/2);
    //float box2Dh = box2d.scalarPixelsToWorld(h/2);
    //ps.setAsBox(box2Dw, box2Dh);
    for (int i = 0; i < vertices.length ;i++ ){
  
      
     //println(points.get(i));
      //Vec2 newVec=new Vec2(tempVec.x,tempVec.y);
      vertices[i] = box2d.coordPixelsToWorld(points.get(i)); 
      //verticess[i] = new Vec2(vertices[i].length()*(cos(rotation)),vertices[i].length()*(sin(rotation))); //comment
      //println(verticess);
    }
   
    surface.createChain(vertices, vertices.length);
    


   // STEP 4: Create Fixture
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
    //float a = body.getAngle();
    
    
    pushMatrix();
    print(pos.x, pos.y);
 

    fill(125);
    //rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
    popMatrix();
    
  }
  
 
}
