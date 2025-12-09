defmodule AdventOfCode.Day05 do
  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    {ranges, ingridients} = parse_input(input)
    consolidated_ranges = consolidate_ranges(ranges)
    sorted_ingridients = Enum.sort(ingridients)

    check_numbers_in_ranges(sorted_ingridients, consolidated_ranges, [])
    |> Enum.count()
  end

  @spec solve_part1_from_file(String.t()) :: non_neg_integer()
  def solve_part1_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part1()
  end

  @spec solve_part2(binary()) :: non_neg_integer()
  def solve_part2(input) do
    {ranges, _} = parse_input(input)
    consolidate_ranges(ranges)
    |> Enum.map(fn {first, last} -> last - first + 1 end)
    |> Enum.sum()
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  @spec parse_input(binary()) :: {any(), any()}
  def parse_input(input) do
    {range_lines, ingridient_lines} =
      input
      |> String.split("\n")
      |> Enum.split_while(fn line -> String.length(line) != 0 end)

    ranges =
      range_lines
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(fn line ->
        String.split(line, "-", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    ingridients =
      ingridient_lines
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.to_integer/1)

    {ranges, ingridients}
  end

  def consolidate_ranges(ranges) do
    ranges
    |> Enum.sort(fn {a, _}, {c, _} -> a <= c end)
    |> collapse_ranges([])
    |> Enum.reverse()
  end

  defp collapse_ranges([], acc), do: acc
  defp collapse_ranges([a], acc), do: [a | acc]

  defp collapse_ranges([first, second | rest], acc) do
    {open1, close1} = first
    {open2, close2} = second

    if close1 >= open2 - 1 do
      collapsed = {open1, max(close1, close2)}
      collapse_ranges([collapsed | rest], acc)
    else
      collapse_ranges([second | rest], [first | acc])
    end
  end

  defp check_numbers_in_ranges([], _ranges, acc), do: Enum.reverse(acc)
  defp check_numbers_in_ranges(_numbers, [], acc), do: Enum.reverse(acc)

  defp check_numbers_in_ranges([num | rest_numbers], [range | rest_ranges], acc) do
    {first, last} = range

    cond do
      num >= first && num <= last ->
        check_numbers_in_ranges(rest_numbers, [range | rest_ranges], [num | acc])

      num < first ->
        check_numbers_in_ranges(rest_numbers, [range | rest_ranges], acc)

      num > last ->
        check_numbers_in_ranges([num | rest_numbers], rest_ranges, acc)
    end
  end
end
