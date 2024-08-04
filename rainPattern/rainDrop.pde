class rain {
  PVector pos = new PVector();
  PVector v = new PVector(); // Velocity
  PVector acc = new PVector(); // Acceleration

  rain(int x, int y) {
    pos.set(x, y);
  }

  void update(PVector acc) {
    this.acc = acc.mult(0.2);
    v.add(acc);
    v.limit(2); // Limit the maximum speed to 2
    pos.add(v);
    acc.mult(0); // Clear the acceleration
    edge();
  }

  // If the raindrop touch the edge, teleports it to the other side
  void edge() {
    if (pos.x < 0) {
      pos.x = 1079;
    } else if (pos.x >= 1079) {
      pos.x = 0;
    }
    if (pos.y < 0) {
      pos.y = 1079;
    } else if (pos.y >= 1079) {
      pos.y = 0;
    }
  }

  void show() {
    stroke(from);
    strokeWeight(3);
    point(pos.x, pos.y);
  }
}
