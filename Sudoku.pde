import java.util.Vector;
import java.util.Random;

Random rand = new Random();

// CUSTOM MOUSE CLICKING TOOL
boolean mouseChoose = false;
void mouseReleased() {
  mouseChoose = true;
  // set to false at the end of drawing phase
}

// CONSTANTS
float MARGIN = 0.3;
int CELL_SIZE = 70;

Grid g1 = new Grid((1000 - CELL_SIZE * 9) / 2, (700 - CELL_SIZE * 9) / 2, CELL_SIZE);

enum InputModes { POSSIBLE, TRUE }
InputModes inputMode = InputModes.POSSIBLE;

void setup()
{
  size(1000, 700);
  g1.populate(Level.EASY);
}

void draw()
{
  background(200, 200, 200);
  
  g1.drawGrid();
  if (mouseChoose)
  {
    g1.click(new Coords(mouseX, mouseY));
  }
  noStroke();
  textSize(20);
  textAlign(CENTER);
  String inputModeDisplay;
  if (inputMode == InputModes.TRUE)
  {
    inputModeDisplay = "True";
  }
  else if (inputMode == InputModes.POSSIBLE)
  {
    inputModeDisplay = "Possible";
  }
  else
  {
    inputModeDisplay = "N/A";
  }
  text(inputModeDisplay, 500, 30);
  
  mouseChoose = false;
}

void keyPressed()
{
  if (key == 'i' || key == 'I')
  {
    if (inputMode == InputModes.TRUE)
    {
      inputMode = InputModes.POSSIBLE;
    }
    else
    {
      inputMode = InputModes.TRUE;
    }
  }
  if (key == 'n' || key == 'N')
  {
    g1.populate(Level.EASY);
  }
  if (g1.hasFocused())
  {
    if (inputMode == InputModes.TRUE)
    {
      g1.input(false);
    }
    else if (inputMode == InputModes.POSSIBLE)
    {
      g1.input(true);
    }
  }
}
