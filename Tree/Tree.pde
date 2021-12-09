ArrayList<Branch> tree= new ArrayList<Branch>();
ArrayList<Leaf> leaves= new ArrayList<Leaf>();
int posX=0;
int posY=0;
int currentGeneration=0;

void setup (){
  fullScreen(P3D);
  tree.add(new Branch(new PVector(0, 0, 0), new PVector(0, -100, 0),0));
  //tree.get(0).nextBranch();
}
void mouseClicked() {
  int asd=tree.size()-1;
  if (currentGeneration<5)
   for (int i=asd; i>=0; i--){
     if (tree.get(i).visited == false){
       
       tree.get(i).nextBranch();
       tree.get(i).visited = true;
       
     }else{
       break;
     }
  }else{
    if (leaves.size()==0){
      for (int i=asd; i>=0; i--){
         if (tree.get(i).generation == currentGeneration){
           tree.get(i).leaves();
         }else{
           break;
         }
      }
    }else{
      
      for (int i=asd; i>=0; i--){
           tree.remove(i);
      }
      asd=leaves.size()-1;
      for (int i=asd; i>=0; i--){
           leaves.remove(i);
      }
      tree.add(new Branch(new PVector(0, 0, 0), new PVector(0, -100, 0),0));
    }
  }
}
  


void draw(){
  
  background(255);
  
  posX=int(map(mouseX,0,width,-1000, 1000));
  posY=int(map(mouseY,0,height,-1000,-1));
  float x = posX;
  float y = -200-(-500/(float(posY)-50)/3)*100;
  float z = posY;
  
  camera(x,y,z, 0,-200,0, 0,1,0);
  //Draw branches
  for (int i=0; i<tree.size(); i++){
    tree.get(i).shake();
    tree.get(i).drawBranch();
    if (tree.size() < 50){
      //tree.get(i).nextBranch();
    }
  }
  //Draw leaves
  for (int i=0; i<leaves.size(); i++){
    //tree.get(i).shake();
    float colorMult = map(dist(leaves.get(i).pos.x,leaves.get(i).pos.y,leaves.get(i).pos.z,x,y,z), 300, 1000, 0, 128);
    leaves.get(i).drawLeaf(colorMult);
  }
}
