import java.util.Iterator;

// global variable
Stalker s;
Walker w;
Barrier b;
Mover[] movers = new Mover[2];
ArrayList<Particle> particles;
int numOfParticles = 1;

void setup() {
  size(800, 400);
  frameRate(30);

  // create objects
  w = new Walker();
  s = new Stalker(width/2, height/2);
  //b = new Barrier(4, 5, 10);
  particles = new ArrayList<Particle>();

  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1, 10), random(width), 15, 15, 0);
  }
}

void draw() {
  background(255);

  // run the walker object
  //w.walk();
  //w.display();

  for (int i = 0; i < movers.length; i++) {
    PVector wind = new PVector(0.01, 0);
    PVector gravity = new PVector(0, 0.1 * movers[i].mass);

    float c = 0.05;
    PVector friction = movers[i].velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    movers[i].applyForce(friction);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].render();
    movers[i].checkEdges();
    
  }



  for (int i = 0; i < numOfParticles; i++) {
    particles.add(new Particle(random(1, 2), random(0, width), random(0, height), random(0.5, 3), random(5, 15)));
  }

  Iterator<Particle> it = particles.iterator();
  while (it.hasNext()) {
    Particle p = it.next();
    p.update();
    if (p.isDead()) {
      it.remove();
    }
  }

  s.seek(movers[0].position);
  s.display();
  s.update();
}

// use for debugging
//void keyPressed() {
//  switch(key) {
//  case ' ':
//    println(movers[0].position);
//    s.seek(movers[0].position);
//    s.display();
//    s.update();
//    println(s.location);
//    break;
//  }
//}