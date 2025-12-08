defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  describe "AdventOfCode.Day03.part1" do
    test "example input" do
      input = """
      # TODO: Add example input
      """

      expected = 0  # TODO: Add expected result
      assert AdventOfCode.Day03.solve_part1(input) == expected
    end

    @tag :skip
    test "submitted solution works" do
      assert AdventOfCode.Day03.solve_part1_from_file("inputs/day03.txt") == 0
    end
  end

  describe "AdventOfCode.Day03.part2" do
    @tag :skip
    test "example input" do
      input = """
      # TODO: Add example input
      """

      expected = 0  # TODO: Add expected result
      assert AdventOfCode.Day03.solve_part2(input) == expected
    end

    @tag :skip
    test "submitted solution works" do
      assert AdventOfCode.Day03.solve_part2_from_file("inputs/day03.txt") == 0
    end
  end
end
