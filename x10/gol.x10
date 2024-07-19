import x10.io.Console;

class GOL {


    public static def display_rail(matrix:Rail[Long],rows:Long,cols:Long){
        Console.OUT.println("\u001b[1J\u001b[1;1H");
        for (row in 0..(rows-1)){
            for (col in 0..(cols-1)){
                if( matrix(row*rows+col) ==1){
                    Console.OUT.print("⬜");
                }else{
                    Console.OUT.print("⬛");
                }
            }
            Console.OUT.println("");
        }
    }


    public static def alive(matrix:Rail[Long],rows:Long,cols:Long,y:Long,x:Long){
        var count:Long = 0;
        for (dy in  -1..1){
            for (dx in  -1..1){
                if(dx == 0 &&  dy == 0 ){
                    continue;
                }

                var newx:Long = ( x + dx + cols ) % cols;
                var newy:Long = ( y + dy + rows ) % rows;
                if(matrix(newy*rows+newx)==1) count+=1;
            }

        }
        return count;
    }

    public static def next_stemp(matrix:Rail[Long],rows:Long,cols:Long){
         var buff:Rail[Long] = new Rail[Long](rows*cols,0);
         for (row in 0..(rows-1)){
            for (col in 0..(cols-1)){
                var count:Long = alive(matrix,rows,cols,row,col);
                if(count==3){
                        buff(row*rows+col) = 1;
                    }else if ( count ==2 ) {
                        buff(row*rows+col) = matrix(row*rows+col);
                    }else{
                        buff(row*rows+col) = 0;
                }
            }
        }
        return buff;
    }
    
    public static def main(args:Rail[String]) {
            var matrix:Rail[Long] =  new Rail[Long](25, 0);
            /*
                0 0 0 0 0 
                0 0 1 0 0 
                0 0 0 1 0 
                0 1 1 1 0 
                0 0 0 0 0 

            */

            matrix(1*5+2) = 1;
            matrix(2*5+3) = 1;
            matrix(3*5+1) = 1;
            matrix(3*5+2) = 1;
            matrix(3*5+3) = 1;
            for (_ in 0..10000 ){
                    display_rail(matrix,5,5);
                    matrix = next_stemp(matrix,5,5);
                    System.sleep(200);            
           }

    }
}