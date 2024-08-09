class Ripple {
  PVector pos = new PVector();
  int r = 0;

  Ripple(int x, int y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void update() {
    r += 3;
    visualize();
  }

  // Draw visualized ripple effect
  void visualize() {
    noFill();
    strokeWeight(3);
    stroke(PatternColor.main, 125 * map(r, 0, 500, 1, -1));
    circle(pos.x, pos.y, r);
    if (r >= 50) {
      stroke(PatternColor.main, 125 * map(r, 50, 550, 1, -1));
      circle(pos.x, pos.y, r - 50);
    }
  }
}

// Generate ripples randomly or when the user touches
void generateRipple() {
  if (random(0, 10) <= 0.1) {
    ripples.add(new Ripple(int(random(width)), int(random(height))));
  }
  if (mousePressed) {
    ripples.add(new Ripple(mouseX, mouseY));
  }
}
