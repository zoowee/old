/*
Super Kitty

Author: Jerica Ju
Date: 12.02.2019
*/

PImage bg, cat, botPipe, topPipe, start;
int bgx, bgy, cx, cy, g, Vcy;
int[] pipeX, pipeY;
int gameState, score, highScore;

void setup(){
  size(750, 550);
  bg = loadImage("./img/bg.png");
  cat = loadImage("./img/cat.png");
  start = loadImage("./img/start.png");
  botPipe = loadImage("./img/botPipe.png");
  topPipe = loadImage("./img/topPipe.png");
  cx = 100;
  cy = 50;
  g = 1;
  pipeX = new int[5];
  pipeY = new int[pipeX.length];
  for(int i = 0; i < pipeX.length; i++){
    pipeX[i] = width + 200*i;
    pipeY[i] = (int)random(-350,0);
  }
  gameState = -1;
}


void draw(){
  if(gameState == -1){
    startScreen();
  }
  else if(gameState == 0){
    setBg();
    setPipes();
    cat();
    setScore();
  }
  else{
    endScreen();
    restart();
  }
}

void setBg(){
  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx = bgx - 1;
  if(bgx < -bg.width){
    bgx = 0;
  }
}

void setPipes(){
  for(int i = 0; i < pipeX.length; i++){
    image(topPipe, pipeX[i], pipeY[i]);
    image(botPipe, pipeX[i], pipeY[i] + 575);
    pipeX[i]-= 4;
    if(score > 10){
      pipeX[i]--;  //speed up at score of 10 points
    }
    if(score > 20){
      pipeX[i]--;  //speed up again at 20 points  
    }
    if(pipeX[i] < -200){
      pipeX[i] = width;  
    }
    //collision
    if(cx > (pipeX[i] - 63) && cx < pipeX[i] + 70){
      if(!(cy > pipeY[i] + 418 && cy < pipeY[i] + (418 + 157 - 50))){
        gameState = 1;
        fill(255, 0, 0, 200);
        textSize(20);
        rect(20, height - 223, 455, 32);
        fill(0);
        text(" You crashed Kitty into a pipe :(", 20, height - 200);      
        gameState = 1;
      }
      //score if pass through pipe
      else if (cx == pipeX[i] || cx == pipeX[i] + 1){
        score++;  
      }
    }
  }  
}

void mousePressed(){
  Vcy = -10;
}

void keyPressed(){
  Vcy = -10;
}

void cat(){
  image(cat, cx, cy);
  cy = cy + Vcy;
  Vcy = Vcy + g;
  if(cy > height || cy < 0){
    fill(255);
    rect(16, 18, 500, 40);
    fill(0, 0 , 255, 255);
    textSize(24);
    text(" Oops, you killed the cat.", 20, 45);
    gameState = 1;
  }
}

void endScreen(){
  fill(150, 150, 250, 100);
  if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290){
    fill(150, 250, 150, 100);
  }
  rect(90, 150, 505, 140, 5);
  fill(0);
  textSize(40);
  text("Kitty died  : (", 200, 200);
  text("Click HERE to play again."   , 100, 270);
}

void restart(){
  if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290){
    if(mousePressed){
      gameState = -1;
      cx = 100;
      cy = 50;
      g = 1;
      pipeX = new int[5];
      pipeY = new int[pipeX.length];
      for(int i = 0; i < pipeX.length; i++){
        pipeX[i] = width + 200*i;
        pipeY[i] = (int)random(-350,0);
      }
    }
  }
}

void startScreen(){
  image(start, 0, 0);
  if(mousePressed){
    cy = height/2;
    gameState = 0;
  }
}

void setScore(){
  if(score > highScore){
    highScore = score;
  }
  fill(160, 160, 160, 200);
  rect(width - 175, 10, 155, 80, 5);
  fill(0);
  textSize(20);
  text("Score: " + score, width - 170, 40);
  text("High Score: " + highScore, width - 170, 80);
}
