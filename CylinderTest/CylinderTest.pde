float jarHeight = 2.7;
float jarSize;
float sc = 20;

void setup() {
 size(500,900,P3D);
jarSize = width/2-50;
}

void draw() {
  ortho();
  pushJarMatrix();
  //background(0);
 //sphere(1);
 noStroke();
 lights();
 scale(jarSize,jarSize,jarSize);
 drawCylinder(1,1,jarHeight,10);
 println(sc);
 popMatrix();
 sc ++;
}

void pushJarMatrix() {
  pushMatrix();
  translate(width/2,(height-jarSize*jarHeight)/2,0);
  //scale(jarSize, jarSize, jarSize);
}

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; ++i) {
      vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
      vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }
