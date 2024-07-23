#  Any live cell with fewer than two live neighbours dies, as if by underpopulation.
#  Any live cell with two or three live neighbours lives on to the next generation.
#  Any live cell with more than three live neighbours dies, as if by overpopulation.
#  Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


declare -A matrix
declare -A buffer

size=15
FRAME_COUNT=0

alv="⬜"
ded="⬛"

generate(){
    for (( i = 0; i < $size ; i++ )); do
        for (( j = 0; j < $((size)) ; j++ )); do
            if [[ $((RANDOM%2)) -lt 0 ]]; then
                matrix[$i,$j]=$alv; 
            else
                matrix[$i,$j]=$ded; 
            fi
        done
    done

}


is_alive(){ 
    count=$3
    if [[ $((FRAME_COUNT%2)) -eq 0 ]]; then
        value=${matrix[$1,$2]}
    else
        value=${buffer[$1,$2]}
    fi
    # printf "%s" $value
    case $value in
        $alv ) return $((1+count)) ;;
    esac
    return $((count));
}

nextsetp(){
      for (( i = 0; i < $size ; i++ )); do
        for (( j = 0; j < $((size)) ; j++ )); do
            alive_count=0;

            for (( dx = -1; dx <= 1; dx++ )); do
                for (( dy = -1; dy <= 1; dy++ )); do
                    if [[ $dx -eq 0 && $dy -eq 0  ]]; then
                        continue
                    fi
                    x=$(( (j+size + dx )%size ))
                    y=$(( (i+size + dy )%size ))
                    is_alive $x $y $alive_count
                    alive_count=$?
                done
            done



            if [[ $((FRAME_COUNT%2)) -eq 0 ]]; then
                if [[ $alive_count -lt 2 || $alive_count -gt 3 ]]; then
                    buffer[$j,$i]=$ded
                elif [[ $alive_count -eq 3 ]]; then
                    buffer[$j,$i]=$alv
                else
                    buffer[$j,$i]=${matrix[$j,$i]}
                fi
            else
                if [[ $alive_count -lt 2 || $alive_count -gt 3 ]]; then
                    matrix[$j,$i]=$ded
                elif [[ $alive_count -eq 3 ]]; then
                    matrix[$j,$i]=$alv
                else
                    matrix[$j,$i]=${buffer[$j,$i]}
                fi
            fi
        done
    done
    FRAME_COUNT=$((FRAME_COUNT+1))
}



display(){
    printf "\x1b[1J\x1b[1;1H"
    for (( i = 0; i < $size ; i++ )); do
        printf "\t"
        for (( j = 0; j < $((size)) ; j++ )); do
            if [[ $((FRAME_COUNT%2)) -eq 0 ]]; then
               echo -n ${matrix[$i,$j]};
            else
               echo -n ${buffer[$i,$j]};
            fi
        done
        printf "\n"
    done
    sleep $(echo 1/$size | bc -l )

}
glider(){
    matrix[0,0]=$alv
    matrix[0,2]=$alv
    matrix[1,1]=$alv
    matrix[1,2]=$alv
    matrix[2,1]=$alv
}


box(){
    matrix[1,0]=$alv
    matrix[1,1]=$alv
    matrix[1,2]=$alv
    
    matrix[0,0]=$alv
    matrix[0,1]=$alv
    matrix[0,2]=$alv

    matrix[0,4]=$alv
    matrix[1,4]=$alv
    matrix[4,0]=$alv
    matrix[4,1]=$alv
    matrix[4,4]=$alv

    matrix[2,0]=$alv
    matrix[2,1]=$alv
    matrix[2,2]=$alv

}
generate
glider
# box
# while [[ $FRAME_COUNT -lt 7 ]]; do
while [[ 1 ]]; do
    display
    nextsetp
done
