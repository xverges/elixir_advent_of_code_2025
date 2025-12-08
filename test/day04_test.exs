defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  @sample_input_part1 """
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  describe "AdventOfCode.Day04.part1" do
    test "we know how to parse the input" do
      known_keys = [
        {0, 2},
        {0, 3},
        {0, 5},
        {0, 6},
        {0, 7},
        {0, 8},
        {9, 0},
        {9, 2},
        {9, 4},
        {9, 5},
        {9, 6},
        {9, 8}
      ]

      knonw_missing_keys = [
        {0, 0},
        {0, 1},
        {0, 4},
        {0, 9},
        {9, 1},
        {9, 3},
        {9, 7},
        {9, 9}
      ]

      parsed = AdventOfCode.Day04.parse_input(@sample_input_part1)

      assert Enum.all?(
               for key <- known_keys do
                 Map.has_key?(parsed, key)
               end
             )

      assert Enum.all?(
               for key <- knonw_missing_keys do
                 not Map.has_key?(parsed, key)
               end
             )
    end

    test "example input matched example output" do
      expected = 13
      assert AdventOfCode.Day04.solve_part1(@sample_input_part1) == expected
    end

    test "submitted solution works" do
      assert AdventOfCode.Day04.solve_part1_from_file("inputs/day04.txt") == 1508
    end
  end

  describe "AdventOfCode.Day04.part2" do
    @tag :skip
    test "example input matched example output" do
      expected = 43
      assert AdventOfCode.Day04.solve_part2(@sample_input_part1) == expected
    end

    @tag :skip
    test "submitted solution works" do
      assert AdventOfCode.Day04.solve_part2_from_file("inputs/day04.txt") == 0
    end
  end
end
