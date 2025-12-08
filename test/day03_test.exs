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
    test "example input results in example output" do
      input = """
      987654321111111
      811111111111119
      234234234234278
      818181911112111
      """

      expected = [987_654_321_111, 811_111_111_119, 434_234_234_278, 888_911_112_111]
      inputs = input |> String.split("\n", trim: true)

      Enum.zip(inputs, expected)
      |> Enum.each(fn {input, expected} ->
        assert AdventOfCode.Day03.get_joltage(input, 12) == expected
      end)

      assert AdventOfCode.Day03.solve_part2(input) == 3_121_910_778_619
    end

    test "submitted solution works" do
      assert AdventOfCode.Day03.solve_part2_from_file("inputs/day03.txt") == 168_798_209_663_590
    end
  end
end
