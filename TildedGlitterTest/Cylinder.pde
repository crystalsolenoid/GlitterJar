void drawCylinder(PImage texture, float texScale, float topRadius, float bottomRadius, float tall, int sides) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    texture(texture);
    for (int i = 0; i < sides + 1; ++i) {
      vertex(topRadius*cos(angle), 0, topRadius*sin(angle), topRadius*angle/texScale, 0);
      vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle), bottomRadius*angle/texScale, tall/texScale);
      angle += angleIncrement;
    }
    endShape();
  }
