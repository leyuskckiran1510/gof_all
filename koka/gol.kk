fun rowdisplay(row: list<int> ): console (){
   match row 
            Cons(col,cols)->{
                if col == 1 then{
                    print("⬜")
                }else{
                    print("⬛")
                }
                cols.rowdisplay()
            }
            Nil -> {
                println("")
            }   
}


fun display(matrix : list<list<int>> ): console () {
    match matrix
        Cons(row,rows)->{
            row.rowdisplay()
            rows.display()
        }
        Nil -> ()
}


fun alive(matrix: list<list<int>> , y :int ,x: int){
    var count := 0
    val dirs = [
        [1,-1],
        [1,0],
        [1,1],
        
        [-1,-1],
        [-1,0],
        [-1,1],

        [0,1],
        [0,-1],
    ]
    for(0,dirs.length - 1)fn(index){
        val newx = (x + matrix.length + dirs.costumeAt(index,0) ) % matrix.length
        val newy = (y + matrix.length + dirs.costumeAt(index,1) ) % matrix.length
        if matrix.costumeAt(newy,newx) == 1 then{
            count := count + 1 
        }
    }
    return count
}

fun workon_row(y:int, row : list<int>,matrix: list<list<int>> ){
    var count := 0
    row.foreach-indexed(fn(x,_){
       count := alive(matrix,x,y)
        }
    )
    println("" ++count.show)
}

fun costumeAt (twoD:list<list<int>>,y:int,x:int) {
    return twoD.drop(y).take(1).head().default([]).drop(x).head().default(-1);

}

fun costumeInsert(matrix: list<list<int>> , y:int,x:int,value:int) {
    var xpart := matrix.drop(y).take(1).head().default([])
    return matrix.take(y) ++ [ xpart.take(x) ++ [value] ++ xpart.drop(x+1) ] ++ matrix.drop(y+1)
}


fun next_step(matrix: list<list<int>>){
    var count := 0
    var buffer := [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0]
    ];
    for(0,matrix.length - 1) fn(y){
        for(0,matrix.length - 1) fn(x){
            count := alive(matrix,y,x)
            if count == 3 then{
                buffer := buffer.costumeInsert(y,x,1)
            }else if count == 2 then {
                val old_value = matrix.costumeAt(y,x)
                buffer :=  buffer.costumeInsert(y,x,old_value)
            }else{
                buffer :=  buffer.costumeInsert(y,x,0)
            }
        }
    }
    return buffer;
}

fun delay(value:int){
    var x:=0
    for(0,value) fn(_){
        x:=0
    }
}

fun main(){
    var  matrix := [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,0,1,0],
        [0,1,1,1,0],
        [0,0,0,0,0]
    ];
    for(0,200) fn(_){
        print("\x1b[1J\x1b[1;1H\n")
        matrix.display()
        matrix := matrix.next_step()
        delay(10000000);
    }
 
}