class Jar {
  PShape[] shapes;
  Glitter[] glitter;
  int nGlitter;
  // the height is jarSize*jarHeight, so it's more like a ratio
  float jarHeight=2.7;
  float jarSize=width/2-50;
  color liquid = color(100,50,100,100);
  //color liquid = color(100,50,50,100);
  
  ShellTexture shell,shell2;
  float texScale = 2;

  Jar(int nRects, int nTris, int nStars) { 
    // make thin shell glitter texture
    shell = new ShellTexture(500,500,100,color(255,255,255));
    shell2 = new ShellTexture(450,450,90,color(255,255,255));
    textureWrap(REPEAT);
    textureMode(NORMAL);
    
    // make glitter array
    nGlitter = nRects + nTris + nStars;
    glitter = new Glitter[nGlitter];

    // make shapes for glitter
    shapes = setupShapes();

    // generate glitter
    // rectangles:
    for (int i = 0; i < nRects; i++) {
      //int shapeID = int(random(shapes.length));
      //glitter[i] = new Glitter(shapes[shapeID],jarHeight,2); 
      glitter[i] = new Glitter(shapes[0], jarHeight, 2);
    }
    // triangles:
    for (int i = nRects; i < (nRects+nTris); i++) {
      glitter[i] = new Glitter(shapes[1], jarHeight, 2);
    }
    // stars:
    for (int i = nRects+nTris; i < nGlitter; i++) {
      glitter[i] = new Glitter(shapes[2], jarHeight, 2);
    }
  }

  void display() {
    noStroke();
    // Go to center-top of jar
    pushJarMatrix();
    specular(255, 255, 255);
    for (int i = 0; i < nGlitter; i++) {
      glitter[i].display();
    }
    drawThinShell(0.95);
    drawLiquid();
    popMatrix();
  }

  void drawLiquid() {
    //fill(255,128,128,50);
    //emissive(255,128,128);
    //color liquid = color(100,50,50,100);
    fill(liquid);
    emissive(liquid);
    //fill(100, 255, 100, 100);
    //emissive(128, 255, 128);
    float diameter = 1.05;
    drawCylinder(diameter, diameter, jarHeight, 20, false, shell.texture);
    // this is terrible coding. it doesnt actually use the texture but processing doesn't have default arguments??!
  }

  void pushJarMatrix() {
    pushMatrix();
    translate(width/2, (height-jarSize*jarHeight)/2, 0);
    scale(jarSize, jarSize, jarSize);
  }

  void update() {
    for (int i = 0; i < nGlitter; i++) {
      glitter[i].update();
    }
    shell.update();
    shell2.update();
  }

  PShape[] setupShapes() {
    PShape tri, rec, sta;
    PShape[] sh = new PShape[3]; // this should maybe be a pList(?) instead so i don't have to hardcode size

    // rectangle glitter
    rectMode(CENTER);
    rec = createShape(RECT, 0, 0, 0.3, 1);
    rec.setStrokeWeight(0);
    rec.setFill(color(20, 240, 180));
    //rec.setEmissive(color(50,0,0));
    rec.setEmissive(liquid);
    sh[0] = rec;

    // triangle glitter
    tri = createShape(TRIANGLE, -1, -0.5, 1, -0.5, 0, 1);
    tri.setStrokeWeight(0);
    tri.setFill(color(50, 240, 20));
    //tri.setEmissive(color(50,0,0));
    tri.setEmissive(liquid);
    sh[1] = tri;

    // star glitter
    sta = createShape();
    sta.setStrokeWeight(0);
    sta.setFill(color(240, 240, 20));
    //sta.setEmissive(color(50,0,0));
    sta.setEmissive(liquid);
    sta.beginShape();
    int n=5;
    float a=1; 
    float o=2; // inner and outer radii
    float ang=0;
    for (int i = 0; i < n+1; i++) {
      sta.vertex(a*cos(ang), a*sin(ang), 0);
      ang += TWO_PI/(2*n);
      sta.vertex(o*cos(ang), o*sin(ang), 0);
      ang += TWO_PI/(2*n);
    }
    sta.endShape(CLOSE);
    sh[2] = sta;

    return sh;
  }

  // From processing example:
  // (but I added the texture functionality)
  void drawCylinder(float topRadius, float bottomRadius, float tall, int sides, boolean useTexture, PImage texture) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    if(useTexture){
      beginShape(QUAD_STRIP);
      texture(texture);
      for (int i = 0; i < sides + 1; ++i) {
        vertex(topRadius*cos(angle), 0, topRadius*sin(angle), topRadius*angle/texScale, 0);
        vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle), bottomRadius*angle/texScale, tall/texScale);
        angle += angleIncrement;
      }
      endShape();
    }else{
      beginShape(QUAD_STRIP);
      for (int i = 0; i < sides + 1; ++i) {
        vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
        vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
        angle += angleIncrement;
      }
      endShape();
    }
  }
  
  void drawThinShell(float diameter) {
    drawCylinder(diameter, diameter, jarHeight, 20, true, shell.texture);
    drawCylinder(diameter, diameter, jarHeight, 20, true, shell2.texture);
  }
}
