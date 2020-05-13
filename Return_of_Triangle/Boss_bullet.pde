class Boss_bullet
{
  PVector pos, acc, vel;
  //is explosive.
  boolean explosive = false;
  float lifespan;
  float hColor;
  float explosion_type;
  

  Boss_bullet(int x, int y, float hColor)
  { 
    this.hColor = hColor;
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 15);
    this.acc = new PVector(0, 0); 
    lifespan = 500.0;
    explosive = true;
    //explosion_type = explosion;
    //float random_type = random(1);
    //if (random_type < 0.3) explosion_type = 1;
    //else if (random_type < 0.6) explosion_type = 2;
    //else if (random_type < 0.9) explosion_type = 3;
  }

  Boss_bullet(PVector explodedPos, float hColor, float explosion)
  {
    this.hColor = hColor;
    this.pos = explodedPos.copy();
    this.acc = new PVector(0, 0); 
    //this.vel = PVector.random2D();
    vel = new PVector(random(-0.2, 0.2),random(-0.2,0.2));
    explosion_type = explosion;
    if(random(1)<0.4)
    {
      this.vel.mult(random(3, 6));
    }
    else if(random(1)<0.6)
    {
      this.vel.mult(random(6, 8));
    }
     else if(random(1)<0.9)
    {
      this.vel.mult(random(8, 10));
    }
    else
        this.vel.mult(random(10, 15));
    lifespan = 1800.0;
  }

  void run()
  {
    update();
    show();
  }

  void addForce(PVector force)
  {
    this.acc.add(force);
  }

  boolean isExploded()
  {
    if (explosive && pos.y >= 800)
    {
      lifespan = 0;
      return true;
    }
    return false;
  }


  void update()
  {
    //acc = new PVector(-vel.y, vel.x);
    //acc = acc.normalize();

    if (!explosive)
    {
      
      lifespan -=5.0;
      //float random_type = random(1);
      if (explosion_type == 1) {
        acc = new PVector(-vel.y * 0.01, vel.x * 0.01);
      } else if (explosion_type == 2) {
        acc = new PVector(vel.y * 0.01, -vel.x  * 0.01);
      } else if (explosion_type == 3) {
        acc = new PVector(0, 0);
      }
      
      //else if (frameCount % 337 == 0) {
      //  acc = new PVector(vel.x * 0.01, -vel.y * 0.01);
      //}
      //acc = new PVector(-vel.x * 0.1, -vel.y * 0.1);
      //acc = acc.normalize();
      //vel.mult(0.9);
    }
    this.vel.add(acc);
    this.pos.add(vel);
  }

  boolean isDead()
  {
    if (lifespan < 0 ) {
      return true;
    } else {
      return false;
    }
  }


  void show()
  {
    pushMatrix();
    
    if (explosion_type == 1) {
      fill(255, 0, 0);
    }else if (explosion_type == 2) {
      fill(0,255,0);
    }else if (explosion_type == 3) {
      fill(0,0,255);
    }
    //fill(hColor, 255, 255, lifespan);
    //rotate(frameCount/10.0);
    //if (explosive) {
    //  strokeWeight(random(5,8));
    //} else {
    //  strokeWeight(random(1,5));
    //} 
    //point(this.pos.x, this.pos.y);
    circle(pos.x, pos.y, 20);
    popMatrix();
  }
}
