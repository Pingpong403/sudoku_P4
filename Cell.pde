/*
  CELL Class
  
  Represents a single cell on the Sudoku grid.
  
  attributes:
    coords - where the top left corner is positioned
    size - the side length of the square
    number - whatever number is stored in the cell. 0 is blank
    possibles - the smaller numbers the user inputs as possible numbers
    cellFocused - whether or not this cell is being focused
    originCell - whether or not this cell cannot be changed by the user
    
  methods:
    Constructors - default + 2 non-default
    setNumber - only lets you set if the cell is not an origin cell
    addPossible - add a number to the list of possible numbers, or clear the list
    drawCell - draws a rectangle, the number (if there is one), and all the possibles
    focus - sets this cell to be focused
    unfocus - sets this cell to not be focused
*/

class Cell
{
  private Coords coords = new Coords();
  private int size;
  
  private int number;
  private Vector<Integer> possibles = new Vector<Integer>();
  
  private boolean cellFocused = false;
  private boolean originCell = false;
  
  public Cell()
  {
    this.coords.setXY(500, 350);
    this.size = 50;
    this.number = 0;
  }
  
  public Cell(int posX, int posY, int size)
  {
    this.coords.setXY(posX, posY);
    this.size = size;
    this.number = 0;
    originCell = false;
  }
  
  public Cell(int posX, int posY, int size, int number)
  {
    this.coords.setXY(posX, posY);
    this.size = size;
    this.number = number;
    originCell = true;
  }
  
  public int getNumber() { return number; }
  public void setNumber(int number)
  {
    if (!originCell)
      this.number = number;
  }
  
  public void addPossible(int possible)
  {
    if (!originCell)
    {
      if (!possibles.contains(possible))
      {
        possibles.add(possible);
      }
      if (possible == 0)
      {
        possibles.clear();
      }
    }
  }
  
  public void drawCell()
  {
    // box
    stroke(0, 0, 0);
    strokeWeight(1);
    fill(cellFocused ? 200 : 255, 255, cellFocused ? 200 : 255);
    rect(coords.getX(), coords.getY(), size, size);
    // number
    if (number != 0)
    {
      textSize(size * (1.0 - MARGIN));
      noStroke();
      fill(originCell ? 0 : 150, originCell ? 0 : 150, originCell ? 0 : 255);
      textAlign(CENTER);
      text(number, coords.getX() + ((float)size / 2.0), coords.getY() + (float)size * (1.0 - MARGIN));
    }
    // possibles
    if (possibles.size() > 0)
    {
      textSize(size * 0.3);
      noStroke();
      fill(0, 0, 0);
      textAlign(CENTER);
      for (int i = 0; i < possibles.size(); i++)
      {
        int possible = possibles.get(i);
        float thirdLength = (float)size / 3;
        float halfLength = (float)size / 2;
        int col = i % 3;
        int row = i / 3;
        text(possible, coords.getX() + (thirdLength * col) + halfLength - thirdLength, coords.getY() + (thirdLength * row) + halfLength - thirdLength + (float)size * 0.1);
      }
    }
  }
  
  public void reset()
  {
    number = 0;
    possibles.clear();
    
    cellFocused = false;
  }
  
  public void focus()
  {
    cellFocused = true;
  }
  
  public void unfocus()
  {
    cellFocused = false;
  }
  
  public boolean isFocused() { return cellFocused; }
}
