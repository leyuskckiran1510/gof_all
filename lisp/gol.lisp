
(defconstant MAT-WIDTH 5
  "width of matrix")

(defconstant MAT-HEIGHT 5
  "width of matrix")

; define parameter or vairbale at global scope
(defparameter matrix (list 
                       0 0 0 0 0
                       0 0 1 0 0
                       0 0 0 1 0
                       0 1 1 1 0
                       0 0 0 0 0
                       )
)
(defparameter counta 0)
(defparameter newx 0)
(defparameter newy 0)



(defun dismat ( matrix )
  (dotimes (y MAT-HEIGHT)
    (
     dotimes (x MAT-WIDTH) 
     (
      if (= 1 (matat matrix y x))
      ( format t "⬜" )
      ( format t  "⬛" )
      )
     
     ) 
    (write-line "")
    )
  )




( defun matat (matrix y x)
 (nth (+ (* y MAT-WIDTH ) x) matrix )
)


(defun  check (matirx y x dy dx  )
    (setq newx ( mod ( + x dx MAT-WIDTH ) MAT-WIDTH ) )  
    (setq newy ( mod ( + y dy MAT-HEIGHT ) MAT-HEIGHT ) ) 
    ( if (= (matat  matrix newy newx ) 1) 
        (return-from check 1)
        (return-from check 0) 
    )
)

(defun do-nothing ()
; NOP to skip loops , to mimic continue
)
( defun alive ( matirx y x )
  (setf counta 0)
  (dotimes (dx 3)
   (dotimes (dy 3)
     ( if ( and ( = (- dx 1) 0 )  ( = (- dy 1) 0) ) 
         ; if part
         (do-nothing)
         ; else part
         ( setf  counta ( + ( check matrix y x ( - dy 1) (- dx 1) )  counta )  )
      )
    ) 
  )
  counta
)


(defparameter buffer (list 
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        ))
( defun next-step ( local_matrix )
 (setq buffer (list 
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 0 0
                        ))
 (dotimes (y MAT-HEIGHT)
   (dotimes (x MAT-WIDTH) 
         (  
          if ( = 3 ( alive local_matrix y x ) )
            (setf (nth ( + (* y MAT-WIDTH) x) buffer) 1)
            ; else part
            ( if (= 2 ( alive local_matrix y x ) )
              (setf (nth ( + (* y MAT-WIDTH) x) buffer) ( matat local_matrix y x) )
              (setf (nth ( + (* y MAT-WIDTH) x) buffer) 0 )
            )
         )
    ) 
   )
    buffer
 )

(dotimes (_ 2000000)
    (format t "~C[2J ~C[1;1H" #\Esc #\Esc)
    ( dismat matrix)
    (setf matrix ( next-step matrix ) )
    (sleep 0.1)
)