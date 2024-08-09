RainParameter rainParameter;
Cell[][] cells;
RainDrop[] rainDrops = new RainDrop[500];

ArrayList<Ripple> ripples = new ArrayList<Ripple>();
float zoff = 0;

float time = 0;
PGraphics patternBuffer;
PGraphics maskBuffer;
PShader glow;

void setup() {
  size(1080, 1080, P2D);
  patternBuffer = createGraphics(width, height, P2D);
  maskBuffer = createGraphics(width, height, P2D);

  // Draw a mask in the buffer
  maskBuffer.beginDraw();
  maskBuffer.background(0);
  maskBuffer.fill(255);
  maskBuffer.circle(width / 2, height / 2, 780);
  maskBuffer.endDraw();

  rainParameter = new RainParameter(20);

  cells = new Cell[rainParameter.col][rainParameter.row];
  background(PatternColor.bg);

  glow = loadShader("glow.glsl");
  glow.set("resolution", float(width), float(height)); // Convey the window resolution to the shader

  // Initialize the cells array
  for (int x = 0; x < rainParameter.col; x++) {
    for (int y = 0; y < rainParameter.col; y++) {
      cells[x][y] = new Cell(x, y);
    }
  }
  for (int i = 0; i < rainDrops.length; i++) {
    float a = random(390);
    float r = random(TWO_PI);
    rainDrops[i] = new RainDrop(int(width / 2 + cos(r) * a), int(height / 2 + sin(r) * a));
  }
}

void draw() {
  noStroke();
  fill(PatternColor.bg, 10);
  rect(0, 0, width, height);
  noFill();

  // Generate a noise and convert it to angles of vectors
  float yoff = 0;
  for (int y = 0; y < rainParameter.row; y++) {
    float xoff = 0;
    for (int x = 0; x < rainParameter.col; x++) {
      cells[x][y].ang = noise(xoff, yoff, zoff) * TWO_PI;
      xoff += 0.05;
      cells[x][y].rippleRotate();

      // Used for testing vector direction
      /*push();
       stroke(255);
       strokeWeight(1);
       translate(x * cellSize, y * cellSize);
       rotate(cells[x][y].r);
       line(0, 0, cellSize, 0);
       pop();*/
    }
    yoff += 0.05;
    zoff += 0.0002;
  }

  // Update ripples
  for (int i = 0; i < ripples.size(); ) {
    ripples.get(i).update();
    // Remove the ripple if its radius is larger than 300
    if (ripples.get(i).r >= 300)
    {
      ripples.remove(i);
    } else {
      i++;
    }
  }

  // Update raindrops
  for (int i = 0; i < rainDrops.length; i++) {
    int x = int(rainDrops[i].pos.x / rainParameter.size);
    int y = int(rainDrops[i].pos.y / rainParameter.size);
    rainDrops[i].update(cells[x][y].vec); // Convey the cell index the rain drop is in to the update()
    rainDrops[i].show();
  }

  // Convey the current window pixels to the buffer
  patternBuffer.beginDraw();
  patternBuffer.image(get(), 0, 0);
  patternBuffer.endDraw();

  generateRipple();

  // Apply the mask to the buffer image and display it on the window
  patternBuffer.mask(maskBuffer);
  background(PatternColor.bg);
  image(patternBuffer, 0, 0);

  // Then draw the frame and its ripple effect, ensuring they are not affected by the raindrop's tail effect
  drawFrame();
  drawRipples(time);

  time = (time + 1) % 120;
  delay(15);

  // Convey the current window image to the shader and apply the shader on it
  glow.set("texture", patternBuffer); 
  filter(glow);
}
