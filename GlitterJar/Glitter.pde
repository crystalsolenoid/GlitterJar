class Glitter {
  PShape s;
  float r, h, theta, dtheta, size;
  float alpha, dalpha, beta, dbeta, gamma, dgamma;
  boolean invis;

  Glitter(PShape s_, float jarHeight, int hDecay) {
    invis = false;
    s = s_; // shape

    r = pow(random(0, 1), 0.5); // distance from jar axis

    // ensure no glitter goes above jar top:
    h = -1;
    while (h < 0) {
      h = jarHeight*(1-log(1-random(0, 0.9))/(-hDecay));
    }

    // angle of orbit about jar axis
    theta = random(0, TWO_PI);
    dtheta = abs(randomGaussian())/200;

    // Euler angles and rotations
    // this is buggy and physically unsound, for now
    alpha = random(0, TWO_PI);
    dalpha = alpha/100;
    float z = random(-1, 1);
    beta = acos(z);
    dbeta = beta/100;
    gamma = random(0, TWO_PI);
    dgamma = gamma/100;

    size = 0.01 + abs(randomGaussian()/100);
  }

  void display() {
    if (!invis) {
      pushMatrix();
      // Rotate along jar-axis a radians
      rotateY(theta);
      // Go a distance r from jar-axis, and h down
      translate(r, h, 0);
      scale(size, size, size);
      rotateX(alpha); 
      rotateY(beta); 
      rotateZ(gamma);
      shape(s);
      popMatrix();
    }
  }

  void update() {
    theta=(theta+dtheta)%TWO_PI;
    alpha=(alpha+dalpha)%TWO_PI;
    beta=(beta+dbeta)%TWO_PI;
    gamma=(gamma+dgamma)%TWO_PI;
    if (distanceThroughLiquid() > 1) {
      invis = true;
    } else {
      invis = false;
    }
  }

  float distanceThroughLiquid() {
    float d = abs(sin(theta)) + r*sin(theta);
    return d;
  }
}
