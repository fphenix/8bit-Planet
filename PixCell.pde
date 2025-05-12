class PixCell {

  color c;
  
  int x;
  int y;
  
  int origx = int(width / 2.0);
  int origy = int(height / 2.0);
  int screenx;
  int screeny;
  
  int w;
  int h;
  
  boolean border;
  
  PixCell (int _x, int _y, int _w, int _h, color _c, int _origx, int _origy, boolean _border) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
    this.c = _c;
    this.origx = _origx;
    this.origy = _origy;
    this.border = _border;
    
    this.calcScreenCoords();
  }
  
  color getColor() {
    return this.c;
  }
  
  void setColor (color _c) {
    this.c = _c;
  }
  
  void calcScreenCoords () {
    this.screenx = (this.x * this.w) + this.origx;
    this.screeny = this.origy - (this.y * this.h); 
  }
  
  public void show () {
    rectMode(CENTER);
    if (!this.border) {
      noStroke();
    } else {
      stroke(0);
    }
    fill(this.c);
    rect(this.screenx, this.screeny, this.w, this.h);
  }

}
