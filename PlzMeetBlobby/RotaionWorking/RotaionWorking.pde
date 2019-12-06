import shiffman.box2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

Box2DProcessing box2d;




ArrayList<Blobby> boxes;
Blobby character;
Box wall;
void setup(){
  size(600, 600); 
  boxes = new ArrayList<Blobby>();
  //character = 
  box2d = new Box2DProcessing(this);
  box2d.createWorld(); 
  wall = new Box();
  character =new Blobby(width/2,height/2);
  
}


void draw(){
  //add box2d world
  if (mousePressed){
    
    Blobby p = new Blobby(mouseX, mouseY);
    boxes.add(p);
    
  }
  
  box2d.step();
  background(0);
  wall.display();
  character.display();
  
  wall.updateRotation();
  for (Blobby b: boxes){
    b.display();
  }
}
