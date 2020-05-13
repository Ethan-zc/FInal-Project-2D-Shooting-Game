class Menustar 
{
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float size = random(10,14);
  private float r = random(0,200), g =  random(100,200), b = random(200,255);
  Menustar(PVector l)
 {
    acceleration = new PVector(0, 0);
    velocity = new PVector(4, 0);
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
    fill(r,g,b);
    rect(position.x, position.y, size, size);
  }


  boolean isDead() 
  {
    if ( position.x > height && position.x < 0) 
    {
      return true;
    } 
    else {
      return false;
    }
  }
}
