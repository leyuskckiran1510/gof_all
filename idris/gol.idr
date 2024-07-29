import Data.List


Matrix : Type
Matrix = List (List Int)


display_col :  Int -> IO()
display_col x =  case  x of 
                1 => putStr "⬜"
                _ => putStr "⬛"


display_row : List Int -> List (IO())
display_row x = map display_col x


display_matrix : Matrix -> List (IO())
display_matrix x  = case x of
                    (first::others) => display_row first ++  [ putStrLn "" ]  ++ display_matrix others
                    Nil => Nil




-- let alive (x:int) (y:int ) (matrix:int list list) =
--    List.listLength (List.filter ( fun dir -> 1 =  lookup matrix  dir x y ) dirs);;

listLength : (List a, Int) -> Int
listLength (list,count) = case list of
                        (_::others) => listLength (others,(count+1))
                        Nil => count 



dirs : Matrix
dirs = [ 
    [-1,-1],
    [-1,0],
    [-1,1],
    [1,-1],
    [1,0],
    [1,1],
    [0,-1],
    [0,1]
]

lookup : (Matrix,Int,Int) -> List Int -> Bool
-- lookup (matrix,row,col,drow,dcol) = index ((index(matrix(mod(row + drow + ( listLength matrix ))  ( listLength matrix ))) )
--                                          (mod (col + dcol + ( listLength index matrix 0 )) (listLength index matrix 0)))

lookup (matrix,row,col) offset_list = True


alive_count : (Matrix, Int, Int) -> Int
alive_count (matrix,row,col) = listLength( ( filter (lookup(matrix,row,col) ) dirs ),0 )

    


myList : Matrix
myList =  [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,0,0,1,0],
            [0,1,1,1,0],
            [0,0,0,0,0]
            ]



main : IO ()
-- main  =  sequence_ $ display_matrix myList
main  =  putStrLn $ show ( alive_count (myList,1,1))