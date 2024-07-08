import std/[os,math]
type
  Matrix[W, H: static[int]] =
    array[1..W, array[1..H, int]]

const W = 15
const H = 15
const FPS = 10

proc alive(matrix:Matrix[W,H],x,y:int): int =
    let dirs:Matrix[8,2] = [
            [1,-1],
            [1,0],
            [1,1],
            [-1,-1],
            [-1,0],
            [-1,1],
            [0,1],
            [0,-1],
    ] 
    var count:int = 0
    for dir in dirs:
        var newx =  ( x + dir[1] + W ) mod W
        var newy = ( y + dir[2] + H ) mod H 
        if newx == 0:
            newx = W
        if newy == 0:
            newy = H

        if matrix[newy][newx] == 1:
            count += 1
    return count




proc print(a:Matrix[W,H])  = 
    # clear screen and move cursor to (1,10)[x,y]
    stdout.write "\x1b[2J\x1b[10;1H"
    for row in a:
        stdout.write "\t"
        for col in row:
            if(col == 1):
                stdout.write "⬜"
            else:
                stdout.write "⬛"
        echo("")


proc next_step(matrix:Matrix[W,H]): Matrix[W,H]=
    var buffer:Matrix[W,H];
    for y in low(matrix)..high(matrix):
        for x in  low(matrix[y])..high(matrix[y]):
            case alive(matrix,x,y):
                of 3:
                    buffer[y][x] = 1
                of 2:
                    buffer[y][x] = matrix[y][x]
                else:
                    buffer[y][x] = 0
    return buffer


proc glider(matrix:Matrix[W,H]):Matrix[W,H]=
    var matrix:Matrix[W,H];
    matrix[2][3]=1;
    matrix[3][4]=1;
    matrix[4][4]=1;
    matrix[4][3]=1;
    matrix[4][2]=1;
    return matrix

var matrix:Matrix[W,H];

matrix = glider(matrix)


while 1==1:
    print(matrix)
    matrix = next_step(matrix)
    sleep( int( 1000/FPS))