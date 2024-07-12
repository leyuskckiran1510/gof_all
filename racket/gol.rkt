#lang racket


(define (conditional-print a )
  (match a 
    [ 1 (printf "⬜" )]
    [ _ (printf "⬛" )]
    )
  
  )

(define (display-row row)
    (match row 
    [(list a b ... ) ( conditional-print a ) ( display-row b) ]
    [_        ( printf "\n" )])
)


(define (display-matrix matrix)
   (match matrix
    [(list a b ... )  ( display-row a) ( display-matrix b )  ]
    [_        printf " "])

)


(define (nth list-like x)
  (last (take list-like x))
)
(define (2nth mat-like x y  )
 (nth (nth mat-like x ) y)
)


(define (insert list-like idx val)
    (append (take list-like (- idx 1)) (list val) (list-tail list-like idx) )  
)
(define (2dinsert mat-like idx1 idx2 val)
    (append (take mat-like (- idx1 1))  ( list (insert (nth mat-like idx1) idx2 val) ) (list-tail mat-like idx1) )  
)


(define (alive matrix x y )
  (define count 0)
  (define nx 0 )
  (define ny 0 )
  (define rows (length matrix))
  (define cols (length (nth matrix y)))
  (for ([dy (in-range -1 2)])
    (for ([dx (in-range -1 2)])
      (match (list dy dx)
        ;skip 0,0 
        [(list 0 0) #f]
        [ _ 
            ; compute new index for x,y
            (match (list ( remainder (+ y dy rows ) rows)  
                         ( remainder (+ x dx cols ) cols)
                         )
                [(list 0 0 ) (set! nx cols  ) (set! ny rows ) ]
                [(list 0 lny )  (set! nx cols  ) (set! ny lny ) ]
                [(list lnx 0 )  (set! nx lnx ) (set! ny rows ) ]
                [ (list lnx lny)   (set! nx lnx ) (set! ny lny ) ]
            )
            ; check for value in new-idx
            (match (2nth matrix ny nx)
                [ 1 (set! count (add1 count))]
                [_ #f]  
            )   
        ]
       )
    )
  )
 count
)
(define (next-step matrix )
      (define buffer (map (lambda (x) x) matrix) )
        (for ([y (in-range 1 ( + (length matrix) 1 ) ) ])
        (for ([x (in-range 1 ( + (length (nth matrix y)) 1)  )])
            (match (alive matrix y x)
              [3 (set! buffer (2dinsert buffer y x 1))]
              [2 (set! buffer (2dinsert buffer y x (2nth matrix y x) ))]
              [_ (set! buffer (2dinsert buffer y x 0))] 
              [_  #f]
        )
      )
    )
    
    buffer  
)
(define matrix (list 
                 (list 0 0 0 0 0)
                 (list 0 0 1 0 0)
                 (list 0 0 0 1 0)
                 (list 0 1 1 1 0)
                 (list 0 0 0 0 0)
                     )
   )

(for ([ y (in-range 1 100000)])
    (printf "\x1b[1J\x1b[1;1H")  
    (display-matrix matrix )
    (set! matrix (next-step matrix))
    (sleep 0.1) 
)
