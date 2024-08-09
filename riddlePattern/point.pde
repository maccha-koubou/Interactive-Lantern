class Point {
  float ang;
  float rad, originalRad;
  PVector pos = new PVector();
  PVector originalPos = new PVector();
  PVector answerPos = new PVector(); // Assigned coordinates on answer text for each point
  float size;
  float progressGo = 0, progressBack = 0;
  int indexInTotal, indexInGroup;
  int layer; 
  int parent, subLayer;
  boolean attracted = false;

  // Constructor of the main wave layer point
  Point(int layer, int i) {
    this.layer = layer;
    indexInGroup = i % riddleParameter.pointsInGroup;
    indexInTotal = indexCount; // Assign a index to each point
    indexCount++;
    
    float fluctuation = sin(TWO_PI * riddleParameter.density * i);
    float scale = (1 / float(layer + 1));
    ang = TWO_PI / (riddleParameter.pointsInLayer) * i + random[layer]; // Random initial angle
    originalRad = map(fluctuation, -1, 1, 350 * scale, 450 * scale);
    size = map(fluctuation, -1, 1, 15 * scale, 10 * scale);
    
    // Assign coordinates on answer text for each point
    answerPos.x = textPixels[indexInTotal] % width;
    answerPos.y = textPixels[indexInTotal] / width;
    
    updateMain();
  }

  // Constructor of the gradient wave layer point
  Point(int parent, int subLayer, int i) {
    this.parent = parent;
    this.subLayer = subLayer;
    indexInGroup = i;
    indexInTotal = indexCount; // Assign a index to each point
    indexCount++;
    
    size = map(subLayer + 1, 0, 10, mainLayer[parent][i].size, mainLayer[parent + 1][i].size);
    
    // Assign coordinates on answer text for each point
    answerPos.x = textPixels[indexInTotal] % width;
    answerPos.y = textPixels[indexInTotal] / width;
    
    updateGradient();
  }

  // Update the main wave layer point
  void updateMain() {
    float t = cos(time / 120 * TWO_PI);
    float fluctuation = sin(TWO_PI * riddleParameter.density * indexInGroup);
    rad = originalRad * map(t, -1, 1, 0.7, map(-fluctuation, -1, 1, random[layer], 1));
    ang = ang + 0.01 * (random[layer] + 0.5);
    // Convert polar coordinates to rectangular coordinates
    originalPos.x = rad * cos(ang) + width / 2;
    originalPos.y = rad * sin(ang) + height / 2;
    if (attracted == false) {
      pos.x = originalPos.x;
      pos.y = originalPos.y;
    }
    show();
    move();
  }

  // Update the gradient wave layer point
  void updateGradient() {
    float aveX = map(subLayer + 1, 0, 10, mainLayer[parent][indexInGroup].originalPos.x, mainLayer[parent + 1][indexInGroup].originalPos.x);
    float aveY = map(subLayer + 1, 0, 10, mainLayer[parent][indexInGroup].originalPos.y, mainLayer[parent + 1][indexInGroup].originalPos.y);
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
    color pointColor = 0;
    float location = sin(TWO_PI * riddleParameter.density * indexInGroup);
    pointColor = lerpColor(PatternColor.main, PatternColor.sub, map(location, -1, 1, -0.5, 1));
    stroke(pointColor);
    strokeWeight(size);
    point(pos.x, pos.y);
  }

  // Points move to the touched answer text when the user touches
  void move() {
    float d = dist(mouseX, mouseY, answerPos.x, answerPos.y);
    if (mousePressed == true && d <= riddleParameter.radius) { // If the assigned answer text coordinates of the point is in the affected area of user's touch point
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
