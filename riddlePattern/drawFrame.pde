// Draw the frame
void drawFrame() {
  noFill();
  stroke(from);
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
    stroke(from, 255 * map(t, 0, 80, 1, -1));
    circle(width / 2, height / 2, 780 * map(t, 0, 80, 1, 0));
  }
  if (t >= 10 && t <= 90) {
    stroke(from, 255 * map(t, 10, 90, 1, -1));
    circle(width / 2, height / 2, 780 * map(t, 10, 90, 1, 0));
  }
}
