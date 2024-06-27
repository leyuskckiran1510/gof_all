import Kernel, only: rem

defmodule Gol do
  @moduledoc """
  Documentation for `Gol`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Gol.hello()
      :world

  """

  def display(matrix) do
    for row <- matrix do
      for value <- row do
        if value == 1 do
          IO.write("\x1b[42m \x1b[0m")
        else
          IO.write("\x1b[45m \x1b[0m")
        end
      end

      IO.puts("")
    end
  end

  def next_step(matrix) do
    dirs = [
      [-1, -1],
      [-1, 1],
      [-1, 0],
      [1, -1],
      [1, 1],
      [1, 0],
      [0, -1],
      [0, 1]
    ]

    new_matrix = []


    for {row, y} <- Enum.with_index(matrix) do
      for {og_value, x} <- Enum.with_index(row) do
        alive = 0
        temp_row = []

    IO.puts(matrix |> Enum.at(1) |> Enum.at(2))
        for dir <- dirs do
          size = length(row)
          value = matrix |> Enum.at(rem(y +  ( dir |> Enum.at(0) ),size)) |> Enum.at(Integer.mod(x + (dir |> Enum.at(1))),size)

          alive = if value == 1, do: alive + 1, else: alive
          cond do
            alive == 3 ->
              temp_row = List.insert_at(temp_row,x,1)

            alive == 2 ->
              new_matrix[y] ++ [og_value]
            true ->
              new_matrix[y] ++ [0]
              IO.write("")
          end
        end
      end
    end

    matrix
  end

  def hello do
    matrix = [
      [0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 1, 1, 0, 0],
      [0, 0, 1, 1, 0],
      [0, 0, 0, 0, 0]
    ]

    matrix = next_step(matrix)
    display(matrix)
    :world
  end
end

Gol.hello()
