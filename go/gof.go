package main

import (
    "fmt"
    "time"
)

const SIZE int = 15

func display(matrix [SIZE][SIZE]int) {
    i := 0
    fmt.Print("\x1b[2J\x1b[10;1H")
    for i < SIZE {
        j := 0
        for j < SIZE {
            if matrix[i][j] == 1 {
                fmt.Print("⬜")
            } else {
                fmt.Print("⬛")
            }
            j += 1
        }
        fmt.Print("\n")
        i += 1
    }
    return
}
func alive(matrix [SIZE][SIZE]int, x, y int) int {
    var dirs = [8][2]int{
        {1, 1},
        {1, -1},
        {1, 0},
        {-1, 1},
        {-1, -1},
        {-1, 0},
        {0, 1},
        {0, -1},
    }
    i := 0
    var alive_count int = 0
    for i < 8 {
        newx := (x + dirs[i][0] + SIZE) % SIZE
        newy := (y + dirs[i][1] + SIZE) % SIZE
        if matrix[newx][newy] == 1 {
            alive_count += 1
        }
        i += 1
    }
    return alive_count
}

func next_step(matrix [SIZE][SIZE]int) [SIZE][SIZE]int {
    var buffer [SIZE][SIZE]int
    i := 0
    alive_count := 0
    for i < SIZE {
        j := 0
        for j < SIZE {
            alive_count = alive(matrix, j, i)
            if alive_count == 3 {
                buffer[j][i] = 1
            } else if alive_count == 2 {
                buffer[j][i] = matrix[j][i]
            } else {
                buffer[j][i] = 0
            }
            j += 1
        }
        i += 1
    }
    return buffer
}

func main() {
    var matrix [SIZE][SIZE]int
    matrix = [SIZE][SIZE]int{
        {0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0},
        {0, 0, 0, 1, 0},
        {0, 1, 1, 1, 0},
        {0, 0, 0, 0, 0},
    }
    for i := 0; i < 100; i++ {
        display(matrix)
        matrix = next_step(matrix)
        time.Sleep(10 * time.Millisecond)
    }
}
