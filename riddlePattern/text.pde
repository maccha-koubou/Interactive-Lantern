// Draw the answer text in the buffer
void makeTextBuffer() {
  textBuffer.beginDraw();
  textBuffer.background(0);
  textBuffer.fill(255);
  textBuffer.textFont(createFont("Arial", 200));
  textBuffer.textAlign(CENTER, CENTER);
  textBuffer.text(answer, width / 2, height / 2 - 30);
  textWidth = textBuffer.textWidth(answer);
  textHeight = textBuffer.textAscent() + textBuffer.textDescent();
  textBuffer.endDraw();
  textBuffer.loadPixels();
  textBufferPixels = textBuffer.pixels;
}

// Assign coordinates on answer text for each point
void pixelsOnText() {
  ArrayList<Integer> textPixelIndexs = new ArrayList<>();
  // Filter black pixels from the buffer image
  for (int i = 0; i < textBufferPixels.length; i++) {
    if (textBufferPixels[i] == color(255)) {
      textPixelIndexs.add(i);
    }
  }
  // Assign coordinates of black pixels for each point randomly
  for (int i = 0; i < textPixels.length; i++) {
    textPixels[i] = textPixelIndexs.get(int(random(0, textPixelIndexs.size())));
  }
}
