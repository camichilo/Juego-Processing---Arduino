import processing.serial.*;
Serial port;
int leer;

float posX;
float x = 150;
float y = 30;
float x1 = 150;
float y1 = 30;
float x2 = 150;
float y2 = 30;
float x3 = 150;
float y3 = 30;

int vel = 5;
int dir = 1;
int dir2= 1;

float mapeado;

int ancho=30;
int alto=50;

// Set para juego de carros
PImage fondo, mapa, carro, carro1, policia, carroP, carro2, inicio;
int puntaje=0;
int estado[];

//Aplicar Estados
int stage;

void setup() {

  stage = 1;
  size (1024, 769);

  port = new Serial(this, "COM5", 9600);
  //Llamar las imagenes
  fondo = loadImage("fondo.jpg");
  mapa = loadImage("mapa.jpg");
  carro = loadImage("carro.png");
  carro1 = loadImage("carro1.png");
  policia = loadImage("policia.png");
  carroP = loadImage("carroP.png");
  carro2 = loadImage("carro2.png");
  inicio = loadImage("Inicio.png");

  //Inicializar el estado para el puntaje
  estado = new int[100];

  for (int i=0; i<100; i++)
  {
    estado[i]=1;
  }
}

void draw() {

  if (stage == 1)
  {
    image(fondo, 0, 0);
    //text("Presiona Cualquier Tecla para Jugar", 50, 300);
    if (keyPressed == true) {
      stage = 2;
    }
  }

  if (stage == 2) {
    image(mapa, 0, 0);
    fill(255);

    // CARRO #1
    image(carro, x, y, 30, 50);

    //Hacer que sume en y
    y = y+vel*dir2;
    //Si llega a la pared de abajo, se regresa
    if (y<0)
    {
      dir2=dir2*-1;
    }
    //Si pasa la pared se reinicia
    if (y>768)
    {
      /*Al pasar la pared se regenera en la parte superior
       con los parametros dados*/
      x= random(374, 441);
      y= random(0, 100);
    }

    // CARRO #2
    image(carro1, x1, y1, 30, 50);

    //Hacer que sume en y
    y1 = y1+vel*dir2;
    //Si llega a la pared de abajo, se regresa
    if (y1<0)
    {
      dir2=dir2*-1;
    }
    //Si pasa la pared se reinicia
    if (y1>768)
    {
      /*Al pasar la pared se regenera en la parte superior
       con los parametros dados*/
      x1= random(441, 479);
      y1= random(0, 80);
    }

    // CARRO #3
    image(policia, x2, y2, 30, 50);

    //Hacer que sume en y
    y2 = y2+vel*dir2;
    //Si llega a la pared de abajo, se regresa
    if (y2<0)
    {
      dir2=dir2*-1;
    }
    //Si pasa la pared se reinicia
    if (y2>768)
    {
      /*Al pasar la pared se regenera en la parte superior
       con los parametros dados*/
      x2= random(586, 630);
      y2= random(30, 100);
    }

    // CARRO #4
    image(carro2, x3, y3, 30, 50);

    //Hacer que sume en y
    y3 = y3+vel*dir2;
    //Si llega a la pared de abajo, se regresa
    if (y3<0)
    {
      dir2=dir2*-1;
    }
    //Si pasa la pared se reinicia
    if (y3>768)
    {
      /*Al pasar la pared se regenera en la parte superior
       con los parametros dados*/
      x3= random(519, 586);
      y3= random(70, 100);
    }

    //Leer el potenciometro
    if (0<port.available()) {
      leer = port.read();
      println(leer);
      mapeado = map(leer, 0, 200, 0, 768);
    }

    posX=mapeado;
    image(carroP, posX, 650, ancho, alto);
    //rect(posX, 650, ancho, alto);
    // Creación de Puntaje y Revote de Carros
    for (int i=0; i<100; i++) {
      if (y < 768 && y > 640 || y1 < 768 && y1 > 640)
      {
        if (x>=posX && x<=posX+ancho || x1>=posX && x1<=posX+ancho)
        {
          dir2=dir2*-1;
          estado[i] = 0;
        }
      }
    }

    // Texto
    fill (0, 0, 0);
    textSize(30);
    text ("Puntaje: " + puntaje, 40, 100);

    // Contador de Puntaje
    puntaje=0;
    for (int i=0; i<100; i++)
    {
      if (estado[i] == 0)
      {
        puntaje++;
        if (puntaje == 100) {
          stage = 3;
        }
      }
    }
  }

  if (stage == 3) {
    image (inicio, 0, 0);
    inicio.resize(1024, 769);
    if (keyPressed == true) {
      stage = 2;
    }
  }
}
