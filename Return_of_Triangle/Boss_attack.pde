class Boss_attack
{
  Boss_bullet attacks;
  PVector gravity;
  ArrayList<Boss_bullet> particles;
  float hColor;

  Boss_attack(float x, float y)
  {
    hColor = random(255);
    //float explosion = random(1);
    //if (explosion < 0.3) explosion = 1;
    //else if (explosion < 0.6) explosion = 2;
    //else if (explosion < 0.9) explosion = 3;
    //print(explosion);
    this.attacks = new Boss_bullet(int(x), int(y),hColor);
    this.gravity = new PVector(0, 0);
    particles = new ArrayList<Boss_bullet>();
  }


  boolean isDone()
  {
    if (attacks == null && particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }



  boolean update(float x, float y)
  {
    boolean result = false;
    if (attacks!=null)
    {
      pushMatrix();
      fill(hColor,255,255);
      this.attacks.addForce(gravity);
      this.attacks.run();  
      if (attacks.isExploded()) {
        float explosion = random(1);
        if (explosion < 0.3) explosion = 1;
        else if (explosion < 0.6) explosion = 2;
        else if (explosion < 0.9) explosion = 3;
        print(explosion);
        for (int i = 0; i < 100; i++) {
          particles.add(new Boss_bullet(attacks.pos,hColor, explosion));
        }
        attacks = null;
      }
      popMatrix();
    }

    for (int i = particles.size()-1; i >= 0; i--) {
      Boss_bullet p = particles.get(i);
      p.addForce(this.gravity);
      p.run();
      if (p.isDead() || hit(x, y, p.pos.x, p.pos.y)) {
        particles.remove(i);
      }
      if (hit(x, y, p.pos.x, p.pos.y)) {
        result = true;
      }
    }
    return result;
  }
  
}

public boolean hit(float x, float y, float particle_x, float particle_y) {
  PVector ship_position = new PVector(x, y);
  PVector particle_position = new PVector(particle_x, particle_y);
  
  return (ship_position.sub(particle_position).mag() < 10);
  
  
}
