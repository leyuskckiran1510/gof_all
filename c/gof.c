
#if 0
gcc -o $0.out $0  -std=iso9899:1990 && $0.out $@
rm $0.out &>/dev/null
exit
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define ALIVE "⬜"
#define DEAD "⬛"

#define SIZE 5

int DIRECTIONS[8][2] = {
    {-1, 1}, {-1, 0}, {-1, -1},

    {1, -1}, {1, 0},  {1, 1},

    {0, 1},  {0, -1},
};

int isalive(int *grid, int rows, int x, int y, int dir_idx) {
  x = (x + rows + DIRECTIONS[dir_idx][0]) % rows;
  y = (y + rows + DIRECTIONS[dir_idx][1]) % rows;
  return grid[rows * y + x];
}

void display(int *grid, int rows, int cols) {
  int y, x;
  printf("\x1b[0J\x1b[2J\x1b[10;1H");
  for (y = 0; y < rows; ++y) {
    for (x = 0; x < cols; ++x) {
      printf("%s", grid[rows * y + x] ? ALIVE : DEAD);
    }
    printf("\n");
  }
}

void next_step(int *grid, int rows, int cols) {
  int *output = calloc(rows * cols, sizeof(int));
  int y, x, dir_idx, alive;
  for (y = 0; y < rows; ++y) {
    for (x = 0; x < cols; ++x) {
      alive = 0;
      for (dir_idx = 0; dir_idx < 8; ++dir_idx) {
        if (isalive(grid, rows, x, y, dir_idx)) {
          alive++;
        }
      }
      switch (alive) {
        case 2:
          output[rows * y + x] = grid[rows * y + x];
          break;
        case 3:
          output[rows * y + x] = 1;
          break;
        default:
          output[rows * y + x] = 0;
      }
    }
  }
  memcpy(grid, output, rows * cols * sizeof(int));
}

int main() {
  int i;
  int grid[SIZE][SIZE] = {
      {0, 1, 0, 0, 0}, {0, 0, 1, 0, 0}, {1, 1, 1, 0, 0},
      {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0},
  };
  for (i = 0; i <= 101; i++) {
    display((int *)&grid, SIZE, SIZE);
    next_step((int *)&grid, SIZE, SIZE);
    usleep(80000);
  }

  return 0;
}
