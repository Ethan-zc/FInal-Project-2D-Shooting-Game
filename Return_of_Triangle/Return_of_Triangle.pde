import processing.sound.*;
SoundFile normal_situation;
SoundFile boss_situation;
SoundFile fire;
SoundFile victory;
public ArrayList<Bullet> bullets = new ArrayList<Bullet>();
public ArrayList<Enemy>  enemies = new ArrayList<Enemy>();
public Boss Big_boss;
//public Enemy_group enemies_group;
public ArrayList<Boom> booms = new ArrayList<Boom>();
public ArrayList<Background> particles = new ArrayList<Background>();
public ArrayList<Menustar> menustar = new ArrayList<Menustar>();
public ArrayList<Boss_attack> boss_attacks = new ArrayList<Boss_attack>();
public ArrayList<Enemy_bullet> enemy_bullets = new ArrayList<Enemy_bullet>();
public int lvl = 1, kills = 0, lives = 3;
//public boolean allowCheats = true;


public int [] gameKeys = { 32 , 37 , 38, 39 , 40 };
public boolean [] keyStates = { false , false , false , false, false };
public Ship ship;
public boolean start = false;
public boolean Spawn_enemy = true;
public boolean Spawn_boss = false;
public boolean Boss_alive = false;

void setup()
{
  size(800, 1000);
  frameRate(60);
  noStroke();
  //surface.setTitle("Shoot them up! FrameRate: " + frameRate);
  
  ship = new Ship(20); 
  normal_situation = new SoundFile(this, "normal.mp3");
  //normal_situation.play();
  fire = new SoundFile(this, "fire.mp3");
  boss_situation = new SoundFile(this, "BOSS.mp3");
  victory = new SoundFile(this, "victory.mp3");
}

void keyPressed()
{
  
  manageKeys(keyCode, true); 
}

void keyReleased()
{
  manageKeys(keyCode, false);
}

void draw()
{
  surface.setTitle("Shoot them up! FrameRate: " + int(frameRate));
  if (ship.isAlive){
    
    if(frameCount%10==0){
      particles.add(new Background(new PVector(random(0,width), 0)));
    }
    
     for (int i = particles.size()-1; i >= 0; i--)
      {
        Background p = particles.get(i);
        p.run();
        if (p.isDead())
        {
          particles.remove(i);
        }
    }
    
    fill(random(0,lvl),random(0,lvl*1.5),random(0,lvl*2),14);
    rect(0,0,width,height);
    //background(0);
    if(!start){
      GameStart();
    }

    if(start){
     //Text
     if (normal_situation.isPlaying()==false && Spawn_enemy == true) {
       normal_situation.play();
     }
      textSize(100);
      fill(100);
      textAlign(CENTER, CENTER);
      text( "\nLevel " + lvl + "\nKills " + kills + "\nLives " + lives + "\n", width /2, height /2);
    
      //Move ship
      if (keyStates[1]  && ship.x - ship.w > 0)      ship.x -= 5;
      if (keyStates[3]  && ship.x + ship.w < width)  ship.x += 5;
      if (keyStates[2]  && ship.y - ship.h > 0)      ship.y -= 5;
      if (keyStates[4]  && ship.y + ship.h < height) ship.y += 5;
    
      //Fire bullet

      if (keyStates[0]){
        if(frameCount%10 == 0){
          //fire.play();
          if(lvl < 5){
            bullets.add(new Bullet(new PVector(ship.x, ship.y - ship.h / 2), 10,0));
          }
      
        else if(lvl >= 5 && lvl < 10){
          bullets.add(new Bullet(new PVector(ship.x-20, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+20, ship.y - ship.h / 2), 10,0));
        }
        else if(lvl >= 10 && lvl < 20){
          bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,0));
        }
        else if(lvl >= 20 && lvl < 25){
          bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,1));
          bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,2));
        }
        else if(lvl >= 25&& lvl < 30){
          bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,1));
          bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,1));
          bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x-20, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+20, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,2));
          bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,2));
        }
    
    
        //else if(lvl >= 30 && lvl < 40){
      
        //  bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,1));
        //  bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,1));
        //  bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,0));
        //  bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,0));
        //  bullets.add(new Bullet(new PVector(ship.x, ship.y - ship.h / 2), 10,0));
        //  bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,0));
        //  bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,0));
        //  bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,2));
        //  bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,2));
        //}
        else {
      
          bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,1));
          bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,1));
          bullets.add(new Bullet(new PVector(ship.x-25, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x-50, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,0));
          bullets.add(new Bullet(new PVector(ship.x+25, ship.y - ship.h / 2), 10,2));
          bullets.add(new Bullet(new PVector(ship.x+50, ship.y - ship.h / 2), 10,2));
        }
      }
  }
    //Spawn enemies
    if (frameCount % 15 == 0 && Spawn_enemy == true){
      
      float s = random(20, 270);
      float x = random(s, width - s);
      float sp = random(0.5, 2);
      int hp = int(random(1, lvl));
      enemies.add(new Enemy(new PVector(x, -2*s), s, sp, hp));
      //if(lvl == 9){
      //enemies.add(new Enemy(new PVector(width / 2, -10), 500, 0.5, 500));
      //}
    } 
    else if (Spawn_boss == true) {
      //float s = 270;
      //float x = width / 2;
      //float sp = 0.5;
      //int hp = 50;
      Big_boss = new Boss();
      Spawn_boss = false;
      Boss_alive = true;
    }
    
    //Update
    if (Boss_alive) Big_boss.update();
    //for (Enemy_bullet e_b:enemy_bullets) e_b.update();
    for (Enemy e : enemies) e.update(enemies);
    for (Bullet b: bullets) b.update();

    
    
    //Draw
    if (Boss_alive) Big_boss.draw();
    //for (Enemy_bullet e_b:enemy_bullets) e_b.draw();
    for (Enemy e : enemies) e.draw();
    for (Bullet b: bullets) b.draw();
    
    for (Enemy_bullet e_b:enemy_bullets) e_b.update();
    for (Enemy_bullet e_b:enemy_bullets) e_b.draw();
    
    ship.draw();
    
    //Loop through each enemy
    for (int e = enemies.size() - 1; e >= 0; e--){
      
      //if (random(1) < 0.5) {
      //  enemy_bullets.add(new Enemy_bullet(e.p.x, e.p.y));
      //}
      
      Enemy en = enemies.get(e); 
      //if (random(1) < 0.5) {
      //  enemy_bullets.add(new Enemy_bullet(en.p, 10));
      //}
      //Enemy makes it all the way to the bottom, if it does, dont check hit() since enemy is gone off screen
      if (en.p.y - en.s / 2 > height){
        
        //background(255);
        //if (--lives == 0) {
        //  fill(0);
        //  rect(0,0,width,height);
        //  textSize(200);
        //  fill(255,0,0);
        //  textAlign(CENTER, CENTER);
        //  text("Game \n Over", width /2, height /2);
        //  textSize(30);
        //  fill(255);
        //  text("Your score:"+kills, width /2, height -170);
        //  ship.isAlive = false;
        //}
        
        enemies.remove(e);
      }
      else {
        //Loop through each bullet
        for (int b = bullets.size() - 1; b >= 0; b--){
          //If bullet leaves screen, remove it and dont loop through all enemies since bullet is gone
          if (bullets.get(b).p.y < 0) 
          {
            bullets.remove(b);
          }
          else if ( hit(enemies.get(e), bullets.get(b)) )
          {
            bullets.remove(b);
            
            if (--en.hp == 0)  
            {
              if (++kills % 5 == 0)
              {
                if (++lvl == 40) 
                {
                  //fill(255,50);
                  //rect(0,0,width,height);
                  //textSize(200);
                  //fill(0,255,0);
                  //textAlign(CENTER, CENTER);
                  //text("YOU \n WIN!", width /2, height /2);
                  //ship.isAlive = false;
                  print("Boss!");
                  Spawn_enemy = false;
                  Spawn_boss = true;
                  normal_situation.stop();
                }
                if (kills % 20 == 0) {
                  ++lives;
                }
              }
              enemies.remove(e);
              //Enemy is gone, stop checking against next bullet
              for(int i = 0; i <= 200; i++) {
                booms.add(new Boom(new PVector(en.p.x,en.p.y)));}
              enemy_bullets.add(new Enemy_bullet(en.p, 20));
              b = -1;
            }
          }
          else if ( Boss_alive == true ) {
            if (boss_situation.isPlaying() == false && Boss_alive == true) {
              boss_situation.play();
            }
            if (hit_boss(Big_boss, bullets.get(b))) {
              bullets.remove(b);
              if (--Big_boss.hp == 0) {
                  fill(0);
                  rect(0,0,width,height);
                  textSize(200);
                  fill(0,255,0);
                  textAlign(CENTER, CENTER);
                  text("YOU \n WIN!", width /2, height /2);
                  ship.isAlive = false;
                  Boss_alive = false;
                  boss_situation.stop();
                  if (victory.isPlaying() == false) {
                    victory.play();
                  }
              }
            }
          }
        }
        if (enemy_bullets.size() != 0) {
        for (int e_b = enemy_bullets.size()-2; e_b > -1; e_b--) {
          boolean hit = hit_enemy_b(enemy_bullets.get(e_b), ship);
          if (hit == true) {
            //print("hits!");
            enemy_bullets.remove(e_b);
            background(255);
            lives = lives - 1;
          }
          if (enemy_bullets.get(e_b).p.y > 1000) {
            //print("remove\n");
            enemy_bullets.remove(e_b);
          }
          //else if (hit_enemy_b(enemy_bullets.get(e_b), ship)) {
          //  print("hits!");
          //  enemy_bullets.remove(e_b);
          //  background(255);
          //  lives = lives - 1;
          //  //if (lives == 0) {
          //  //  fill(0);
          //  //  rect(0,0,width,height);
          //  //  textSize(200);
          //  //  fill(255,0,0);
          //  //  textAlign(CENTER, CENTER);
          //  //  text("Game \n Over", width /2, height /2);
          //  //  textSize(30);
          //  //  fill(255);
          //  //  text("Your score:"+kills, width /2, height -170);
          //  //  ship.isAlive = false;
             
          //  //}
          //}
          
          
        }
      }  
      }
    } 
    //for (Enemy_bullet e_b:enemy_bullets) e_b.update();
    //for (Enemy_bullet e_b:enemy_bullets) e_b.draw();
    
    if ( Boss_alive == true ) {
      if (Big_boss.hp > 300) {
        if (boss_attacks.size() == 0) {
          boss_attacks.add(new Boss_attack(Big_boss.p.x, Big_boss.p.y));
        }
      }else if (Big_boss.hp > 150 && Big_boss.hp < 300) {
        if (boss_attacks.size() < 2) {
          boss_attacks.add(new Boss_attack(Big_boss.p.x, Big_boss.p.y));
        }
      } else if (Big_boss.hp < 150) {
        if (boss_attacks.size() < 3) {
          boss_attacks.add(new Boss_attack(Big_boss.p.x, Big_boss.p.y));
        }
      }
      for (int i = 0; i < boss_attacks.size(); i++) {
        boolean hit = boss_attacks.get(i).update(ship.x, ship.y);
        if (hit == true) {
          background(255);
          if (--lives == 0) {
            fill(0);
            rect(0,0,width,height);
            textSize(200);
            fill(255,0,0);
            textAlign(CENTER, CENTER);
            text("Game \n Over", width /2, height /2);
            textSize(30);
            fill(255);
            text("Your score:"+kills, width /2, height -170);
            ship.isAlive = false;
          }
        }
        if (boss_attacks.get(i).isDone()) {
          boss_attacks.remove(i);
        }
      }
      //for (int b = bullets.size() - 1; b >= 0; b--) {
      //  if (hit_boss(Big_boss, bullets.get(b))) {
          
      //    bullets.remove(b);
      //     if (--Big_boss.hp == 0) {
      //       fill(255,50);
      //       rect(0,0,width,height);
      //       textSize(200);
      //       fill(0,255,0);
      //       textAlign(CENTER, CENTER);
      //       text("YOU \n WIN!", width /2, height /2);
      //       ship.isAlive = false;
      //       boss_situation.stop();
      //     }
      //  }
      //}
    }
  }
}

for (int i = booms.size()-1; i >= 0; i--)
  {
    Boom o = booms.get(i);
    o.run();
    if (o.isDead())
    {
      booms.remove(i);
    }
  }
}


public boolean hit(Enemy e, Bullet b)
{
  //PVector boss_center = new PVector(e.p.x, e.p.y);
  //PVector bullet_center = new PVector(b.p.x, b.p.y);
  //PVector corner_point = new PVector(0,0);
  //PVector bullet_vector = new PVector(0,0);
  //float max = Float.NEGATIVE_INFINITY;
  //boolean result =false;
   
  //PVector bullet2boss = boss_center.sub(bullet_center);
  //bullet2boss = bullet2boss.normalize();
  
  //int i = 0;
  //for (i = 0; i < 4; i++) {
  //  corner_point = b.corner_points.get(i);
  //  bullet_vector = new PVector(corner_point.x - bullet_center.x, corner_point.y - bullet_center.y);
  //  float project = bullet_vector.dot(bullet2boss);
    
  //  if (max < project) max = project;
  //}
  
  //if (bullet2boss.mag() - max - e.s > 0 && bullet2boss.mag() > 0) result = true;
  //else result = false;
  return (dist(b.p.x, b.p.y, e.p.x, e.p.y) < e.s / 2);
  //return result;
}

public boolean hit_enemy_b(Enemy_bullet e, Ship p) {
  
  PVector ship_position = new PVector(p.x, p.y);
  PVector particle_position = new PVector(e.p.x, e.p.y);
  //print("hit!\n");
  return (ship_position.sub(particle_position).mag() < 10);
  
}

public boolean hit_boss(Boss boss, Bullet b) 
{
  //PVector boss_center = new PVector(boss.p.x, boss.p.y);
  //PVector bullet_center = new PVector(b.p.x, b.p.y);
  ////PVector corner_point = new PVector(0,0);
  //PVector bullet_vector = new PVector(0,0);
  //ArrayList<PVector> norms = getNorms(b);
  //float max = Float.NEGATIVE_INFINITY;
  //boolean result =false;
   
  //PVector bullet2boss = boss_center.sub(bullet_center);
  //bullet2boss = bullet2boss.normalize();
  
  //int i = 0;
  //for (i = 0; i < 4; i++) {
  //  //corner_point = b.corner_points.get(i);
  //  //bullet_vector = new PVector(corner_point.x - bullet_center.x, corner_point.y - bullet_center.y);
  //  bullet_vector = norms.get(i);
  //  float project = bullet_vector.dot(bullet2boss);
    
  //  if (max < project) max = project;
  //}
  //boolean horizontal_collision = false;
  //boolean vertical_collision = false;
  //PVector boss_lower_point = new PVector(boss.p.x, boss.p.y + 300);
  //PVector boss_upper_point = new PVector(boss.p.x, boss.p.y - 300);
  //PVector boss_left_point = new PVector(boss.p.x-300, boss.p.y);
  //PVector boss_right_point = new PVector(boss.p.x+300, boss.p.y);
  
  //vertical_collision = doIntersect(boss_upper_point, boss_lower_point, b.corner_points.get(0), b.corner_points.get(1));
  //horizontal_collision = doIntersect(boss_left_point, boss_right_point, b.corner_points.get(1), b.corner_points.get(2));
  
  
  ////if (horizontal_collision == true && vertical_collision == true) result = true;
  //if (vertical_collision == true) result = true;
  //else result = false;
  //print(result);
  
  //return result;
  return (dist(b.p.x, b.p.y, boss.p.x, boss.p.y) < boss.s / 2);
}

public ArrayList<PVector> getNorms(Bullet b) {
  ArrayList<PVector> norms = new ArrayList<PVector>();
  for (int i = 0; i < 3 ; i++) {
    PVector current_normal = new PVector(b.corner_points.get(i+1).x - b.corner_points.get(i).x, b.corner_points.get(i+1).y - b.corner_points.get(i).y);
    current_normal = current_normal.normalize();
    norms.add(current_normal);
  }
  
  PVector normal = new PVector(b.corner_points.get(0).x - b.corner_points.get(3).x, b.corner_points.get(0).y - b.corner_points.get(3).y);
  normal = normal.normalize();
  norms.add(normal);
  
  return norms;

}

public boolean onSegment(PVector p, PVector q, PVector r) 
{ 
    if (q.x <= Math.max(p.x, r.x) && q.x >= Math.min(p.x, r.x) && 
        q.y <= Math.max(p.y, r.y) && q.y >= Math.min(p.y, r.y)) 
    return true; 
  
    return false; 
}

public int orientation(PVector p, PVector q, PVector r) 
{ 
     
    float val = (q.y - p.y) * (r.x - q.x) - 
            (q.x - p.x) * (r.y - q.y); 
  
    if (val == 0) return 0; // colinear 
  
    return (val > 0)? 1: 2; // clock or counterclock wise 
}

public boolean doIntersect(PVector p1, PVector q1, PVector p2, PVector q2) 
{ 
    // Find the four orientations needed for general and 
    // special cases 
    int o1 = orientation(p1, q1, p2); 
    int o2 = orientation(p1, q1, q2); 
    int o3 = orientation(p2, q2, p1); 
    int o4 = orientation(p2, q2, q1); 
  
    // General case 
    if (o1 != o2 && o3 != o4) 
        return true; 
  
    // Special Cases 
    // p1, q1 and p2 are colinear and p2 lies on segment p1q1 
    if (o1 == 0 && onSegment(p1, p2, q1)) return true; 
  
    // p1, q1 and q2 are colinear and q2 lies on segment p1q1 
    if (o2 == 0 && onSegment(p1, q2, q1)) return true; 
  
    // p2, q2 and p1 are colinear and p1 lies on segment p2q2 
    if (o3 == 0 && onSegment(p2, p1, q2)) return true; 
  
    // p2, q2 and q1 are colinear and q1 lies on segment p2q2 
    if (o4 == 0 && onSegment(p2, q1, q2)) return true; 
  
    return false; // Doesn't fall in any of the above cases 
}


public void manageKeys(int code, boolean state) 
{
  for (int i = 0; i < gameKeys.length; i++)
  {
    if (gameKeys[i] == code) keyStates[i] = state;
  }
}


int colors = 0;
int cc = 2;
void GameStart()
{
  textSize(100);
   colors= colors +cc;
   if(colors >=255){
   cc = cc*-1;
   }
    if(colors <=0)
    {
    cc = cc*-1;
    }
  if(frameCount%10==0){
  menustar.add(new Menustar(new PVector(0, random(180,200))));
  menustar.add(new Menustar(new PVector(0, random(630,650))));
    }
    
     for (int i = particles.size()-1; i >= 0; i--)
      {
        Menustar m = menustar.get(i);
        m.run();
        if (m.isDead())
        {
          particles.remove(i);
        }
      }
  
  
  fill(colors);
  textAlign(CENTER, CENTER);
  text("Return\nof\nRectangle",width/2,height/2-100);

  textSize(30);
  fill(255);
  text("As the last pilot of Rectangle Republica\n Fight back at Circle Empire!", width /2, height /2+300);
  text("\n Arrow keys to move \n Space key to shoot bullet \n Beat boss to win!", width /2, height /2+400);
  fill(colors);
  text("Press 'space' to star!", width /2, height /2+200);
  if (keyStates[0])
    {
      start = true;
      background(255);
    }
  
}
