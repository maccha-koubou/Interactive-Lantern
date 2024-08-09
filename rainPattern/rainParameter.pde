class RainParameter {
  int size;
  int col;
  int row;
  RainParameter(int size) {
    this.size = size;
    col = width / size;
    row = height / size;
  }
}
