( import copy [deepcopy] )
( import time )

(
 defn alive [matrix  x y]

    ( sum ( lfor [ dx dy ] [
        [ 1  -1 ]
        [ 1  0 ]
        [ 1  1 ]
        [ -1  -1 ]
        [ -1  0 ]
        [ -1  1 ]
        [ 0  -1 ]
        [ 0  1 ]
    ] 
    ( .__getitem__ (.__getitem__ matrix   ( % ( + y dy ) (len matrix) ) )   ( % ( + x dx ) (len ( .__getitem__ matrix 0)) )   )
    )
    )

)

(

    defn next_step [ matrix  ] 
    (setv new  ( deepcopy matrix))
    ( for [y  ( range (len matrix ) ) ] 
        (for [x   ( range ( len ( .__getitem__ matrix 0 ) ) ) ]
                    (setv count  (alive matrix x y) )
                    (if ( = 3 count ) 
                            ( .__setitem__ ( .__getitem__ new y )  x 1 )
                            ( if ( = 2 count) 
                                ( .__getitem__ ( .__getitem__ new y )  x );just random code
                                ( .__setitem__ ( .__getitem__ new y )  x 0 )
                             )
                            )
        )
    )

    new
)


( defn display [matrix ]

    (print "\x1b[1J\x1b[1;10H")
   ( for [y (range (len matrix ) ) ]
          ( for [x  (range (len ( .__getitem__ matrix y  ) ) ) ]
                         ( if ( = 1  (.__getitem__ (.__getitem__  matrix y )  x ) ) 
                             ( print "⬜"  :end "" )
                             ( print "⬛"  :end "")
                        )
            )
           (print )
    )
)


( defn main [x]
    ( setv  matrix  [
        [0  0  0  0  0] 
        [0  0  1  0  0] 
        [0  0  0  1  0] 
        [0  1  1  1  0] 
        [0  0  0  0  0] 
    ]
    )

    ( while (= True True )
        ( display matrix)
        ( setv matrix  ( next_step matrix) )
        (  time.sleep  0.3  )

    )

)



( main 0 )
