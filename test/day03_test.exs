defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  describe "AdventOfCode.Day03.part1" do
    test "example input results in example output" do
      input = """
        987654321111111
        811111111111119
        234234234234278
        818181911112111
        """
      expected = [98, 89, 78, 92]
      inputs = input |> String.split("\n", trim: true)

      Enum.zip(inputs, expected)
      |> Enum.each(fn {input, expected} ->
        assert AdventOfCode.Day03.get_joltage(input) == expected
      end)
      assert AdventOfCode.Day03.solve_part1(input) == 357
    end

    test "submitted solution works" do
      assert AdventOfCode.Day03.solve_part1_from_file("inputs/day03.txt") == 17034
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
