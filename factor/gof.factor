! Copyright (C) 2012 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: kernel sequences ;

IN: alive
: alive? ( x x x x -- x  ) + + + ;

IN: palindrome
: palindrome? ( string -- ? ) dup reverse = ;

2 2 3 1 alive?
! "racecar" palindrome?