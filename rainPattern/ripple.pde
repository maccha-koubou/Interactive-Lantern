class ripple {
  PVector pos = new PVector();
  int radius = 0;

  ripple(int x, int y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void update() {
    radius ++;
  }
}
