class Boss
{
  private PVector p;
  float s, sp;
  private int hp;
  private int px;
  public ArrayList<Boss_attack> single_attack;

  public Boss(){
    
    p = new PVector(400, -10);
    s = 300;
    sp = 2;
    hp = 400;
    px = -2;
    single_attack = new ArrayList<Boss_attack>();
    
  }
  
  public void update(){
    if (p.y < 200) {
       p.y += sp;
    } else {
      if (p.x < 150)  {
        px = 2;
      } else if (p.x > 650) {
        px = -2;
      }
      
      p.x += px;
      if(frameCount % 100 == 0) {
        
        
      }
    }

  }
  
  public void attack() {
    
    
    
    
    
    
  }
  
  public void draw(){
    fill(255);
    ellipse(p.x, p.y, s, s);
    
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(hp, p.x, p.y);
    
    //fill(255);
    //triangle(p.x, p.y, p.x, p.y + 100, p.x - 100, p.y - 30);
    //triangle(p.x + 400, p.y, p.x + 400, p.y + 100, p.x + 500, p.y - 30);
  }
  
}
