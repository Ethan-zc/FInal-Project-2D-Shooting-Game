class Background 
{
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float size = random(1,5);
  Background(PVector l)
 {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 6-size);
    position = l.copy();
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
  }
  
  // Method to display
  void display()
 {
    tint(200);
    fill(100,size*50);
    ellipse(position.x, position.y, size, size);
  }

  // Is the particle still useful?
  boolean isDead() 
  {
    if ( position.y > width && position.y < 0) 
    {
      return true;
    } 
    else {
      return false;
    }
  }
}
