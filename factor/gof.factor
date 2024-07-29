USING:
    assocs
    io
    kernel
    lists lists.lazy
    locals
    math.statistics math.vectors
    random
    sequences
    sets ;
IN: life

: neighbours ( loc -- neighbours )
    { 1 0 -1 } dup cartesian-product concat [ { 0 0 } = not ] filter
    [ v+ ] with map ;

:: live? ( loc n cells -- ? )
    n 3 = n 2 = loc cells in? and or ;

:: life-step ( cells -- cells' )
    cells [ neighbours ] map concat histogram
    [ cells live? ] assoc-filter keys ;

: initial-cells ( n -- cells )
    [ 2 [ 8 iota random ] replicate ] replicate ;

:: cells>grid ( cells -- grid )
    8 iota dup cartesian-product [ [ cells in? ] map ] map ;

: display-grid ( grid -- )
    [ [ "*" "." ? ] map "" join print ] each flush ;

: run-life ( gens cell-count -- )
    initial-cells [ life-step ] lfrom-by ltake
    [ "---" print cells>grid display-grid ] leach ;

12 25 [ run-life ] ;