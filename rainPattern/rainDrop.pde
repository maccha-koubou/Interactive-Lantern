class RainDrop {
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  color rainDropColor = PatternColor.main;

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
    updateColor();
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
    stroke(rainDropColor);
    strokeWeight(3);
    point(pos.x, pos.y);
  }
  
  void updateColor() {
    float colorNoise = noise(pos.x * 0.01, pos.y * 0.01, zoff);
    switch (PatternColor.lv) { // Calculate gradient color based on the pattern level
    case 0 :
      rainDropColor = lerpColor(PatternColor.main, PatternColor.lv0, map(colorNoise, 0, 1, -2, 2));
      break;
    case 1 :
      if (colorNoise < 0.5) rainDropColor = lerpColor(PatternColor.main, PatternColor.lv0, map(colorNoise, 0, 0.5, -2, 1));
      else rainDropColor = lerpColor(PatternColor.lv0, PatternColor.lv1, map(colorNoise, 0.5, 1, 0, 5));
      break;
    case 2 :
      if (colorNoise < 0.5) rainDropColor = lerpColor(PatternColor.main, PatternColor.lv0, map(colorNoise, 0, 0.5, -2, 1));
      else if (colorNoise < 0.6) rainDropColor = lerpColor(PatternColor.lv0, PatternColor.lv1, map(colorNoise, 0.5, 0.6, 0, 1));
      else rainDropColor = lerpColor(PatternColor.lv1, PatternColor.lv2, map(colorNoise, 0.6, 1, 0, 3));
      break;
    }
  }
}
