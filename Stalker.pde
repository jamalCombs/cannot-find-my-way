class Stalker extends Walker {
  float xpos, ypos;
  PVector location;
  PVector velocity;
  ArrayList<PVector> history = new ArrayList<PVector>();
  PVector noff;
  float maxforce;
  float maxspeed;
  float r;
  PVector acceleration;

  Stalker(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, -2);
    location = new PVector(x, y);
    r = 6;
    maxspeed = 4.0;
    maxforce = 0.1;
    //noff = new PVector(random(1000), random(1000));
  }
  // *weird inheritance issue*
  void display() {
    rectMode(CENTER);
    noFill();
    stroke(0);
    rect(location.x, location.y, 16, 16);
  }

  void update() {
    // update velocity
    velocity.add(acceleration);

    // limit speed
    velocity.limit(maxspeed);
    location.add(velocity);

    // reset acceleration to 0 each cycle
    acceleration.mult(0);

    history.add(location.get());
    if (history.size() > 100) {
      history.remove(0);
    }
  }

  void applyForce(PVector force) {
    // apply force or mass here
    acceleration.add(force);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);

    // steering equals desired minus velocity
    PVector steer = PVector.sub(desired, velocity);

    steer.limit(maxforce);

    applyForce(steer);

    return steer;
  }
}