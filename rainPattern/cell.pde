class Cell {
  PVector pos = new PVector();
  PVector vec = new PVector(1, 0); // Used to control the acceleration direction when the raindrops passes by
  float ang;

  // Calculate the coordinates of the cell center
  Cell(int x, int y) {
    this.pos.x = x * rainParameter.size + (rainParameter.size / 2);
    this.pos.y = y * rainParameter.size + (rainParameter.size / 2);
  }

  // Calculate the vector angle when it is affected by the ripples
  void rippleRotate() {
    for (Ripple ripple : ripples) {
      float dist = dist(ripple.pos.x, ripple.pos.y, pos.x, pos.y); // Calculate the distance of each ripple to the cell and determine whether it is influenced by the ripple
      PVector angVec = new PVector(ripple.pos.x - pos.x, ripple.pos.y - pos.y); // Calculate the vector direction around the ripple center
      if (dist <= ripple.r && dist >= ripple.r - 200) { // Generate a ring
        ang = angVec.heading() + HALF_PI;
      }
    }
    vec.set(1, 0).rotate(ang); // Calculate the vector by its angle
  }
}
