
(defconstant MAT-WIDTH 5
  "width of matrix")

(defconstant MAT-HEIGHT 5
  "width of matrix")

(defparameter matrix (list 
                       0 0 0 0 0
                       0 0 1 0 0
                       0 0 0 1 0
                       0 1 1 1 0
                       0 0 0 0 0
                       ))

(defun dismat ( matrix )
  (dotimes (y MAT-HEIGHT)
    (
     dotimes (x MAT-WIDTH) 
     (
      if (= 1 (matat matrix x y))
      ( format t "⬜" )
      ( format t  "⬛" )
      )
     
     ) 
    (write-line "")
    )
  )

( defun alive ( matirx x y )
     
 
 
)

( defun next-step ( matrix )
 (defparameter buffer (list 
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        ))
 (dotimes (y MAT-HEIGHT)
   (
    dotimes (x MAT-WIDTH) 
         (  
          if ( = 3 ( alive matrix x y ) )
            ( setf (aref buffer ( + (* y MAT-WIDTH) x) )  1)
            ( if (= 2 ( alive matrix x y ) ) then
              ( setf (aref buffer ( + (* y MAT-WIDTH) x) ) ( matat matrix x y ) )
            )
         )
    ) 
    (write-line "")
   )
 
 )

( defun matat (matrix x y)
 (nth (+ (* y MAT-WIDTH ) x) matrix )
 )
; ( write (matat matrix 2 1) )
( dismat matrix)
( next-step matrix )