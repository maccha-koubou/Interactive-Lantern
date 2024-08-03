color bg = 0;
color from = #FF934A;
color to = #FFFFFF;

int peak = int(random(3, 7));
int pointsInGroup = int(map(peak, 3, 6, 30, 15));
int pointsInLayer = peak * pointsInGroup;
int layerOfGradient = 9;
int mainLayerNumber = 3;
float density = 1 / float(pointsInGroup);
float radius = 120;
String answer = "Answer";
float time = 0;

float[] random = new float[] {random(-0.7, 0.7), random(-0.7, 0.7), random(-0.7, 0.7)};
p[][] mainLayer = new p[mainLayerNumber][pointsInLayer];
p[][] layer12 = new p[layerOfGradient][pointsInLayer];
p[][] layer23 = new p[layerOfGradient][pointsInLayer];

void setup() {
  size(1080, 1080);
  background(bg);

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
  fill(255);
  textFont(createFont("Arial", 200));
  textAlign(CENTER, CENTER);
  text(answer, width / 2, height / 2 - 30);

  for (p p : mainLayer[0]) {
    p.updateMain();
  }
  for (p p : mainLayer[1]) {
    p.updateMain();
  }
  for (p p : mainLayer[2]) {
    p.updateMain();
  }

  for (int i = 0; i < layer12[0].length; i++) {
    for (int j = 0; j < layer12.length; j++) {
      layer12[j][i].updateGradient();
      layer23[j][i].updateGradient();
    }
  }

  time = (time + 1) % 120;
  delay(20);
}
