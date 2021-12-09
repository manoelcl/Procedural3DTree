class Leaf{
  
  public PVector pos = new PVector();
  public PVector dir = new PVector();
  
  Leaf(PVector pos){
    this.pos = pos;
  }
  
  void drawLeaf(float mult){
    push();
    PVector shake = shakeLeaf();
    translate(pos.x+shake.x,pos.y+shake.y,pos.z+shake.z);
    rotate(PI/3.0);
    rectMode(CENTER);
    noStroke();
    fill(156-mult,256-mult,128-mult);
    sphereDetail(5);
    sphere(5);
    pop();
  }
  PVector shakeLeaf(){
    return new PVector(random(-.25,.25),random(-.25,.25),random(-.25,.25));
    
  }
}
