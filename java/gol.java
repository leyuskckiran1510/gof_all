
import java.util.concurrent.TimeUnit;

class Gol {
  public static int alive(int[][] matrix, int x, int y) {
    int[][] dirs = {
        {1, 0},
        {1, 1},
        {1, -1},
        {-1, -1},
        {-1, 0},
        {-1, 1},
        {0, 1},
        {0, -1},
    };
    int rows = matrix.length;
    int cols = matrix[0].length;
    int count = 0;
    for (int[] dir : dirs) {
      int newx = (x + dir[0] + cols) % cols;
      int newy = (y + dir[1] + rows) % rows;
      if (matrix[newy][newx] == 1) {
        count++;
      }
    }
    return count;
  }

  public static void display(int[][] matirx) {
    System.out.print("\u001B[1J\u001B[10;10H\n");
    for (int[] row : matirx) {
      for (int col : row) {
        if (col == 1) {
          System.out.print("⬜");
        } else {
          System.out.print("⬛");
        }
      }
      System.out.println("");
    }
  }

  public static int[][] next_step(int[][] matrix) {
    int rows = matrix.length;
    int cols = matrix[0].length;
    int[][] buffer = new int[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        int alives = alive(matrix, j, i);
        if (alives == 3) {
          buffer[i][j] = 1;
        } else if (alives == 2) {
          buffer[i][j] = matrix[i][j];
        } else {
          buffer[i][j] = 0;
        }
      }
    }
    return buffer;
  }

  public static void main(String[] args) {
    int[][] matrix = {
        {0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0},
        {0, 0, 0, 1, 0},
        {0, 1, 1, 1, 0},
        {0, 0, 0, 0, 0},
    };

    for (int i = 0; i >-1; i++) {
      Gol.display(matrix);
      matrix = Gol.next_step(matrix);
      try {
        Thread.sleep(200);
      } catch (InterruptedException e) {
      }
    }
  }
}