// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/

PImage label;
PShape can;
float angle;
boolean applyFilter = false;
boolean show_filters = true;
boolean show_image = true;

PShader  filter;

int[] X = {380,380,100};
int selected;



void setup() {
  size(1000, 800, P3D);  
  label = loadImage("casa.jpg");
  //can = createCan(100, 200, 32, label);
  filter = loadShader("filters.glsl");
}

void draw() {    
  background(0);
  
  if(show_image){
    image(label, 0, 0);
  }else{
    image(label, 0, 0);
  }
  
  if(applyFilter){
    
    setSharpenFilter();
  
    setOutlineFilter();
    
    setBlurFilter();
  }
  
  if(show_filters){
    draw_filters();
  }
}


void draw_filters(){

  stroke(0);
  fill(255);
  
  //Filter 1
  line(100,20,100,60);
  line(900,20,900,60);
  line(100,40,900,40);
  rect(X[0],20,40,40);
  
  //Filter 2
  line(100,80,100,120);
  line(900,80,900,120);
  line(100,100,900,100);
  rect(X[1],80,40,40);
  
  //Filter 3
  line(100,140,100,180);
  line(900,140,900,180);
  line(100,160,900,160);
  rect(X[2],140,40,40);
}

void setSharpenFilter(){

  filter.set("filt", (int)0);
  float light = ((X[0]-100)*((6f-4f)/(860f-100f))+4f);
  filter.set("light",light);
  filter(filter);
  
}

void setOutlineFilter(){

  filter.set("filt", 1);
  float light = ((X[1]-100)*((11f-8f)/(860f-100f))+8f);
  filter.set("light",light);
  filter(filter);
  
}

void setBlurFilter(){
  
  filter.set("filt", 2);
  int iter = (int)((X[2]-100)*((100f-1f)/(860f-100f))+1f);
  println(iter);
  for(int i=0;i<iter;i++){
    filter(filter);
  }
  
}


void keyPressed() {
  if(key == 'a' || key == 'A'){
    applyFilter = !applyFilter;
  }
  if(key == 's' || key == 'S'){
    
    save("filtered_image.png");
  }
   if(key == 'f' || key == 'F'){
    show_filters = !show_filters;
  }
}

void mousePressed(){
  int y = mouseY;
  if( y < 70){
     selected = 0;
  }else{
    if( y < 130){
      selected = 1;
    }else{
      if( y < 200){
        selected = 2;
      }else{
        if(y < 270){
          selected = 3;
        }else{
          selected = -1;
        }
      }
    }
  }

}

void mouseDragged(){
  if(selected != -1){
    X[selected] = mouseX;
    if(X[selected]< 100){
      X[selected] = 100;
    }
    if(X[selected] > 860){
      X[selected] = 860;
  }
  
  }
  
}