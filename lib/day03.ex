defmodule AdventOfCode.Day03 do
  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&get_joltage/1)
    |> Enum.sum()
  end

  @spec solve_part1_from_file(String.t()) :: non_neg_integer()
  def solve_part1_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part1()
  end

  @spec solve_part2(binary()) :: non_neg_integer()
  def solve_part2(input) do
    input
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  @spec get_joltage(binary()) :: non_neg_integer()
  def get_joltage(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce({0, 0}, fn [a, b], joltage ->
      {tens, units} = joltage
      cond do
        a > tens -> {a, b}
        b > units -> {tens, b}
        true -> {tens, units}
      end
    end)
    |> then(fn {tens, units} -> tens * 10 + units end)
  end
end
