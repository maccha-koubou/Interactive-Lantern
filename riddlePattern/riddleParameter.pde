class RiddleParameter {
  int peak; // Number of peaks (vertexes) of the shape
  int pointsInGroup, pointsInLayer, pointsInTotal;
  int mainLayer, gradientLayer;
  float density;
  float radius; // Radius of affect area of user touch
  
  RiddleParameter(int minPeak, int maxPeak, int mainLayer, int gradientLayer, float radius) {
    peak = int(random(minPeak, maxPeak));
    pointsInGroup = int(map(peak, minPeak, maxPeak - 1, 90 / minPeak, 90 / maxPeak)); // The number of points in a group (each peak is seen as a group) decreases as the peaks increase to keep the point density in a similar level
    pointsInLayer = peak * pointsInGroup;
    this.mainLayer = mainLayer;
    this.gradientLayer = gradientLayer;
    pointsInTotal = pointsInLayer * (mainLayer + gradientLayer * (mainLayer - 1));
    density = 1 / float(pointsInGroup);
    this.radius = radius;
  }
}
