class cell {
  PVector pos = new PVector();
  PVector v = new PVector(1, 0); // The cell's vector used to control the acceleration direction when the raindrops passes by
  float r; // Angle of the vector

  // Calculate the coordinates of the cell center
  cell(int x, int y) {
    this.pos.x = x * cellSize + (cellSize / 2);
    this.pos.y = y * cellSize + (cellSize / 2);
  }

  // Calculate the vector angle when it is affected by the ripples
  void rippleRotate() {
    for (ripple ripple : ripples) {
      float dist = dist(ripple.pos.x, ripple.pos.y, pos.x, pos.y); // Calculate the distance of each ripple to the cell and determine whether it is influenced by the ripple
      PVector angle = new PVector(ripple.pos.x - pos.x, ripple.pos.y - pos.y); // Calculate the vector direction around the ripple center
      if (dist <= ripple.radius && dist >= ripple.radius - 100) { // Generate a ring
        r = angle.heading() + HALF_PI;
      }
    }
    v.set(1, 0).rotate(r); // Calculate the vector by its angle
  }
}
