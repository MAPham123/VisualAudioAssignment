  public class cube
  {
    float size;
    float speed;
    float theta;
    color c;
    PVector pos;
    
    cube()
    {  
      this(100,0,0,color(0,0,0),width/2,height/2);
    }
    
    cube(float size, float speed, float theta, color c, float x, float y)
    {
        this.size = size;
        this.speed = speed;
        this.theta = theta;
        this.c = c;
        this.pos = new PVector(x,y);
    }
    
    void update(){
      theta += speed;
    }
    
    void render()
    {
      pushMatrix();
      
      stroke(c);
      strokeWeight(2);
      noFill();
      
      translate(pos.x,pos.y);
      rotateX(theta);
      rotateZ(theta);
      fill(c);
      box(size);
      popMatrix();
    }
  }
