// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;

  float segments = 50;
  float numAngles = TWO_PI / segments;
  float noiseScale = 0.5;
  float timeScale = 0.1;
  float timeDiff = 1000;

  float dx, dy;

  float timeUnique = random(timeDiff);
  int x, y;
  int minRad, maxRad;


  Mover(float m, float x, int minSize, int maxSize, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    minRad = (int) minSize;
    maxRad = (int) maxSize;
  }


  void render() {
    translate(position.x, position.y);
    stroke(0);

    findNextCoords(0);
    float px = dx, py = dy;
    int i = 0;

    while (i++ != segments) {
      findNextCoords(i);
      line(px, py, px = dx, py = dy);
    }

    resetMatrix();
    //ellipse(position.x, position.y, mass * 16, mass * 16);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void checkEdges() {
    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      position.x = 0;
      velocity.x *= -1;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    }
  }

  void findNextCoords(int seg) {
    float angle = numAngles * seg;
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    float time = timeScale * frameCount + timeUnique;

    float noiseValue = noise(noiseScale * cosAngle + noiseScale, noiseScale * sinAngle + noiseScale, time);
    
    float rad = maxRad * noiseValue + minRad;
    
    dx = rad * cosAngle;
    dy = rad * sinAngle;
  }
}