! USING: kernel sequences ;
! IN: 


! : alive? ( matrix  x y -- x  ) 3 * + swap [ cdr ] times car ;

! { 10  20 30 40 50 60  } 1 2 alive? .

USING: kernel math ;
IN: list
: lnth ( n list -- x x )  car ;

2 { 10  20 30 40 50 60  } lnth .
: fizzify ( sbuf m n string -- )
    [ divisor? ] dip '[ _ append! ] when drop ;

: fizzbuzz* ( n -- )
    0 <sbuf> swap { 
        [ 3 "fizz" fizzify ]
        [ 5 "buzz" fizzify ]
        [ '[ _ >dec ] when-empty print ]
    } 2cleave ;

: fizzbuzz ( n -- )
    [1..b] [ fizzbuzz* ] each ;