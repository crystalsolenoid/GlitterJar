/*
THE PLAN

program -> PImage -> Texture in P3D

//createImage()
a PGraphics inherits from PImage, so it should work in "texture"
texture()

https://forum.processing.org/one/topic/pgraphics-rendering-with-texture-rendering-with-image.html

*/
ShellTexture sh;

void setup() {
  size(500,500,P3D);
  sh = new ShellTexture(80,80,10, color(255,255,255));
  textureWrap(REPEAT);
  textureMode(NORMAL);
  noStroke();
}

void draw() {
  sh.update();
  
  background(0);
  image(sh.texture, 0, 0);
  
  translate(width/2,height/3);
  rotateY(map(mouseX,0,width,-PI,PI));
  //rotateZ(PI/6);
  scale(10,10,10);
  drawCylinder(sh.texture, 3, 10, 10, 20, 10);
}
