import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup() {
  size(1024, 749, P3D);
  colorMode(HSB);
  
  box = new cube(150, 0.02f, 20, color(30,140,200), width/2, height/2);
  betterBox = new cube(50, 0.04f ,10 ,color(90,70,100), width/2, height/2);
  evenBetterBox = new cube(250, 0.01f, 10, color(90,70,100), width/2, height/2);
  
  minim = new Minim(this);
  ai = minim.getLineIn(Minim.MONO, 512, 44100, 16);
  ap = minim.loadFile("mozart-turkish-march-music-127960.mp3", 512);
  ap.loop();
  ab = ap.mix;
}

float theta = 0;
cube box;
cube betterBox;
cube evenBetterBox;

Minim minim; 
AudioPlayer ap;
AudioInput ai;
AudioBuffer ab;

float average = 0;
float lerpedAverage = 0;

ArrayList<cube> cubes = new ArrayList<cube>();
int numCubes = 0;

void keyPressed(){
  if(key > '0' && key < '9'){
    numCubes = key - '0';
    makeCubes(numCubes);
  }
}

void makeCubes(int count){
  cubes.clear();
  float halfW = width/2;
  float halfH = height/2;
  for (int i = 0; i < count; i++){
    float theta = map(i, 0, count, 0 , TWO_PI);
    float x = halfW + sin(theta) * 400;
    float y = halfH - cos(theta)*400;
    cube lilBox = new cube(0, 0, 0, 0, x, y);
    cubes.add(lilBox);  
  }
}

void draw() {
  
  float total = 0;
  
  for(int i = 0; i < ab.size(); i++){
    total += abs(ab.get(i));
  }
  
  average = total / (float) ab.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.2f);
  
  background(0);
  noStroke();
  
  lights();
  
  float hue = map(lerpedAverage, 0.0f, 1.0f, 0, 255);
  color c = color(hue, 255, 255);
  
  ///scale(zoom, zoom);
  
  box.speed = map(lerpedAverage, 0.0f, 1.0f, 0, 0.1);
  betterBox.speed = map(lerpedAverage, 0.0f, 1.0f, 0, 0.08);
  evenBetterBox.speed = map(lerpedAverage, 0.0f, 1.0f, 0, 0.13);
  
  box.size = map(lerpedAverage, 0.0f, 1.0f, 80, 370);
  betterBox.size = map(lerpedAverage, 0.0f, 1.0f, 10, 180);
  evenBetterBox.size = map(lerpedAverage, 0.0f, 1.0f, 180, 650 );
  
  box.c = c;
  betterBox.c = c;
  evenBetterBox.c = c;
  
  box.update();
  box.render();
  
  betterBox.update();
  betterBox.render();
  
  evenBetterBox.update();
  evenBetterBox.render();

  for(int i = 0; i < cubes.size(); i++){
    
    
    cube current = cubes.get(i);
    current.speed = map(lerpedAverage, 0.0f, 1.0f, 0, 0.1) + random(-0.02,0.02);
    current.size = map(lerpedAverage, 0.0f, 1.0f, 10, 180);
    current.c = c;
    
    current. update();
    current.render();
    
  }

  
}

void mousePressed()
{
 if (ap.isPlaying())
 {
   ap.pause();
 } 
 else
 {
   ap.play();
 }
}
