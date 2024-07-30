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



listLength : (List a, Int) -> Int
listLength (list,count) = case list of
                        (_::others) => listLength (others,(count+1))
                        Nil => count 

dirs : List (Int,Int)
dirs = [ 
    (-1,-1),
    (-1,0),
    (-1,1),
    (1,-1),
    (1,0),
    (1,1),
    (0,-1),
    (0,1)
]


-- https://docs.idris-lang.org/en/latest/tutorial/typesfuns.html#maybe
listat : Nat -> List a -> Maybe a
listat _     Nil         = Nothing
listat Z     (x :: xs) = Just x
listat (S k) (x :: xs) = listat k xs

-- https://docs.idris-lang.org/en/latest/tutorial/typesfuns.html#maybe
listatdef : Nat -> List a -> a -> a
listatdef i xs def = case listat i xs of
                              Nothing => def
                              Just x => x

matat: (Matrix,Nat,Nat) -> Int
matat (matrix,row,col) = (listatdef col  (listatdef row matrix []) 0)


-- https://stackoverflow.com/a/61604447
fromIntegerNat : Int -> Nat
fromIntegerNat 0 = Z
fromIntegerNat n =
  if (n > 0) then
    S (fromIntegerNat (assert_smaller n (n - 1)))
  else
    Z

lookup: (Matrix,Int,Int) -> (Int,Int)  -> Bool
lookup (matrix,row,col) (0,0) = False
lookup (matrix,row,col) (drow,dcol) =  if  (matat ( matrix,
                                        fromIntegerNat ( 
                                                        (
                                                             mod ( row + drow + ( listLength (matrix,0) ) )  (listLength ( matrix,0 ) )
                                                          )
                                        ),
                                        fromIntegerNat ( 
                                                        (
                                                             mod ( col + dcol + ( listLength ( ( listatdef 0 matrix Nil ),0) ) )  (listLength ( ( listatdef 0 matrix Nil ),0 ) )
                                                          )
                                        )
                                        )) == 1 then True else False


alive_count : (Matrix, Int, Int) -> Int
alive_count (matrix,row,col) = listLength( ( filter (lookup(matrix,row,col) ) dirs ),0 )


listinsert: (List Int,Int) -> (Int) -> (List Int)
listinsert (list,index) (value) = (take( fromIntegerNat index ) list ) ++ [ value ] ++  ( drop ( fromIntegerNat (index+1) )  list) 

matinsert: (Matrix,Int,Int) -> (Int) -> Matrix
matinsert (matrix,row,col) (value) = (take( fromIntegerNat row ) matrix )
                                     ++ [( listinsert ( ( listatdef ( fromIntegerNat row ) matrix Nil ) , col ) value )] 
                                     ++  ( drop ( fromIntegerNat (row+1) )  matrix) 


mMat : Matrix
mMat =  [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,0,0,1,0],
            [0,1,1,1,0],
            [0,0,0,0,0]
            ]

buffer : Matrix
buffer =  [
            [0,0,0,0,0],
            [0,0,0,0,0],
            [0,0,0,0,0],
            [0,0,0,0,0],
            [0,0,0,0,0]
            ]

xcase : (Matrix,Matrix,Int,Int) -> Matrix--bufefr
xcase (matrix,buffer,y,x) = case ( alive_count (matrix,y,x)  ) of
                            3 =>  ( matinsert (buffer,y,x) 1 )
                            2 =>  ( matinsert (buffer,y,x) ( matat (matrix, ( fromIntegerNat y ) ,(fromIntegerNat x )) ) )
                            _ =>  ( matinsert (buffer,y,x) 0 )

xloop: (Matrix,Matrix,Int,Int,Int) -> Matrix
xloop (matrix,buffer,y,x,0)     = buffer 
xloop (matrix,buffer,y,x,until) = ( xloop ( matrix,  ( xcase (matrix,buffer,y,x) )  ,y, ( x + 1 ), ( until -1 ) ) ) 

ylooop: ( Matrix,Matrix,Int,Int) -> Matrix
ylooop (matrix,buffer,y,0) = buffer
ylooop (matrix,buffer,y,until) = ( ylooop (matrix, ( 
                                                        xloop  (
                                                                matrix,
                                                                buffer,
                                                                y,
                                                                0,
                                                                ( 
                                                                 listLength
                                                                 (
                                                                  ( listatdef ( fromIntegerNat y ) matrix Nil ) ,
                                                                  0 
                                                                  )
                                                                ) 
                                                                

                                                                ) 
                                                    ),
                                                    ( y + 1 ),
                                                    ( until - 1) 
                                          ) 
                                )
 

mainloop: (Matrix,Matrix,Int) -> List( IO())
mainloop (localMat,buffer,0) =  [ ( putStrLn "Game Completed" ) ]
mainloop (localMat,buffer,until) = (display_matrix  localMat ) ++ [ ( putStrLn "" ) ]  ++  ( mainloop ( ( ylooop  ( localMat ,buffer,0, ( listLength (  localMat ,0) )  ) ) ,buffer, ( until - 1 ) ) ) 


main : IO()
-- main  =  sequence_ $  display_matrix  mMat  
-- main  =  putStrLn $ show ( ( matinsert  (mMat,4,5) 10 ) )
-- main  =  putStrLn $ show ( [ ( listinsert ( ( listatdef ( fromIntegerNat 0 ) mMat Nil ) , 1 ) 5 ) ] )
main  = sequence_ $  ( mainloop (
                     mMat,
                     buffer,
                     120
                     )
         ) 

