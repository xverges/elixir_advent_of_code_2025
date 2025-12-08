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
      expected_top_down = [
        [0, 0, 1, 1, 0, 1, 1, 1, 1, 0],
        [1, 0, 1, 0, 1, 1, 1, 0, 1, 0]
      ]

      parsed = AdventOfCode.Day04.parse_input(@sample_input_part1)
      assert length(parsed) == 10
      assert length(hd(parsed)) == 10
      assert hd(parsed) == hd(expected_top_down)
      assert List.last(parsed) == List.last(expected_top_down)
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
    test "example input" do
      input = """
      # TODO: Add example input
      """

      # TODO: Add expected result
      expected = 0
      assert AdventOfCode.Day04.solve_part2(input) == expected
    end

    @tag :skip
    test "submitted solution works" do
      assert AdventOfCode.Day04.solve_part2_from_file("inputs/day04.txt") == 0
    end
  end
end
