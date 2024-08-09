RiddleParameter riddleParameter = new RiddleParameter(3, 7, 3, 9, 120);
int indexCount = 0; // Counter for numbering points
float time = 0;

float[] random = new float[] {random(-0.3, 0.7), random(-0.3, 0.7), random(-0.3, 0.7)}; // Set random initial rotation angle, speed, and fluctuation for each main wave layer
Point[][] mainLayer = new Point[riddleParameter.mainLayer][riddleParameter.pointsInLayer];
Point[][][] gradientLayer = new Point[riddleParameter.mainLayer - 1][riddleParameter.gradientLayer][riddleParameter.pointsInLayer];

Answer answer;
PGraphics textBuffer;
color[] textBufferPixels;
int[] textPixels = new int[riddleParameter.pointsInTotal];

PShader glow;

void setup() {
  size(1080, 1080, P2D);
  background(PatternColor.bg);
  
  Answer answer = new Answer("Answer");
  answer.makeTextBuffer();
  answer.pixelsOnText();

  glow = loadShader("glow.glsl");
  glow.set("resolution", float(width), float(height)); // Convey the window resolution to the shader

  // Initialize points of each wave layer
  for (int i = 0; i < mainLayer.length; i++) {
    for (int j = 0; j < mainLayer[0].length; j++) {
      mainLayer[i][j] = new Point(i, j);
    }
  }
  for (int i = 0; i < gradientLayer.length; i++) {
    for (int j = 0; j < gradientLayer[i].length; j++) {
      for (int k = 0; k < gradientLayer[i][j].length; k++) {
        gradientLayer[i][j][k] = new Point(i, j, k);
      }
    }
  }
}

void draw() {
  background(PatternColor.bg);
  drawFrame();
  drawRipples(time);
  noStroke();

  // Update and draw the points of the three main wave layers
  for (Point[] pLayer: mainLayer){
    for (Point p : pLayer) {
      p.updateMain();
    }
  }

  // Update and draw the points of the gradient wave layers
  for (Point[][] pParentLayer: gradientLayer){
    for (Point[] pLayer : pParentLayer) {
      for (Point p : pLayer) {
        p.updateGradient();
      }
    }
  }

  time = (time + 1) % 120;
  delay(15);

  // Convey the current window image to the shader and apply the shader on it
  glow.set("texture", get());
  filter(glow);
}
