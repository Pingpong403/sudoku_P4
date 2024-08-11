# Sudoku
### made in Processing
My rendition of the classic numbers game, sudoku.\n

I started creating this at the cell level, getting the alignment and presentation working before moving on to the entire grid.\n

Once I had that looking good, I got to work getting the board populated. I naively set up a quick and dirty process for populating an easy board. I'll come back to this later.\n

I then moved on to input. Processing doesn't have the most elegant keyboard interface, but it worked just fine for my purposes. I allowed the user to choose between
entering a "guess" number and the "actual" number (called "possible" and "true" in-game, respectively).\n

Once I got to testing the "final" product, I noticed a problem: some boards are 100% impossible to fill out correctly. In fact, some boards would crash the game 
while it tried to find a number that can go in an impossible spot. I quickly found out that making a sudoku board is not as easy as it seems.\n

All in all, this is a work-in-progress. One day I will come back and figure out a way to recursively populate a (correct) sudoku board that the user can enjoy filling out.
