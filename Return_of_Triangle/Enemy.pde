class Enemy
{
  private PVector p;
  private float s;
  private PVector v;
  private PVector a;
  private int hp;
  private float max_force;
  private float max_speed;

  
  public Enemy(PVector pos, float sz, float spd, int h)
  {
    p = pos;
    s = sz;
    //sp = spd;
    v = new PVector(0,spd);
    a = new PVector(0,0);
    hp = h;
    max_force = 0.03;
    max_speed = 3;
  }
  
  public void update(ArrayList<Enemy> enemies)
  {
    PVector sep = separate(enemies);   
    PVector ali = align(enemies);      
    PVector coh = cohesion(enemies);   
    
    sep.mult(2);
    ali.mult(1);
    coh.mult(1);
    
    a.add(sep);
    a.add(ali);
    a.add(coh);
    
    v.add(a);
    v.limit(max_speed);
    p.add(v);
    a.mult(0);
    // To change the position if it go through board. 
    if (p.x < -s) p.x = width+s;
    if (p.x > width+s) p.x = -s;

   
    draw();
  }
  //<>//
  // Separation
  PVector separate (ArrayList<Enemy> enemies) {

    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (Enemy other : enemies) {
      float d = PVector.dist(p, other.p);
      if (d > 0) {
        if (d < s+other.s) {
          PVector diff = PVector.sub(p, other.p);
          diff.normalize();
          diff.div(d);     
          steer.add(diff);
          count++; 
        
        }          

      }
    }
    if (count > 0) {
      steer.div((float)count);
    }


    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(max_speed);
      steer.sub(v);
      steer.limit(max_force);
    }
    return steer;
  }
  
  
  
  
  PVector align (ArrayList<Enemy> enemies) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Enemy other : enemies) {
      float d = PVector.dist(p, other.p);
      if (d > 0) {
        if (d < neighbordist) {
          sum.add(other.v);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(max_speed);
      PVector steer = PVector.sub(sum, v);
      if (steer.mag() > max_force) {
        steer.normalize();
        steer.mult(max_force);
      }
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  PVector cohesion (ArrayList<Enemy> enemies) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Enemy other : enemies) {
      float d = PVector.dist(p, other.p);
      if ((d > 0)) {
        if (d < neighbordist) {
          sum.add(other.p);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div(count);
      return Cal_Steer(sum); 
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  public void draw()
  {
    //fill(255);
    //pushMatrix();
    //translate(p.x, p.y);
    ////rotate(frameCount / -100.0);
    //float angle = TWO_PI / 6;
    //beginShape();
    //for (float a = 0; a < TWO_PI; a += angle) {
    //  float sx = p.x + cos(a) * s;
    //  float sy = p.y + sin(a) * s;
    //  vertex(sx, sy);
    //}
    //endShape(CLOSE);
    //popMatrix();
    //ellipse(p.x, p.y, s, s);
    //fill(0);
    //textSize(s / 2);
    //textAlign(CENTER);
    //text(hp, p.x, p.y);
    fill(255);
    circle(p.x, p.y, s);
    fill(0);
    textSize(s / 2);
    textAlign(CENTER, CENTER);
    text(hp, p.x, p.y);
  }
  
  PVector Cal_Steer(PVector target) {
    PVector destination = target.sub(p);
    destination.normalize();
    destination.mult(max_speed);

    PVector steer = PVector.sub(destination, v); 
    if (steer.mag() > max_force) {
      steer.normalize();
      steer.mult(max_force);
    }
    return steer;
  }
  
}
