defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  @sample_input_part1 """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  describe "AdventOfCode.Day05.part1" do
    test "we know how to parse the input" do
      ranges = [{3, 5}, {10, 14}, {16, 20}, {12, 18}]
      ingridients = [1, 5, 8, 11, 17, 32]

      {parsed_ranges, parsed_ingridients} = AdventOfCode.Day05.parse_input(@sample_input_part1)

      assert parsed_ranges == ranges
      assert parsed_ingridients == ingridients
    end

    test "we consolidate the ranges" do
      ranges = [{3, 5}, {10, 14}, {16, 20}, {12, 18}, {21, 22}]
      consolidated_ranges = AdventOfCode.Day05.consolidate_ranges(ranges)
      expected = [{3, 5}, {10, 22}]
      assert consolidated_ranges == expected
    end

    test "example input matches example output" do
      expected = 3
      assert AdventOfCode.Day05.solve_part1(@sample_input_part1) == expected
    end

    test "submitted solution works" do
      assert AdventOfCode.Day05.solve_part1_from_file("inputs/day05.txt") == 517
    end
  end

  describe "AdventOfCode.Day05.part2" do
    @tag :skip
    test "example input matches example output" do
      input = """
      # TODO: Add example input
      """

      # TODO: Add expected result
      expected = 0
      assert AdventOfCode.Day05.solve_part2(input) == expected
    end

    @tag :skip
    test "submitted solution works" do
      assert AdventOfCode.Day05.solve_part2_from_file("inputs/day05.txt") == 0
    end
  end
end
