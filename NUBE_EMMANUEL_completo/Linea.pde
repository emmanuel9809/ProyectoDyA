class Linea{
  Punto p1;
  Punto p2;
  
  Linea(Punto a, Punto b){
    p1=a;
    p2=b;
  }
  
  void Dibuja(){
    strokeWeight(3); 
    stroke(144, 12, 63);
    line(p1.x,p1.y, p2.x, p2.y);
  }
  void Dibuja(int[] colores){
    strokeWeight(2);
    stroke(colores[0],colores[1],colores[2]);
    line(p1.x,p1.y, p2.x, p2.y);
  }
}
