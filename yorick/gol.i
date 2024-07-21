func display(matrix){
    rows = dimsof(matrix)(2);
    cols = dimsof(matrix)(3);
    write,"\x1b[1J\x1b[1;1H";
    for (row=1 ;row<=rows ; row++) {
        line = ""
        for (col=1;col<=cols;col++) {
            if(matrix(col,row)==1){
                line = line + "⬜";
            }else{
                line = line + "⬛";

            }
        }
        write,line;
    }
}

func alive(matrix,row,col) {
    rows = dimsof(matrix)(2);
    cols = dimsof(matrix)(3);
    count = 0;
    for (dy=-1 ;dy<=1 ; dy++) {
        for (dx=-1;dx<=1;dx++) {
            if(dy==0 && dx==0){
                continue;
            }
            new_row = ( row + rows + dy  ) % rows;
            new_col = ( col + cols + dx ) % cols;
            if(new_row==0){
                new_row = rows;
            }
            if(new_col==0){
                new_col=cols;
            }
            if( matrix(new_col,new_row) == 1){
                count +=1;
            }
        }
    }
    return count;
}

func next_step(matrix){
    temp = array(0,dimsof(matrix));
    rows = dimsof(matrix)(2);
    cols = dimsof(matrix)(3);
    for(row=1;row<=rows;row++){
        for(col=1;col<=cols;col++){
            count = alive(matrix,row,col);
            if(count==3){
                temp(col,row) = 1;
            }else if(count == 2){
                temp(col,row) = matrix(col,row);
            }else{
                temp(col,row) = 0;
            }
        }
    }
    return temp;

}


matrix = [
          [0,0,0,0,0],
          [0,0,1,0,0],
          [0,0,0,1,0],
          [0,1,1,1,0],
          [0,0,0,0,0]
          ];

for(i=0;i<20000;i++){
    display,matrix
    matrix = next_step(matrix)
    //sleep/delay
    for (j = 0; j < 1000000; ++j){}
}
quit;