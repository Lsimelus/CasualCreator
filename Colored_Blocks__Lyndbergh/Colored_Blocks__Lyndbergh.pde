ArrayList<Blocks> theBlocks =  new ArrayList<Blocks>();

void setup() {
  size(1000, 800, P3D);
}

void draw() {
  // Clear the background.
  background(0, 0, 0);

  // If the user clicks...
  if (mousePressed)
  {
    // Create a Bubble and add it to the current index in our array.
    // The Bubble should be placed where the user clicked.
    int MAX = 500;
    Blocks novice = new Blocks(this, mouseX, mouseY);
    theBlocks.add(novice);
     

    // Did we just use our last slot?  If so, we can reuse old slots.
    if (theBlocks.size() >= MAX)
    {
      theBlocks.remove(0);
    }

  }
  
  if (keyCode == DOWN){
    for (int i = 0; i < theBlocks.size(); i++){
      if (theBlocks.get(i).gravity()){
         theBlocks.remove(0);
      }
    }
  }
  
  if (keyCode == UP){
    for (int i = 0; i < theBlocks.size(); i++){
      theBlocks.get(i).grow();
    }
  }
  if (keyCode == RIGHT){
    for (int i = 0; i < theBlocks.size(); i++){
      delay(1);
      theBlocks.get(i).recolor();
    }
  }
  
  if (keyCode == SHIFT){
    for (int i = 0; i < theBlocks.size(); i++){
      theBlocks.get(i).earthquake();
    }
  }
  
  
  if (keyCode == LEFT){
    if(theBlocks.size() != 0){
      int unlucky = int(random(0, theBlocks.size()));
      theBlocks.remove(unlucky);
      delay(2);
    }
  }
  if(keyCode == ENTER){
    for (int i = 0; i < theBlocks.size(); i++){
      delay(2);
      theBlocks.get(i).newShape();
    }
  }
  if(keyCode == CONTROL){
    for (int i = 0; i < theBlocks.size(); i++){
      theBlocks.get(i).explode();
    }
    
  }

  // Draw all bubbles that have been created.
  for (int i = 0; i < theBlocks.size() - 1; i++){
      theBlocks.get(i).display();
      
  }
  
}

class Blocks {
  // The position of this Bubble.
  private float x;
  private float y;

  // The size of this Bubble.
  private float size;

  // How much red, green, and blue this Bubble has.
  private float myRed;
  private float myGreen;
  private float myBlue;
  
  //The shape of the block
  private int shape = int(random(0,8));
  
  //ONce the blocks would explode, this is would determine the direction adn speed
  private float speedX = random(-1, 1);
  private float speedY = random(-1, 1);
  
  //Variables necessary to bounce
  float speed = 0;
  float gravity = .1;
  
  // Store a reference to the canvas.
  private PApplet canvas;

  Blocks(PApplet canvas, float x, float y) {
    // Store a reference to the canvas.
    this.canvas = canvas;

    // Store x and y.
    this.x = x;
    this.y = y;

    // Randomize our size.
    size = this.canvas.random(5,25);

    // Randomize our color.
    myRed = this.canvas.random(0,255);
    myGreen = this.canvas.random(0,255);
    myBlue = this.canvas.random(0,255);


  }
  //
  boolean gravity(){
    this.speed += gravity;
    
    y += speed;
    
    if(y > height){
      speed = speed * -0.75;
      y = height;
    }
    if(abs(speed) < .01 & y > 775){
      return true;
      
    }
    return false;
  }
  
  //The size of the shape grows at a constant rate
  void grow(){
    this.size += .25;
  }
  
  //The positions of the shapes change each iteration, simulating an earthquake
  void earthquake(){
    x += random(-5, 5);
    y += random(-5, 5);
  }
 
  //The shapes moves a direction and a constant speed
  void explode(){
  // Updates position based on speed.
  x += speedX;
  y += speedY;
  }
  
  //The colors of the shapes changes
  void recolor(){
    this.myRed = random(0,255);
    this.myGreen = random(0,255);
    this.myBlue = random(0,255);
   }
  
  //The blocks shape has a large chance of changing shape
  void newShape(){
     this.shape = int(random(0,8));
  }
  
  //This determines the apearance of the Block
  void display() {
  // This method specifies our Bubble will not have an outline.
  this.canvas.noStroke();

  // Specifies the fill for the Bubble.
  this.canvas.fill(myRed, myGreen, myBlue);

  switch(shape) {
  case 0: 
    this.canvas.circle(x, y, size);
    break;
 case 1: 
    this.canvas.ellipse(x, y, size, size/2);
    break;
 case 2:
    this.canvas.triangle((x - size/2), (y -size/2), (x + size/2) , (y -size/2), x, y + (size/2));
     break;
 case 3:
   this.canvas.triangle((x - size/2), (y + size/2), (x + size/2) , (y  + size/2), x, y - (size/2));
    break;
 case 4://4 and 5 are trapezoids 
    beginShape();
    vertex(x - (size/4), y - size/4);
    vertex(x - (size/2), y + size/4);
    vertex(x + (size/2), y + size/4);
    vertex(x + (size/4), y - size/4);
    endShape();
    break;
 case 5:
   beginShape();
   vertex(x - (size/4), y + size/4);   
    vertex(x - (size/2), y - size/4);
    vertex(x + (size/2), y - size/4);
    vertex(x + (size/4), y + size/4);
    endShape();
    break;
 case 6:
  this.canvas.rect((x - size/2), (y -size/2), size/2, size);
  break;
 case 7://A diamond
    beginShape();
    vertex(x , y + size);   
    vertex(x - (size/4), y);
    vertex(x , y - size);
    vertex(x + size/4, y);
    endShape();
    break;
 default: 
    this.canvas.rect((x - size/2), (y -size/2), size, size);
    break;
 
  }
  }
}
