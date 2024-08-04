color bg = #000000;
color from = #FF934A;
color to = #FFFFFF;

int cellSize = 20;
int col;
int row;
cell[][] cells;
rain[] rainDrops = new rain[500];

ArrayList<ripple> ripples = new ArrayList<ripple>();
float zoff = 0;

float time = 0;
PShader glow;

void setup() {
  size(1080, 1080, P2D);

  col = width / cellSize;
  row = height / cellSize;
  cells = new cell[col][row];
  background(bg);

  glow = loadShader("glow.glsl");
  glow.set("resolution", float(width), float(height)); // Convey the window resolution to the shader

  // Initialize the cells array
  for (int x = 0; x < col; x++) {
    for (int y = 0; y < col; y++) {
      cells[x][y] = new cell(x, y);
    }
  }
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new rain(int(random(width)), int(random(height)));
  }
}

void draw() {
  noStroke();
  fill(bg, 10);
  rect(0, 0, width, height);
  noFill();
  
  //drawFrame();
  //drawRipples(time);

  // Generate a noise and convert it to angles of vectors
  float yoff = 0;
  for (int y = 0; y < row; y++) {
    float xoff = 0;
    for (int x = 0; x < col; x++) {
      cells[x][y].r = noise(xoff, yoff, zoff) * TWO_PI;
      xoff += 0.05;
      cells[x][y].rippleRotate();

      /*push();
       stroke(255);
       strokeWeight(1);
       translate(x * cellSize, y * cellSize);
       rotate(cells[x][y].r);
       line(0, 0, cellSize, 0);
       pop();*/
       
       //fill(cells[x][y].r * 256);
       //rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
    yoff += 0.05;
    zoff += 0.0002;
  }

  // Update ripples
  for (int i = 0; i < ripples.size(); ) {
    ripples.get(i).update();
    // Remove the ripple if its radius is larger than 300
    if (ripples.get(i).radius >= 300)
    {
      ripples.remove(i);
    } else {
      i++;
    }
  }

  // Update raindrops
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i].update(cells[int(rainDrops[i].pos.x / cellSize)][int(rainDrops[i].pos.y / cellSize)].v); // Convey the cell index the rain drop is in to the update()
    rainDrops[i].show();
  }

  generateRipple();

  time = (time + 1) % 120;
  delay(15);

  // Convey the current window image to the shader and apply the shader on it
  glow.set("texture", get()); 
  //filter(glow);
}
