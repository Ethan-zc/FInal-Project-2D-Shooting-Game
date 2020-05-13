class Bullet
{
  private PVector p;
  private float s;
  private int w;
  private PVector b1;
  private PVector b2;
  private PVector b3;
  private PVector b4;
  private ArrayList<PVector> corner_points;

  
  public Bullet(PVector pos, float sz,int wh)
  {
    p = pos;
    s = sz;
    w = wh;
    b1 = new PVector(p.x + 10, p.y - 10);
    b2 = new PVector(p.x + 10, p.y + 10);
    b3 = new PVector(p.x - 10, p.y + 10);
    b4 = new PVector(p.x - 10, p.y - 10);
    corner_points = new ArrayList<PVector>();
    corner_points.add(b1);
    corner_points.add(b2);
    corner_points.add(b3);
    corner_points.add(b4);
  }
  
  public void update()
  {
    p.y -= s;
    
    if(w == 1){
      p.x -=1;
    }else if(w ==2){
       p.x +=1;
    }
  }
  
  public void draw()
  {
    fill(255);
   
    rect(p.x-10, p.y-10, 20, 20);
  }
}
