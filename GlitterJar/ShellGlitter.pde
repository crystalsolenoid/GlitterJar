class ShellGlitter {
  PVector r,v;
  float baseRadius,radius,z,dz;
  PGraphics g;
  int wrapx,wrapy;
  
  ShellGlitter(PGraphics g_, float radius_) {
    g = g_;
    baseRadius = radius_;
    radius = radius_;
    
    r = new PVector(random(g.width),random(g.height));
    v = new PVector(randomGaussian(),randomGaussian());
    z = random(TWO_PI);
  }
  
  void update() {
    r.add(v);
    r.x = r.x%g.width;
    r.y = r.y%g.height;
    v.x += randomGaussian()/100;
    v.y += randomGaussian()/100;
    v.limit(0.5);
    v.rotate(randomGaussian()/10);
    
    radius = baseRadius*pow(sin(z),2);
    z += abs(randomGaussian()/100);
    //z = min(1,abs(z+dz));
    //dz += randomGaussian()/100;
    //dz = (dz/abs(dz))*min(0.5,abs(dz));
    
    // my wrapping logic isn't perfect but it mostly works...
    wrapx = 0;
    wrapy = 0;
    if(r.x+radius <= g.width){wrapx=1;}
    if(r.x-radius > 0){wrapx=-1;}
    if(r.y+radius <= g.height){wrapy=1;}
    if(r.y-radius > 0){wrapy=-1;}
  }
  
  void display() {
    g.ellipse(r.x,r.y,radius,radius);
    if(wrapx != 0){
      g.ellipse(r.x+wrapx*g.width,r.y,radius,radius);
    }
    if(wrapy != 0){
      g.ellipse(r.x,r.y+wrapy*g.height,radius,radius);
    }
    if(wrapx!=0 && wrapy!=0){
      g.ellipse(r.x+wrapx*g.width,r.y+wrapy*g.height,radius,radius);
    }
  }
}
