Jar myJar;
int seed;

void setup() {
  seed = int(random(99999));
  randomSeed(seed);
  print("Random seed is:", seed);
  size(500, 900, P3D);
  myJar = new Jar(1000, 50, 10);
}

void draw() {
  lighting();
  myJar.display();
  myJar.update();
  println("FPS:", int(frameRate));
}

void lighting() {
  //ortho();
  background(20);
  lightFalloff(0,0,5);
  directionalLight(255, 255, 255, 0, -1, -1);
  ambientLight(128, 128, 128);
}
