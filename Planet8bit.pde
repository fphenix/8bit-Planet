
int mercatorXmin = -18;
int mercatorXmax = 18;
int mercatorYmin = -18;
int mercatorYmax = 18;
int xoffset = 0;

float planetRadius = 17.5;

/*
int mercatorXmin = -7;
int mercatorXmax = 7;
int mercatorYmin = -8;
int mercatorYmax = 8;
int xoffset = 0;

float planetRadius = 6;
*/

PixCell[][] mercator = new PixCell[(2*(mercatorXmax-mercatorXmin))+1][(mercatorYmax-mercatorYmin)+1];
PixCell[][] planet   = new PixCell[   (mercatorXmax-mercatorXmin) +1][(mercatorYmax-mercatorYmin)+1];

color pickColor (int i, int j) {
  //mark center point of mercator map for debbuging
  //if ((i == 0) && (j == 0)) {
  //  return color (0x80, 0x80, 0xFF);
  //}
  /*int red;
   if ((i < mercatorXmin) || (i > mercatorXmax)) {
   red = int(0x80);
   } else {
   red   = int(map(float(i), float(mercatorXmin), float(mercatorXmax), 0.0, 256.0));
   }
   int green = int(map(float(j), float(mercatorYmin), float(mercatorYmax), 0.0, 256.0));
   int blue = 0x80;
   return color(red, green, blue);*/
  int sat = 0xFF;
  int bright =0xFF;

  float xnoise = 8.7125 * (i+(2.0*mercatorXmax)) / (2.0*(mercatorXmax-mercatorXmin));
  float ynoise = 5.33 * (j+mercatorYmax) / (1.0*(mercatorYmax-mercatorYmin));
  float znoise = 3.10;
  randomSeed(1);
  noiseSeed(1);
  int hue = int(noise(xnoise, ynoise, znoise) * 256.0);
  return color(hue, sat, bright);
}

float hypothenus (float a, float b) {
  return sqrt(a*a + b*b);
}

float xcoord (float h, float b) {
  return sqrt(h*h - b*b);
}

void showMercator () {
  for (int j = mercatorYmin; j <= mercatorYmax; j++) {
    for (int i = 2*mercatorXmin; i <= 2*mercatorXmax; i++) {
      int idxx = i+(mercatorXmax*2);
      int idxy = j+mercatorYmax;
      mercator[idxx][idxy] = new PixCell(i, j, 10, 10, pickColor(i, j), int(3.0 * width/5.0+40.0), int(height/2.0), true);
      mercator[idxx][idxy].show();
    }
  }
}

void showPlanet () {
  showPlanet(0);
}

void showPlanet (int xoff) {
  for (int j = mercatorYmin; j <= mercatorYmax; j++) {
    for (int i = mercatorXmin; i <= mercatorXmax; i++) {
      color c;
      int idxx = i+mercatorXmax;
      int idxy = j+mercatorYmax;
      //mark center point of planet for debugging
      //if ((i == 0)&&(j == 0)) {
      //  c = color(255, 255, 255);
      //} else
      if (hypothenus(i, j) < planetRadius) {
        float step = 1.0 * planetRadius / xcoord(planetRadius, j);
        int midxx = int(i*step) + (2*mercatorXmax) + xoff;
        while (midxx > 2*mercatorXmax) {
          midxx -= 2*(mercatorXmax-mercatorXmin)+1;
        }
        while (midxx < 2*mercatorXmin) {
          midxx += 2*(mercatorXmax-mercatorXmin);
        }
        midxx += (2*mercatorXmax);
        //println(i, j, step, hypothenus(i, j), idxx, idxy);
        c = mercator[midxx][idxy].getColor(); // color(0xBB, 0x22, 0x44);
        mercator[midxx][idxy].setColor(color(0x40, 0x40, 0x40));
        mercator[midxx][idxy].show();
      } else {
        c = color(0, 0, 0, 255);
      }
      planet[idxx][idxy] = new PixCell(i, j, 10, 10, c, int(width/5.0), int(height/2.0), false);
      planet[idxx][idxy].show();
    }
  }
}

void setup () {
  size(1400, 600);
  colorMode(HSB, 256);

  showMercator();

  showPlanet();

  frameRate(5);
}

void draw () {
  background(0);

  showMercator();

  showPlanet(xoffset);

  xoffset++;
}
