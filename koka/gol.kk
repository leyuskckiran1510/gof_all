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


fun at(twoD:list<list<int>>,x:int,y:int) {
    match twoD.drop(y).take(1).drop(x)
        Cons(m,_) -> return m
        Nil -> return -1
}

fun alive(matrix: list<list<int>> , x :int ,y: int){
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
    for(0,dirs.length)fn(index){
        val newx = (x + matrix.length + dirs.at(index,0))%matrix.length
        val newy = (y + matrix.length + dirs.at(index,1))%matrix.length
        if matrix.at(newy,newx)==1 then{
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
    println(""++count.show)
}

fun insert(matrix: list<list<int>> , x:int,y:int,value:int) {
    var new:= []
    new ++ matrix.take(y-1)
    new ++ matrix.drop(y-1).take(x-1)
}


fun next_step(matrix: list<list<int>> ) : console () {
    var count := 0
    var buffer := [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0]
    ];
    for(0,matrix.length) fn(y){
        for(0,matrix.length) fn(x){
            count := alive(matrix,x,y)
            if count == 3 then{
                buffer.insert(x,y,1)
            }else if count == 2 then {
                val old_value = matrix.at(y,x)
                buffer.insert(x,y,old_value)
            }else{
                buffer.insert(x,y,0)
            }
        }
    }
    matrix.display()
}


fun main() : console (){
    val  matrix = [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,0,1,0],
        [0,1,1,1,0],
        [0,0,0,0,0]
    ];
    matrix.next_step()
}