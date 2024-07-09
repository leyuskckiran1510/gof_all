let a : int  = 99;;
let matrix =[
    [0;0;0;0;0];
    [0;0;1;0;0];
    [0;0;0;1;0];
    [0;1;1;1;0];
    [0;0;0;0;0];
];;

let pcol n = 
    match  n with
    | 1 -> print_string "⬜"
    | _ -> print_string "⬛"
;;

let rec prow m =
    match m  with
    | [] ->  print_string "\n"
    | head :: tail ->
        pcol head ;prow(tail)
;;
let rec matprint m : int list list = 
    match m with
    | head :: tail -> prow(head); matprint(tail)
    | _ -> print_string "\n";[[]];
;;


let dirs = [
    [1;-1];
    [1;0];
    [1;1];
    [-1;-1];
    [-1;0];
    [-1;1];
    [0;1];
    [0;-1];
];;


let lookup (matrix :int list list) (dir:int list) (x:int ) (y :int) =
    List.nth (List.nth matrix ( ( (List.nth  dir 1 ) + y + (List.length matrix) ) mod List.length matrix))
             (( (List.nth dir 0) + x  + (List.length(List.nth matrix y) )) mod List.length(List.nth matrix y));;


let alive (x:int) (y:int ) (matrix:int list list) =
   List.length (List.filter ( fun dir -> 1 =  lookup matrix  dir x y ) dirs);;

let next_step (matrix:int list list) =
    (List.mapi (fun y _ -> 
            (List.mapi (fun x _  -> match (alive x y matrix ) with
                                    | 3 -> 1 
                                    | 2 -> ( List.nth (List.nth matrix y) x )
                                    | _ -> 0  
                        ) ( List.nth matrix 0 )
        )
        ) matrix);;

let rec delay n =
    match n with 
    | 0 -> 0
    | _ -> delay(n-1)

let rec looper mat = 
    (* delay 10000; *)
    (* print_string "\x1b[1J\x1b[10;1H"; *)
    matprint (next_step mat);
    looper ( next_step mat)
;;
looper matrix;;