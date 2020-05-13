class Boom{
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float size = 1;
  private float lifespan;
  private float color_control;
  
  Boom(PVector l)
 {
    acceleration = new PVector(random(-0.1,0.1), random(-0.1,0.1));
    velocity = new PVector(random(-4,4), random(-4,4));
    position = l.copy();
    lifespan = 100.0;
    color_control = 255;
  }

  void run()
 {
    update();
    display();
  }

  // Method to update position
  void update()
 {
    
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 4;
    color_control -= 10;
    size-=2 ;
  }
  
  // Method to display
  void display()
 {

    
    fill(255,color_control,0,lifespan);
    circle(position.x, position.y, random(5,10));
  }

  
  boolean isDead() 
  {
    if ( lifespan < 0.0&&size<=0) 
    {
      return true;
    } 
    else {
      return false;
    }
  }
}
