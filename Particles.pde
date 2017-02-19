class Particle {
  float x; 
  float y; 
  float dx;
  float dy;
  float lifespan;
  float sensitivity;
  float acceleration = 0.0;
  float acceleratorSpeed;
  float diffuse;

  Particle(float sensitivity_, float x_, float y_, float acceleratorSpeed_, float diffuse_) {
    x = x_;
    y = y_;
    lifespan = 0;
    sensitivity = sensitivity_;
    acceleratorSpeed = acceleratorSpeed_;
    diffuse = diffuse_;

    if (sensitivity <= 1.5) {
      if (y < height / 2) {
        y = -10;
      } else {
        y = height + 10;
      }
      dy = random(-4, 4);
      dx = 0;
    } else {
      if (x < width / 2) {
        x = -10;
      } else {
        x = width + 10;
      }
      dx = random(-4, 4);
      dy = 0;
    }
  }

  void update() {
    x += dx;
    y += dy;
    lifespan += 2;
    noFill();
    stroke(0);
    ellipse(x + sin(radians(acceleration)) * diffuse, y + cos(radians(acceleration)) * diffuse, 8, 8);
    acceleration += acceleratorSpeed;
  }

  boolean isDead() {
    if (lifespan > 255.0) {
      return true;
    } else {
      return false;
    }
  }
}