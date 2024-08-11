/*
  COORDS Class
  
  A very simple class containing x and y. Meant to represent a position
  on the screen in pixels. You can set x and y individually or at the same time.
*/
class Coords
{
  private int x;
  private int y;
  
  public Coords()
  {
    x = 0;
    y = 0;
  }
  
  public Coords(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  public int getX() { return x; }
  public int getY() { return y; }
  public void setX(int x) { this.x = x; }
  public void setY(int y) { this.y = y; }
  public void setXY(int x, int y) { this.x = x; this.y = y; }
}
