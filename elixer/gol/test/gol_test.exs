defmodule GolTest do
  use ExUnit.Case
  doctest Gol

  test "greets the world" do
    assert Gol.hello() == :world
  end
end
