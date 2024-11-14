/*
En esta nuve de puntos se necesita una variable en la que se almacene la cantidad de puntos.
*/
int nPuntos = 50;

//Variables para identificar los puntos de mayor relevancia
Punto izquierdo = new Punto(800,0, new int[3]);
Punto derecho= new Punto(0,0, new int[3]);
Punto arriba = new Punto(0,800, new int[3]);
Punto abajo = new Punto(0,0, new int[3]);
Punto pMed = new Punto(0,0, new int[3]);

/*
 encontrar los 4 puntos más importantes en la direccion arriba, abajo, izquierda y derecha. Ya creada la nube se requiere analizar y encontrar los 4 pts ya antes mencionados. En este caso son 4.

*/

//lineas del cierre convexo.
Linea[] CierreConvexo;
void setup(){
  //Diseño de la pantalla emergente con la salida de la nube.
  size(550,550);
  background(205, 195, 244);

  //La nube de puntos 
  Punto[] NubePuntos= new Punto[nPuntos];
  for (int i=0; i < nPuntos;i++){
    /*
   Aqui se itera sobre los puntos que seleccionamos en el principio del programa, yo predefini 50.
    */
    NubePuntos[i]= new Punto(random(height-20)+10, random(width-20)+10, new int[] {0, 0, 255});
    
    if(NubePuntos[i].x < izquierdo.x)
      izquierdo = NubePuntos[i];
    
    if(NubePuntos[i].x>derecho.x)
      derecho = NubePuntos[i];
    
    if(NubePuntos[i].y<arriba.y)
      arriba=NubePuntos[i];
    
    if(NubePuntos[i].y>abajo.y)
      abajo=NubePuntos[i];
      
    NubePuntos[i].Dibuja();
  }
  
  CierreConvexo=CierreConvexo(NubePuntos);
  pMed= puntoMedio(NubePuntos);
  //puntos de mayor relevancia
  izquierdo.Dibuja(0, 255, 0);
  derecho.Dibuja(0, 255, 0);
  arriba.Dibuja(0, 255, 0);
  abajo.Dibuja(0, 255, 0);
  identificaLineas(CierreConvexo, pMed);
}

//cierre convexo 
Linea[] CierreConvexo( Punto[] NubePuntos){
  ArrayList<Punto> PuntosCierre = new ArrayList<Punto>();
  Punto candidato= izquierdo;
  Punto temp = new Punto(0,0, new int[3]);
  int j=0;
  Linea[] lineaCierre = new Linea[50];
  // del lado Izquierdo hacia  arriba
  while (candidato.y != arriba.y){
    double pendiente = 0;
    for(int i=0; i< NubePuntos.length;i++){
      if(NubePuntos[i].y< candidato.y){
        if(pendiente(candidato, NubePuntos[i]) < pendiente){
          temp=NubePuntos[i];
          pendiente= pendiente(candidato, NubePuntos[i]);

        }
      }
      }
      lineaCierre[j]= new Linea(candidato,temp);
      lineaCierre[j].Dibuja();
      candidato=temp;
      PuntosCierre.add(candidato);
      j++;
    }
    // del lado  Izquierdo para abajo  
    candidato= izquierdo;
    PuntosCierre.add(candidato);
    while (candidato.y != abajo.y){
    double pendiente = 0;
    for(int i=0; i< NubePuntos.length;i++){
      if(NubePuntos[i].y> candidato.y){
        if(pendiente(candidato, NubePuntos[i]) >= pendiente){
          temp=NubePuntos[i];
          pendiente= pendiente(candidato, NubePuntos[i]);
        }
      }
      }
      lineaCierre[j]= new Linea(candidato,temp);
      lineaCierre[j].Dibuja();
      candidato=temp;
      PuntosCierre.add(candidato);
      j++;
    }
    
    // de la Derecha para arriba
    candidato= derecho;
    PuntosCierre.add(candidato);
  while (candidato.y != arriba.y){
    double pendiente = 0;
    for(int i=0; i< NubePuntos.length;i++){
      if(NubePuntos[i].y< candidato.y){
        if(pendiente(candidato, NubePuntos[i]) > pendiente){
          temp=NubePuntos[i];
          pendiente= pendiente(candidato, NubePuntos[i]);

        }
      }
      }
      lineaCierre[j]= new Linea(candidato,temp);
      lineaCierre[j].Dibuja();
      candidato=temp;
      PuntosCierre.add(candidato);
      j++;
    }
    // de la Derecha para abajo
    candidato= derecho;
    PuntosCierre.add(candidato);
  while (candidato.y != abajo.y){
    double pendiente = 0;
    for(int i=0; i< NubePuntos.length;i++){
      if(NubePuntos[i].y> candidato.y){
        if(pendiente(candidato, NubePuntos[i]) < pendiente){
          temp=NubePuntos[i];
          pendiente= pendiente(candidato, NubePuntos[i]);
        }
      }
      }
      lineaCierre[j]= new Linea(candidato,temp);
      lineaCierre[j].Dibuja();
      candidato=temp;
      PuntosCierre.add(candidato);
      j++;
    }
    
    for(Punto temp1: PuntosCierre){
      temp1.valoresColor = new int[]{255, 192, 203};
      temp1.Dibuja();
  }
  return lineaCierre;
  }

double pendiente(Punto a, Punto b){
  return ((b.y-a.y)/(b.x-a.x));
}

Punto calcularInterseccion(Linea l, float x) {
  // Caso si la linea es vertical no se puede hacer el corte de interseccion
  if (l.p1.x == l.p2.x) {
    return null;
  }
  //Calculo de la pendiente
  double m = pendiente(l.p1, l.p2);
  // Calculo del punto de interseccion y las coordenadas 
  double b = (-(m * l.p1.x) + l.p1.y);
  //Se implementa la operacion para calcular la coordenada
  double y = (m * x) + b;
  return new Punto(x, (float)y, new int[3]);
}

Punto puntoMedio(Punto[] NubePuntos){
  float[] lista = new float[NubePuntos.length];
  for(int i=0; i<NubePuntos.length;i++){
    lista[i]= NubePuntos[i].x;
  }
  //Se da un ordenamiento respecto al Eje X
  lista= sort(lista);
  float punto=lista[(int)(lista.length/2)]-5;
  Punto p1= new Punto(punto,0,new int[3]);
  p1.valoresColor=new int[]{255, 255, 0};
  
  return p1;
}
//Lineas del cierre que intersectan a la linea media.
void identificaLineas(Linea[] CierreConvexo, Punto pMed){
  Punto[] puntos = new Punto[2];
  int i=0;
  //Analisis de todas las lineas para identificar donde intersectan al medio
  for(Linea l: CierreConvexo){
    if(l != null){
      //Se encontro la linea media 
      if((l.p1.x>pMed.x && l.p2.x<pMed.x)|| (l.p1.x<pMed.x && l.p2.x>pMed.x)){
        //Punto de interseccion
        Punto interseccion = calcularInterseccion(l, pMed.x);
        
        if (interseccion != null) {
          interseccion.valoresColor = new int[]{55, 25, 75};
          puntos[i]=interseccion;
          i++;
        }
      }
    }
  }
  Linea lineaMedio = new Linea(puntos[0], puntos[1]);
  lineaMedio.Dibuja(new int[]{255, 255, 255});
}
