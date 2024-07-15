#! /bin/env tclsh

proc dismat {mat} {
    # clear screen and move cursor to 1,1
    puts "\x1b\[1J\x1b\[1;1H "

    foreach row $mat {
        foreach col $row {
            if { $col < 1} {
                puts -nonewline "⬛"
            } else {
                puts -nonewline "⬜"
            }
        }
        puts ""
    }
}

proc at { arrayLike args } {
    foreach arg $args {
        set arrayLike [lindex $arrayLike $arg ]
    }
    return $arrayLike
}

proc alive {mat y x} {
    set dirs  {    
            { 1 -1 }
            { 1 0 }
            { 1 1 }
            { -1 -1 }
            { -1 0 }
            { -1 1 }
            { 0 -1 }
            { 0 1 }
     }
     set count 0 
     set rows [ llength $mat ]
     set cols [ llength [ at  $mat 0 ]  ]
     foreach dir $dirs {
         set dx [ at $dir 0]
         set dy [ at $dir 1]
         set newx [expr { ( $dx +  $x + $cols ) % $cols  } ]
         set newy [expr { ( $dy + $y  + $rows ) % $rows } ]
         set val [ at $mat $newy  $newx ]
         if { $val > 0} {
             incr count
         }
     }
     return $count
    
}


proc next_step {mat} {
    set rows [ llength $mat]
    set cols [ llength [ at $mat 0 ] ]
    set buff {}
    for {set i 0} {$i < $rows} {incr i} {
        set temp_buff {}
        for {set j 0} {$j < $cols} {incr j} {
            # i -> y
            # j -> x
            set count [ alive $mat $i $j ]
            if { $count == 3 } {
                lappend temp_buff  1
            } elseif { $count == 2} {
                lappend temp_buff  [ at $mat $i  $j ]
            } else {
                lappend temp_buff  0
            }
        }
        lappend buff $temp_buff
    }
    return $buff
    
}

proc gameLoop { initialMatrix } {
    set FPS 10
    set N 1000
    for {set i 0} {$i < $N } {incr i} {
        dismat $initialMatrix
        set initialMatrix [ next_step $initialMatrix ] 
        after [ expr { 1000 / $FPS } ]
    }
}


set matrix  { { { 0 } { 0 } { 0 } { 0 } { 0 } }
              { { 0 } { 0 } { 1 } { 0 } { 0 } }
              { { 0 } { 0 } { 0 } { 1 } { 0 } }
              { { 0 } { 1 } { 1 } { 1 } { 0 } }
              { { 0 } { 0 } { 0 } { 0 } { 0 } }
            }

gameLoop $matrix