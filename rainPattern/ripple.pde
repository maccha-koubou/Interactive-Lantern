class ripple {
  PVector pos = new PVector();
  int radius = 0;

  ripple(int x, int y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void update() {
    radius += 3;
    visualize();
  }

  // Draw visualized ripple effect
  void visualize() {
    noFill();
    strokeWeight(3);
    stroke(from, 125 * map(radius, 0, 500, 1, -1));
    circle(pos.x, pos.y, radius);
    if (radius >= 50) {
      stroke(from, 125 * map(radius, 50, 550, 1, -1));
      circle(pos.x, pos.y, radius - 50);
    }
  }
}

// Generate ripples randomly or when the user touches
void generateRipple() {
  if (random(0, 10) <= 0.1) {
    ripples.add(new ripple(int(random(width)), int(random(height))));
  }
  if (mousePressed) {
    ripples.add(new ripple(mouseX, mouseY));
  }
}
