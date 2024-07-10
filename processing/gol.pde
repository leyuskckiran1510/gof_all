int[][] matrix= {
  {0,0,0,0,0},
  {0,0,1,0,0},
  {0,0,0,1,0},
  {0,1,1,1,0},
  {0,0,0,0,0},
};
int[][] dirs = {
  {1,0},
  {1,1},
  {1,-1},
  {-1,0},
  {-1,1},
  {-1,-1},
  {0,1},
  {0,-1},

};
int colCount = 5;
int rowCount = 5;
int srtW = 3;
int CW = 500;
int CH= 500;
int boxW = CW/colCount;
int boxH = CH/rowCount;

void drawMatrix(int[][] matrix){
  for(int y=0; y < matrix.length ; y++){
    for(int x=0;x< matrix[0].length;x++){
      stroke(srtW);
      if(matrix[y][x]==1)
        fill(0);
      else
        fill(0xfff);
      rect(x*boxW,y*boxH,boxW,boxH);      
    }  
    
  }
  
}

int[][] initMatrix(){
  int rows = CH/boxH;
  int cols = CW/boxW;
  int[][] tempbuff=new int[rows][cols];
  for(int y=0,iy=0;y<CH;y+=boxH,iy++){
    for(int x=0,ix=0;x<CW;x+=boxW,ix++){
      tempbuff[iy][ix] = random(0,100)>50?1:0;
    }
  }
  return tempbuff;
}

void setup() {
  surface.setSize(CW,CH);
  matrix = initMatrix();
  drawMatrix(matrix);
  frameRate(30);
  noLoop();
}



int alive(int[][] matrix,int x,int y){
  int count = 0;
  for ( int idx = 0; idx < dirs.length ; idx++  ){
    int newx = (x+dirs[idx][0]+matrix[0].length)%matrix[0].length;
    int newy = (y+dirs[idx][1]+matrix.length)%matrix.length;
    if (matrix[newy][newx]==1)
      count++;
  }
  return count;
  
}


void draw() {
   int rows = CH/boxH;
  int cols = CW/boxW;
  int[][] buff=new int[rows][cols];
  for(int y=0; y < matrix.length ; y++){
    for(int x=0;x< matrix[0].length;x++){
      int alv = alive(matrix,x,y);
      if (alv == 3){
        buff[y][x] = 1;
      }else if (alv == 2){
        buff[y][x] = matrix[y][x];
      }else{
       buff[y][x] = 0;
      }
    }
  }
  drawMatrix(matrix);
  matrix=buff;
}