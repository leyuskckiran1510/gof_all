with Ada.Text_IO;
with Ada.Real_Time;

-- Any live cell with fewer than two live neighbours dies, as if by underpopulation.
-- Any live cell with two or three live neighbours lives on to the next generation.
-- Any live cell with more than three live neighbours dies, as if by overpopulation.
-- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


procedure Gof is
    mat_size:Integer := 10;
    type Integer_Array is array(0 .. mat_size-1) of Integer;
    type Matrix is array(0 .. mat_size-1) of Integer_Array;


    function check(input:Matrix; x,y:Integer) return Integer  is
        ans:Integer:=0;
    begin -- check
         if input(y)(x) > 0 then
            ans := 1;
            -- Ada.Text_IO.Put("⬜");
        else 
            -- Ada.Text_IO.Put("⬛");
            null;
        end if;
        return ans;
    end check;

    function Alive(input : Matrix) return Matrix is
      output : Matrix := input;
      alive_count:Integer :=0;
      new_x:Integer;
      new_y:Integer;
      dx:Integer;
      dy:Integer;
      begin
          for y in input'Range loop
                for x in input(y)'Range loop
                    alive_count:=0;
                    for ldx in 0..2 loop
                        for ldy  in 0..2  loop

                            dx := ldx - 1;
                            dy := ldy - 1;
                            
                            if dx = 0 and dy = 0 then
                                -- random no op as ada doesnot has continue
                                dy := 0 ;
                            else
                                -- Ada.Text_IO.Put(dx'Image&","&dy'Image&" " );
                                new_x := (mat_size +x + dx ) mod mat_size ;
                                new_y := (mat_size +y + dy ) mod mat_size ;
                                alive_count := alive_count + check(input,new_x,new_y);
                            end if;
                        end loop;
                    end loop;

                    if alive_count < 2 or alive_count > 3 then
                        output(y)(x) := 0;
                    elsif alive_count = 3 then
                        output(y)(x) := 1;
                    elsif alive_count =2 then
                        output(y)(x) := input(y)(x);

                    end if;
                end loop;
                
          end loop;
          return output;
    end Alive;





    procedure Display(input:Matrix) is
    begin -- Display
        
        -- Move Cursor to kind of center of screen vertically
        Ada.Text_IO.Put_Line(ASCII.ESC & "[10;0H");
        for i in input'Range loop
                for j in input(i)'Range loop
                    if input(i)(j) > 0 then
                        Ada.Text_IO.Put("⬜");
                    else 
                        Ada.Text_IO.Put("⬛");
                    end if;
                end loop;
                 Ada.Text_IO.Put_Line("");
          end loop;
    end Display;



    input: Matrix := ((0,0,0,0,0,0,0,0,0,0),
                      (0,0,1,0,0,0,0,1,0,0),
                      (0,0,0,1,0,0,0,0,1,0),
                      (0,1,1,1,0,0,1,1,1,0),
                      (0,0,0,0,0,0,0,0,0,0),
                      (0,0,0,0,0,0,0,0,0,0),
                      (0,0,1,0,0,0,0,1,0,0),
                      (0,0,0,1,0,0,0,0,1,0),
                      (0,1,1,1,0,0,1,1,1,0),
                      (0,0,0,0,0,0,0,0,0,0)
                      ); 
    use Ada.Real_Time;

   Delay_Duration : constant Time_Span := Milliseconds(100); -- 1 second
begin

    for i in 1 ..10000 loop
       Display(input);
       delay until Clock + Delay_Duration;
       input := Alive(input);
    end loop;
end Gof;
