class ShellTexture {
  ShellGlitter[] glitter;
  int nGlitter;
  PGraphics texture;
  color c;
  
  ShellTexture(int w, int h, int _nGlitter, color _c) {
    c = _c;
    nGlitter = _nGlitter;
    texture = createGraphics(w,h,P3D);
    glitter = new ShellGlitter[nGlitter];
    for (int i = 0; i < nGlitter; i++) {
      glitter[i] = new ShellGlitter(texture, 3);
    }
  }
  
  void update() {
    ellipseMode(RADIUS);
    texture.noStroke();
    texture.fill(c);
    texture.beginDraw();
    texture.background(255, 0); // will be transparent bg
    for (int i = 0; i < nGlitter; i++) {
      glitter[i].update();
      glitter[i].display();
    }
    texture.endDraw();
  }
}
