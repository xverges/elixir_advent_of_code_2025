defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  describe "AdventOfCode.Day01.part1" do
    test "verify L50 R1 L1 stops twice in 0" do
      input = "L50\nR1\nL1"
      password = 2
      assert AdventOfCode.Day01.solve_part1(input) == password
    end

    test "verify R50 L1 R1 stops twice in 0" do
      input = "R50\nL1\nR1"
      password = 2
      assert AdventOfCode.Day01.solve_part1(input) == password
    end

    test "verify L250 L1 R1 stops twice in 0" do
      input = "L250\nL1\nR1"
      password = 2
      assert AdventOfCode.Day01.solve_part1(input) == password
    end
  end

  describe "AdventOfCode.Day01.part2" do
    test "verify L50 R1 L2 steps twice over 0" do
      input = "L50\nR1\nL2"
      password = 2
      assert AdventOfCode.Day01.solve_part2(input) == password
    end

    test "verify L250 L1 R1 steps four times in 0" do
      input = "L250\nL1\nR1"
      password = 4
      assert AdventOfCode.Day01.solve_part2(input) == password
    end

    test "verify L50 L100 steps two times in 0" do
      input = "L50\nL100"
      password = 2
      assert AdventOfCode.Day01.solve_part2(input) == password
    end

    test "verify provided example passes" do
      input = "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"
      password = 6
      assert AdventOfCode.Day01.solve_part2(input) == password
    end
  end
end
