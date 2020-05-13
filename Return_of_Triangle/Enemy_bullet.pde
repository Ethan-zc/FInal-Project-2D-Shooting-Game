class Enemy_bullet
{
  private PVector p;
  private float s;
  private float size;


  
  public Enemy_bullet(PVector pos, float sz)
  {
    p = pos;
    s = 1;
    size = sz;
    //b1 = new PVector(p.x + 10, p.y - 10);
    //b2 = new PVector(p.x + 10, p.y + 10);ß
    //b3 = new PVector(p.x - 10, p.y + 10);
    //b4 = new PVector(p.x - 10, p.y - 10);
    //corner_points = new ArrayList<PVector>();
    //corner_points.add(b1);
    //corner_points.add(b2);
    //corner_points.add(b3);
    //corner_points.add(b4);
  }
  
  public void update()
  {
    p.y += s;
    
    //if(w == 1){
    //  p.x -=1;
    //}else if(w ==2){
    //   p.x +=1;
    //}
  }
  
  public void draw()
  {
    fill(255,0,0);
    ellipse(p.x, p.y, size, size);
  }
}
