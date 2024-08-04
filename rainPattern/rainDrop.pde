class rain {
  PVector pos = new PVector();
  PVector v = new PVector();

  rain(int x, int y) {
    pos.set(x, y);
  }

  void update(PVector v) {
    this.v = v.mult(2);
    pos.add(v);
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
    strokeWeight(10);
    point(pos.x, pos.y);
  }
}
