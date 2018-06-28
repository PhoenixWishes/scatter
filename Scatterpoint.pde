class Scatterpoint {
  int r;
  int g;
  int b;
  float distance;

  Scatterpoint(int r, int g, int b, float distance) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.distance = distance;
  }
}

class Measurer implements Comparator<Scatterpoint> {
  @Override
    public int compare(Scatterpoint s1, Scatterpoint s2) {
    return Float.compare(s1.distance, s2.distance);
  }
}

class MeasurerG implements Comparator<Scatterpoint> {
  @Override
    public int compare(Scatterpoint s1, Scatterpoint s2) {
    return Float.compare(s1.g, s2.g);
  }
}