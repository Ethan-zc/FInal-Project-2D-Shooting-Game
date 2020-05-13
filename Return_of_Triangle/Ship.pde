class Ship
{
  private float x, y, w, h;
  private boolean isAlive;
  
  public Ship(float wd)
  {
    x = width / 2;
    w = wd;
    h = wd + wd / 5;
    y = height - (h / 2);
    isAlive = true;
  }
  
  public void draw()
  {
    
    
    
    fill(255);
    rect(x - w / 2, y - h / 2, w, h);
    
    fill(255);
    rect(x - w, y - h, w / 2, h - 5);
    rect(x + w / 2, y - h, w / 2, h - 5);
    
    fill(255,0,0);
    circle(x,y,10);
  }
}
