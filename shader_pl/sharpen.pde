// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/

PImage label;
PShape can;
float angle;
boolean filterSharpen = false;

PShader sharpenShader;

void setup() {
  size(800, 600, P3D);  
  label = loadImage("casa.jpg");
  //can = createCan(100, 200, 32, label);
  sharpenShader = loadShader("sharpen.glsl");
}

void draw() {    
  background(0);
  
  image(label, 0, 0);
  
  if (filterSharpen)
    filter(sharpenShader);
}

void keyPressed() {
  if(key == 'S' || key == 's'){
    filterSharpen = !filterSharpen;
  }
}