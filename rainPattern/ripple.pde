class ripple {
  PVector pos = new PVector();
  int radius = 0;

  ripple(int x, int y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void update() {
    radius += 3;
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
