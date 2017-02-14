class Barrier {
  ArrayList<Particle> particles;
  float xpos;
  float ypos; 

  // barrier will extend along x and y axes
  float extend;

  Barrier(float ext, float x, float y) {
    extend = ext;
    ypos = y;
    xpos = x;
  }
  
  void update() {
    extend = xpos + ypos;
  }

  void display() {
    stroke(0);
    point(30, 75);
  }
}