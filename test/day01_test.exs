defmodule AdventOfCode.Day01Test do
  use ExUnit.Case
  describe "AdventOfCode.Day01.part1" do
    test "verify L50 R1 L1 steps twice in 0" do
        input = "L50\nR1\nL1"
        password = 2
        assert AdventOfCode.Day01.solve_part1(input) == password
    end
    test "verify R50 L1 R1 steps twice in 0" do
        input = "R50\nL1\nR1"
        password = 2
        assert AdventOfCode.Day01.solve_part1(input) == password
    end
    test "verify L250 L1 R1 steps twice in 0" do
        input = "L250\nL1\nR1"
        password = 2
        assert AdventOfCode.Day01.solve_part1(input) == password
    end
  end
end
