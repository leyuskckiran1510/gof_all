const std = @import("std");
const print = std.debug.print;
const sleep = std.time.sleep;

const ROWS = 50;
const COLS = 50;

const MatrixT = [ROWS][COLS]i32;

pub fn display(matrix:MatrixT) void {
    print("\x1b[1J\x1b[1;1H",.{});
    for (matrix)|row| {
        for (row)|col| {
                if(col==1){
                    print("⬜",.{});
                }else{
                    print("⬛",.{});
                }
        }
        print("\n",.{});
    }
}

pub fn alive(matrix:MatrixT,row:i32,col:i32 ) i32 {
    var count:i32 = 0;
    const dir = [_]i32{-1,0,1};
    for (dir)|dy| {
        for (dir)|dx| {
            if(dy==0 and dx==0) continue;
            const newx:usize = @intCast(@mod(( col + dx + COLS ),  COLS));
            const newy:usize = @intCast(@mod(( row + dy + ROWS ),  ROWS));
            if(matrix[newy][newx]==1){
                count+=1;
            }
        }
    }
    return count;
}


pub fn next_step(matrix:MatrixT) MatrixT {
    var buff:MatrixT=undefined; 
    for(0..matrix.len)|row|{
        for(0..matrix[row].len)|col|{
            const alives = alive(matrix,@intCast(row),@intCast(col));
            buff[row][col] = switch (alives) {
                3 => 1,
                2 => matrix[row][col],
                else => 0,
            };
        }
    }
    return buff;
}


pub fn fill_random() MatrixT {
    var buff:MatrixT = undefined;
    for(0..buff.len)|row|{
        for(0..buff[row].len)|col|{
            const rand = std.crypto.random;
            if(rand.float(f32)>0.5){
                buff[row][col] =1;
            }else{
                buff[row][col] = 0;

            }
        }
    }
    return buff;
}


pub fn main() !void {
    var a :MatrixT = fill_random();
    a[1][2]=1;
    a[2][3]=1;
    a[3][1]=1;
    a[3][2]=1;
    a[3][3]=1;



    //  { 
    //     [_] i32 { 0, 0, 0, 0, 0 },
    //     [_] i32 { 0, 0, 1, 0, 0 },
    //     [_] i32 { 0, 0, 0, 1, 0 },
    //     [_] i32 { 0, 1, 1, 1, 0 },
    //     [_] i32 { 0, 0, 0, 0, 0 },
    // };
    for (0..100000) |_| {
        display(a);
        a = next_step(a);
        sleep(3e+8/ROWS);
    }
}