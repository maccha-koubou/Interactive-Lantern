color bg = #000000;
color from = #FF934A;
color to = #FFFFFF;

int peak = int(random(3, 7)); // Number of peaks (vertexes) of the shape
int pointsInGroup = int(map(peak, 3, 6, 30, 15)); // The number of points in a group (each peak is seen as a group) decreases as the peaks increase to keep the point density in a similar level
int pointsInLayer = peak * pointsInGroup;
int layerOfGradient = 9;
int mainLayerNumber = 3;
int pointsInTotal = pointsInLayer * (mainLayerNumber + layerOfGradient * 2);
int indexCount = 0; // Counter for numbering points
float density = 1 / float(pointsInGroup);
float radius = 120; // Radius of affect area of user touch
float time = 0;

float[] random = new float[] {random(-0.3, 0.7), random(-0.3, 0.7), random(-0.3, 0.7)}; // Set random initial rotation angle, speed, and fluctuation for each main wave layer
p[][] mainLayer = new p[mainLayerNumber][pointsInLayer];
p[][] layer12 = new p[layerOfGradient][pointsInLayer];
p[][] layer23 = new p[layerOfGradient][pointsInLayer];

PGraphics textBuffer;
color[] textBufferPixels;
int[] textPixels = new int[pointsInTotal];
String answer = "Answer";
float textWidth;
float textHeight;

void setup() {
  size(1080, 1080);
  textBuffer = createGraphics(width, height);
  background(bg);

  makeTextBuffer();
  pixelsOnText();

  // Initialize points of each wave layer
  for (int i = 0; i < mainLayer.length; i++) {
    for (int j = 0; j < mainLayer[0].length; j++) {
      mainLayer[i][j] = new p(j, i + 1);
    }
  }
  for (int i = 0; i < layer12.length; i++) {
    for (int j = 0; j < layer12[0].length; j++) {
      layer12[i][j] = new p(i, j, 0);
    }
  }
  for (int i = 0; i < layer23.length; i++) {
    for (int j = 0; j < layer23[0].length; j++) {
      layer23[i][j] = new p(i, j, 1);
    }
  }
}

void draw() {
  background(bg);
  drawFrame();
  noStroke();

  // Update and draw the points of the three main wave layers
  for (p p : mainLayer[0]) {
    p.updateMain();
  }
  for (p p : mainLayer[1]) {
    p.updateMain();
  }
  for (p p : mainLayer[2]) {
    p.updateMain();
  }

  // Update and draw the points of the gradient wave layers
  for (int i = 0; i < layer12[0].length; i++) {
    for (int j = 0; j < layer12.length; j++) {
      layer12[j][i].updateGradient();
      layer23[j][i].updateGradient();
    }
  }

  time = (time + 1) % 120;
  delay(20);
}
