class Punto{
  float x;
  float y;
  int[] valoresColor;
  
  Punto(float a, float b, int[] z){
    x=a;
    y=b;
    valoresColor=z;
  }
  void Dibuja(){
    fill(valoresColor[0], valoresColor[1], valoresColor[2]);
    circle(x, y, 10);
    strokeWeight(0); 
  }
  void Dibuja(int v1,int v2,int v3){
    fill(v1,v2,v3);
    circle(x, y, 10);
    strokeWeight(0); 
  }
}
