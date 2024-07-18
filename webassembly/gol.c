#include <stdio.h>
#include <stdlib.h>
#include <emscripten.h>

#define EK  EMSCRIPTEN_KEEPALIVE void
#define ROWS 5
#define COLS 5

int matirx[ROWS][COLS] = {
    {0,0,0,0,0},
    {0,0,1,0,0},
    {0,0,0,1,0},
    {0,1,1,1,0},
    {0,0,0,0,0},
};

int alive(int matirx[ROWS][COLS],int x ,int y){
    int alive_count = 0;
    for (int dy = -1; dy <= 1 ; dy++){
        for (int dx = -1; dx <= 1 ; dx++){
            if (!dx && !dy) continue;
            int newx = ( x + dx + COLS ) % COLS;
            int newy = ( y + dy + ROWS ) % ROWS;
            if(matirx[newy][newx])
                alive_count++;
        }
    }
    return alive_count;
}

void copy(int  des[ROWS][COLS],int src[ROWS][COLS]){
    for (int row = 0; row < ROWS; ++row){
        for (int col = 0; col < COLS; ++col){
            des[row][col] = src[row][col];
        }
    }

}

void get_next_step(){
    int buff[ROWS][COLS]={0};
    for(int row=0;row<ROWS;row++){
        for(int col=0;col<COLS;col++){
            switch (alive(matirx,col,row)) {
                case 3:{
                    buff[row][col] = 1;
                    break;
                }
                case 2:{
                    buff[row][col] = matirx[row][col];
                    break;

                }
            default:{
               buff[row][col] = 0; 
            }
            }
        }
    }
    copy(matirx,buff);
}


int copy_str(char *src,char *des){
    int c =0;
    while(src[c]){
        des[0]=src[c++];
        des++;
    }
    return c;
}

EMSCRIPTEN_KEEPALIVE void get_next_step_html(char ** desbuff){
    char *alive_div = "<div class='box alive'></div>"; 
    char *dead_div = "<div class='box dead'></div>"; 
    char *buff = malloc(sizeof(char)*1000);
    char *it = buff;
    int cnt=0;
    for(int row=0;row<ROWS;row++){
        for(int col=0;col<COLS;col++){
            if(matirx[row][col]){
                cnt = copy_str(alive_div,buff);
            }else{
                cnt = copy_str(dead_div,buff);
            }
            buff+=cnt;
        }
    }
    *desbuff = it;
    get_next_step();
}
