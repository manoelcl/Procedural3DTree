class Branch{
  public PVector end;
  public PVector begin;
  public boolean visited=false;
  public int generation;
 
  Branch(PVector start, PVector direction, int gen){
    this.begin=start;
    this.end=PVector.add(start,direction);
    this.generation = gen;
    currentGeneration = gen;
  }
  
  void drawBranch(){
    stroke(30+generation*20);
    strokeWeight(10/(generation+1));
    line(begin.x, begin.y, begin.z, end.x, end.y, end.z);
  }
  
  void nextBranch(){
    //Direction of the current branch
    PVector direction = PVector.sub(end, begin);
    //Normalized vector of the current branch 
    PVector dirNorm = new PVector();
    direction.normalize(dirNorm);
    //Normal of the plan 
    PVector firstAxis = new PVector();
    PVector.cross(end, begin, firstAxis);
    
    direction.mult(.65);
    //If both vectors are parallell, we use x as default rotation vector
    if (firstAxis.mag()==0){
      firstAxis = new PVector(1,0,0);
    }
    
    firstAxis.normalize(firstAxis);
            
    for (int i=0; i<4; i++){
      PVector rot = Rodrigues(direction, PI/random(2,5), firstAxis);
      PVector newDir = Rodrigues(rot,i*PI/2,dirNorm);
      tree.add(new Branch(end, newDir, generation+1));
    }
  }
  //creates leaves
  void leaves(){
    leaves.add(new Leaf(end));
  }
  
  
  //Custom Rodrigues 3D vector rotation function implementation
  PVector Rodrigues(PVector vector, float angle, PVector axis){
    PVector rod = PVector.mult(vector, cos(angle)); 
    PVector rod2 = new PVector();
    PVector.cross(axis, vector, rod2);
    rod2.mult(sin(angle));
    PVector rod3 = PVector.mult(axis, PVector.dot(axis,vector));
    rod3 = PVector.mult(rod3, 1-cos(angle));
    
    return PVector.add(PVector.add(rod, rod2),rod3);
  }
  void shake(){
    end.add(new PVector(.02*sin(millis()/1000)*generation+.03*sin(2*millis()/1000)*generation,.02*sin(millis()/1000)*generation+.03*sin(2*millis()/1000)*generation,.02*sin(millis()/1000)*generation+.03*sin(2*millis()/1000)*generation));
  }
  
}
