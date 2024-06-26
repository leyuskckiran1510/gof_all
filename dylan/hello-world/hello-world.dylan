Module: hello-world

define function main
    (name :: <string>, arguments :: <vector>)
    let rows = 5;
    let cols = 5;
    let matrix = #[
                   0,1,0,0,0,
                   0,0,1,0,0,
                   1,1,1,0,0,
                   0,0,0,0,0,
                   0,0,0,0,0
                   ];

    let alive = 0;
    for ( m from 0 below 24)
            
            let output = make(type-for-copy(matrix), size: matrix.size);

            format-out("\n");
            for (y from 0 below rows)
                for(x from 0 below cols)
                    if (  matrix[ y * rows + x] == 1 )
                        format-out("⬜");
                    else
                        format-out("⬛");
                    end;
            end;
            format-out("\n");
            end;
            for (x from 0 below rows)
                for(y from 0 below cols)
                    alive := 0;

                    let newx = modulo(  x + cols - 1,cols );
                    let newy = modulo(  y + rows - 1,rows );
                    let index = newy * rows + newx; 

                    if (matrix[index] > 0)
                        alive := alive + 1;
                    end;

                    newx := modulo(  x + cols ,cols );
                    newy := modulo(  y + rows - 1,rows );
                    index := newy * rows + newx; 
                    if (matrix[index] == 1)
                        alive := alive + 1;
                    end;

                    newx := modulo(  x + cols + 1,cols );
                    newy := modulo(  y + rows - 1,rows );
                    index := newy * rows + newx; 

                    if (matrix[index] == 1)
                        alive := alive +   1;
                    end;

                    newx := modulo(  x + cols - 1,cols );
                    newy := modulo(  y + rows ,rows );
                    index := newy * rows + newx; 
                    if (matrix[index] == 1)
                        alive := alive + 1;
                    end;

                    newx := modulo(  x + cols - 1,cols );
                    newy := modulo(  y + rows + 1,rows );
                    index := newy * rows + newx; 
                    if (matrix[index] == 1)
                        alive := alive + 1;
                    end;

                    newx := modulo(  x + cols + 1,cols );
                    newy := modulo(  y + rows + 1,rows );
                    index := newy * rows + newx; 
                    if (matrix[index] == 1)
                        alive := alive + 1;
                    end;

                    newx := modulo(  x + cols ,    cols );
                    newy := modulo(  y + rows + 1,rows );
                    index := newy * rows + newx; 
                    if (matrix[index] == 1)
                        alive := alive + 1;
                    end;

                    newx := modulo(  x + cols + 1 ,cols );
                    newy := modulo(  y + rows ,    rows );
                    index := newy * rows + newx; 
                    if (matrix[index] == 1)
                        alive := alive + 1;
                    end;

                    select(alive)
                        3 => output[ y * rows + x] := 1;
                        2 => output[ y * rows + x] := matrix [ y * rows + x ];
                        otherwise => output[ y * rows + x] := 0;
                    end;


                end;
            end;
            matrix := output;


    end;
  exit-application(0);
end function;

main(application-name(), application-arguments());
