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
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> get_joltage(line, 12) end)
    |> Enum.sum()
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  @spec get_joltage(binary()) :: non_neg_integer()
  def get_joltage(input, window_size \\ 2) do
    initial_joltage = List.duplicate(0, window_size)

    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(window_size, 1, :discard)
    |> Enum.reduce(initial_joltage, fn window, saved ->
      compare_joltage(window, saved)
    end)
    |> Enum.reduce(0, fn digit, acc -> 10 * acc + digit end)
  end

  defp compare_joltage([], _saved), do: []
  defp compare_joltage(_input, []), do: []

  defp compare_joltage(input = [input_element | input_rest], [saved_element | saved_rest]) do
    if input_element > saved_element do
      input
    else
      [saved_element | compare_joltage(input_rest, saved_rest)]
    end
  end
end
