class p {
  float t; // Angular coordinate
  float r, originalR; // Current radial coordinate and original radial coordinate
  PVector pos = new PVector(); // Current rectangular coordinates
  PVector originalPos = new PVector(); // Original rectangular coordinates
  PVector answerPos = new PVector(); // Assigned coordinates on answer text for each point
  float size;
  float progressGo = 0, progressBack = 0; // Progress of the point in the moving process
  int indexInTotal, indexInGroup; // Index of the point in all the points and in the current group
  int layer; // Layer of the point in the main wave layers
  int parent, subLayer; // Parent layer and sub layer of the point in gradient wave layers
  boolean attracted = false;

  // Constructor of the main wave layer point
  p(int i, int l) {
    layer = l;
    indexInTotal = indexCount; // Assign a index to each point
    indexCount++;
    indexInGroup = i % pointsInGroup;
    t = TWO_PI / (pointsInLayer) * i + random[layer - 1]; // Random initial angle
    originalR = map(sin(TWO_PI * density * i), -1, 1, 350 * (1 / float(layer)), 450 * (1 / float(layer)));
    size = map(sin(TWO_PI * density * i), -1, 1, 15 * (1 / float(layer)), 10 * (1 / float(layer)));
    answerPos.x = textPixels[indexInTotal] % width; // Assign coordinates on answer text for each point
    answerPos.y = textPixels[indexInTotal] / width;
    updateMain();
  }

  // Constructor of the gradient wave layer point
  p(int i, int j, int p) {
    parent = p;
    subLayer = i;
    indexInTotal = indexCount; // Assign a index to each point
    indexCount++;
    indexInGroup = j;
    size = map(i + 1, 0, 10, mainLayer[p][j].size, mainLayer[p+1][j].size);
    answerPos.x = textPixels[indexInTotal] % width; // Assign coordinates on answer text for each point
    answerPos.y = textPixels[indexInTotal] / width;
    updateGradient();
  }

  // Update the main wave layer point
  void updateMain() {
    r = originalR * map(cos(time/120 * TWO_PI), -1, 1, 0.7, map(-sin(TWO_PI * density * indexInGroup), -1, 1, random[layer - 1], 1));
    t = t+0.01*(random[layer - 1] + 0.5);
    // Convert polar coordinates to rectangular coordinates
    originalPos.x = r * cos(t) + width / 2;
    originalPos.y = r * sin(t) + height / 2;
    if (attracted == false) {
      pos.x = originalPos.x;
      pos.y = originalPos.y;
    }
    show();
    move();
  }

  // Update the gradient wave layer point
  void updateGradient() {
    float aveX = map(subLayer + 1, 0, 10, mainLayer[parent][indexInGroup].originalPos.x, mainLayer[parent+1][indexInGroup].originalPos.x);
    float aveY = map(subLayer + 1, 0, 10, mainLayer[parent][indexInGroup].originalPos.y, mainLayer[parent+1][indexInGroup].originalPos.y);
    originalPos.x = aveX;
    originalPos.y = aveY;
    if (attracted == false) {
      pos.x = aveX;
      pos.y = aveY;
    }
    show();
    move();
  }

  // Draw points
  void show() {
    stroke(lerpColor(from, to, map(sin(TWO_PI * density * indexInGroup), -1, 1, -0.5, 1))); // Calculate gradient color
    strokeWeight(size);
    point(pos.x, pos.y);
  }

  // Points move to the touched answer text when the user touches
  void move() {
    float d = dist(mouseX, mouseY, answerPos.x, answerPos.y);
    if (mousePressed == true && d <= radius) { // If the assigned answer text coordinates of the point is in the affected area of user's touch point
      attracted = true;
      progressBack = 0;
      progressGo += 0.1;
      pos.x = lerp(pos.x, answerPos.x, progressGo); // The point moves to the assigned answer text coordinates
      pos.y = lerp(pos.y, answerPos.y, progressGo);
    } else if (attracted) { // If the user is not touching, but the point is still in the attracted status
      progressGo = 0;
      progressBack += 0.1;
      pos.x = lerp(pos.x, originalPos.x, progressBack); // The point moves back to its original coordinates
      pos.y = lerp(pos.y, originalPos.y, progressBack);
      if (progressBack >= 1) {
        progressBack = 0;
        attracted = false; // Change the attracted status if the point has already moved back
      }
    }
  }
}
