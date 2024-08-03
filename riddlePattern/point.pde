class p {
  float t; // Angular coordinate
  float r, originalR; // Radial coordinate
  PVector pos = new PVector();
  float size;
  int indexInGroup, layer, parent, subLayer;
  boolean attracted = false;

  p(int i, int l) {
    layer = l;
    indexInGroup = i % pointsInGroup;
    t = TWO_PI / (pointsInLayer) * i + random[layer - 1]; // Random initial angle
    originalR = map(sin(TWO_PI * density * i), -1, 1, 250 * (1 / float(layer)), 350 * (1 / float(layer)));
    size = map(sin(TWO_PI * density * i), -1, 1, 15 * (1 / float(layer)), 10 * (1 / float(layer)));
    updateMain();
  }

  p(int i, int j, int p) {
    parent = p;
    subLayer = i;
    indexInGroup = j;
    size = map(i + 1, 0, 10, mainLayer[p][j].size, mainLayer[p+1][j].size);
    updateGradient();
  }

  void updateMain() {
    r = originalR * map(cos(time/120 * TWO_PI), -1, 1, 0.7, map(sin(TWO_PI * density * indexInGroup), -1, 1, random[layer - 1], 1));
    t = t+0.01*(random[layer - 1] + 0.5);
    pos.x = r * cos(t) + width / 2; // Convert polar coordinates to rectangular coordinates
    pos.y = r * sin(t) + height / 2;
    show();
  }

  void updateGradient() {
    float aveX = map(subLayer + 1, 0, 10, mainLayer[parent][indexInGroup].pos.x, mainLayer[parent+1][indexInGroup].pos.x);
    float aveY = map(subLayer + 1, 0, 10, mainLayer[parent][indexInGroup].pos.y, mainLayer[parent+1][indexInGroup].pos.y);
    pos.x = aveX;
    pos.y = aveY;
    show();
  }

  void show() {
    stroke(lerpColor(from, to, map(sin(TWO_PI * density * indexInGroup), -1, 1, -0.5, 1))); // Calculate gradient color
    strokeWeight(size);
    point(pos.x, pos.y);
  }

  void move() {
    if (mousePressed == true) {
      
    }
  }
}
