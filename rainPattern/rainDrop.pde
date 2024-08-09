class RainDrop {
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();

  RainDrop(int x, int y) {
    pos.set(x, y);
  }

  void update(PVector acc) {
    this.acc = acc.mult(2);
    vel.add(acc);
    vel.limit(3); // Limit the maximum speed to 3
    pos.add(vel);
    acc.mult(0); // Clear the acceleration
    edge();
  }

  // If the raindrop touch the frame edge, teleports it to a random position on the frame
  void edge() {
    if (dist(pos.x, pos.y, width / 2, height / 2) > 390) {
      float t = random(TWO_PI);
      pos.x = int(width / 2 + cos(t) * 390);
      pos.y = int(height / 2 + sin(t) * 390);
    }
  }

  void show() {
    stroke(PatternColor.main);
    strokeWeight(3);
    point(pos.x, pos.y);
  }
}
