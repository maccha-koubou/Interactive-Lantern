class PatternColor {
  static final color bg = #000000;
  static final color main = #FF934A;
  static final color sub = #FFFFFF;

  private PatternColor() {}
}

// Draw the frame
void drawFrame() {
  noFill();
  stroke(PatternColor.main);
  strokeWeight(2);
  circle(width / 2, height / 2, 800);
  strokeWeight(10);
  circle(width / 2, height / 2, 780);
}

// Generate ripple effects when t = 0 or t = 10
void drawRipples(float t) {
  noFill();
  strokeWeight(2);
  if (t <= 80) {
    stroke(PatternColor.main, 255 * map(t, 0, 80, 1, -1));
    circle(width / 2, height / 2, 780 * map(t, 0, 80, 1, 0));
  }
  if (t >= 10 && t <= 90) {
    stroke(PatternColor.main, 255 * map(t, 10, 90, 1, -1));
    circle(width / 2, height / 2, 780 * map(t, 10, 90, 1, 0));
  }
}
