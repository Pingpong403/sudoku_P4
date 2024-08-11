/*
  GRID Class
  
  Holds all of the cells on the Sudoku grid. Can generate a new grid and
  facilitate interaction with the cells.
  
  attributes:
    grid - a 9x9 array holding all of the cells
    coords - the top-left position of the Sudoku grid
    cellSize - dictates the side length of each of the cells
    
  methods:
    Constructors - non-default
    drawGrid - draws each of the cells and hard lines around each 3x3 group
    populate - creates a new grid based on the difficulty provided
    populateEasy - makes an easy puzzle
    populateMedium - makes a medium puzzle
    populateHard - makes a hard puzzle
    check - checks if the given number can be placed in the given cell
    checkSingular(WIP) - checks if the given number will cause an error if placed in the given cell
    click - facilitates interaction based on a click in the given cell
    input - facilitates interaction based on the focused cell, input mode, and number given
    hasFocused - returns true if any cells are being focused
*/

enum Level { EASY, MEDIUM, HARD }

class Grid
{
  private Cell[][] grid = {
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()},
    {new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell(), new Cell()}
  };
  
  private Coords coords = new Coords();
  private int cellSize;
  
  public Grid(int posX, int posY, int cellSize)
  {
    coords.setXY(posX, posY);
    this.cellSize = cellSize;
  }
  
  public void drawGrid()
  {
    // draw cells
    for (int r = 0; r < 9; r++)
    {
      for (int c = 0; c < 9; c++)
      {
        grid[r][c].drawCell();
      }
    }
    
    // draw harder lines
    stroke(0, 0, 0);
    strokeWeight(3);
    noFill();
    rect(coords.getX(), coords.getY(), cellSize * 9, cellSize * 9);
    line(coords.getX() + cellSize * 3, coords.getY(), coords.getX() + cellSize * 3, coords.getY() + cellSize * 9);
    line(coords.getX() + cellSize * 6, coords.getY(), coords.getX() + cellSize * 6, coords.getY() + cellSize * 9);
    line(coords.getX(), coords.getY() + cellSize * 3, coords.getX() + cellSize * 9, coords.getY() + cellSize * 3);
    line(coords.getX(), coords.getY() + cellSize * 6, coords.getX() + cellSize * 9, coords.getY() + cellSize * 6);
  }
  
  public void populate(Level l)
  {
    for (int r = 0; r < 9; r++)
    {
      for (int c = 0; c < 9; c++)
      {
        grid[r][c].reset();
      }
    }
    if (l == Level.EASY)
    {
      populateEasy();
    }
    else if (l == Level.MEDIUM)
    {
      populateMedium();
    }
    else if (l == Level.HARD)
    {
      populateHard();
    }
  }
  
  private void populateEasy()
  {
    for (int r = 0; r < 9; r++)
    {
      for (int c = 0; c < 9; c++)
      {
        if (templateEasy1[r][c])
        {
          int number = rand.nextInt(1, 9);
          while (!check(r, c, number))
          {
            number = rand.nextInt(1, 9);
          }
          grid[r][c] = new Cell(coords.getX() + c * cellSize, coords.getY() + r * cellSize, cellSize, number);
        }
        else
        {
          grid[r][c] = new Cell(coords.getX() + c * cellSize, coords.getY() + r * cellSize, cellSize);
        }
      }
    }
  }
  
  private void populateMedium()
  {
    for (int r = 0; r < 9; r++)
    {
      for (int c = 0; c < 9; c++)
      {
        if (templateEasy1[r][c])
        {
          int number = rand.nextInt(1, 9);
          while (!check(r, c, number))
          {
            number = rand.nextInt(1, 9);
          }
          grid[r][c] = new Cell(coords.getX() + c * cellSize, coords.getY() + r * cellSize, cellSize, number);
        }
        else
        {
          grid[r][c] = new Cell(coords.getX() + c * cellSize, coords.getY() + r * cellSize, cellSize);
        }
      }
    }
  }
  
  private void populateHard()
  {
    for (int r = 0; r < 9; r++)
    {
      for (int c = 0; c < 9; c++)
      {
        if (templateEasy1[r][c])
        {
          int number = checkSingular(r, c);
          if (number == 0)
          {
            number = rand.nextInt(1, 9);
            while (!check(r, c, number))
            {
              number = rand.nextInt(1, 9);
            }
          }
          grid[r][c] = new Cell(coords.getX() + c * cellSize, coords.getY() + r * cellSize, cellSize, number);
        }
        else
        {
          grid[r][c] = new Cell(coords.getX() + c * cellSize, coords.getY() + r * cellSize, cellSize);
        }
      }
    }
  }
  
  private boolean check(int row, int col, int num)
  {
    // check row
    for (int i = 0; i < 9; i++)
    {
      if (grid[row][i].getNumber() == num)
      {
        return false;
      }
    }
    
    // check column
    for (int i = 0; i < 9; i++)
    {
      if (grid[i][col].getNumber() == num)
      {
        return false;
      }
    }
    
    // check 3x3 cell
    int TLCornerR = row - row % 3;
    int TLCorcerC = col - col % 3;
    for (int r = TLCornerR; r < TLCornerR + 3; r++)
    {
      for (int c = TLCorcerC; c < TLCorcerC + 3; c++)
      {
        if (grid[r][c].getNumber() == num)
        {
          return false;
        }
      }
    }
    
    return true;
  }
  
  private int checkSingular(int row, int col)
  {
    int possibleCountRow = 9;
    int possibleCountCol = 9;
    int possibleCount3x3 = 9;
    
    for (int num = 1; num < 10; num++)
    {
      // check row
      for (int i = 0; i < 9; i++)
      {
        if (grid[row][i].getNumber() == num)
        {
          possibleCountRow--;
        }
      }
      
      // check column
      for (int i = 0; i < 9; i++)
      {
        if (grid[i][col].getNumber() == num)
        {
          possibleCountCol--;
        }
      }
      
      // check 3x3 cell
      int TLCornerR = row - row % 3;
      int TLCorcerC = col - col % 3;
      for (int r = TLCornerR; r < TLCornerR + 3; r++)
      {
        for (int c = TLCorcerC; c < TLCorcerC + 3; c++)
        {
          if (grid[r][c].getNumber() == num)
          {
            possibleCount3x3--;
          }
        }
      }
      if (possibleCountRow == 1 || possibleCountCol == 1 || possibleCount3x3 == 1)
      {
        return num;
      }
      possibleCountRow = 9;
      possibleCountCol = 9;
      possibleCount3x3 = 9;
    }
    return 0;
  }
  
  public void click(Coords click)
  {
    if (click.getX() > coords.getX() &&
        click.getX() < coords.getX() + 9 * cellSize &&
        click.getY() > coords.getY() &&
        click.getY() < coords.getY() + 9 * cellSize)
    {
      int clickR = (click.getY() - coords.getY()) / cellSize;
      int clickC = (click.getX() - coords.getX()) / cellSize;
      if (!grid[clickR][clickC].isFocused())
      {
        grid[clickR][clickC].focus();
      }
      else
      {
        grid[clickR][clickC].unfocus();
      }
      for (int r = 0; r < 9; r++)
      {
        for (int c = 0; c < 9; c++)
        {
          if (r != clickR || c != clickC)
          {
            grid[r][c].unfocus();
          }
        }
      }
    }
    else
    {
      for (int r = 0; r < 9; r++)
      {
        for (int c = 0; c < 9; c++)
        {
          grid[r][c].unfocus();
        }
      }
    }
  }
  
  public void input(boolean possible)
  {
    if ((int)key >= 48 && (int)key <= 57)
    {
      for (int r = 0; r < 9; r++)
      {
        for (int c = 0; c < 9; c++)
        {
          if (grid[r][c].isFocused())
          {
            if (!possible)
            {
              grid[r][c].setNumber((int)key - 48);
            }
            else
            {
              grid[r][c].addPossible((int)key - 48);
            }
          }
        }
      }
    }
  }
  
  public boolean hasFocused()
  {
    for (int r = 0; r < 9; r++)
      {
        for (int c = 0; c < 9; c++)
        {
          if (grid[r][c].isFocused())
          {
            return true;
          }
        }
      }
    return false;
  }
}

boolean[][] templateEasy1 = {
  {true, true, false, true, false, false, false, true, true },
  {true, false, true, false, false, true, false, false, true},
  {false, false, true, false, false, true, true, true, false},
  
  {true, false, false, true, true, false, false, true, false},
  {false, true, true, false, true, false, true, true, false },
  {false, true, false, false, true, true, false, false, true},
  
  {false, true, true, true, false, false, true, false, false},
  {true, false, false, true, false, false, true, false, true},
  {true, true, false, false, false, true, false, true, true }
};
boolean[][] templateEasy2 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateEasy3 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateMedium1 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateMedium2 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateMedium3 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateHard1 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateHard2 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
boolean[][] templateHard3 = {
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  
  {}, // 0 0 0   0 0 0   0 0 0
  {}, // 0 0 0   0 0 0   0 0 0
  {}  // 0 0 0   0 0 0   0 0 0
};
