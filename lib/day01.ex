defmodule AdventOfCode.Day01 do

  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    origin = 50
    moves = parse_moves(input)
    stops = Enum.scan(moves, origin, &apply_move/2)
    zeros = Enum.filter(stops, &(&1 == 0))
            |> length()
    zeros
  end

  @spec solve_part1_from_file(String.t()) :: non_neg_integer()
  def solve_part1_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part1()
  end

  @spec solve_part2(binary()) :: non_neg_integer()
  def solve_part2(input) do
    { origin, steps } = { 50, 0 }
    moves = parse_moves(input)
    stops = Enum.scan(moves, { origin, steps }, &track_move/2)
    zeros = stops
          |> Enum.map(fn {_, steps} -> steps end)
          |> Enum.sum()
    zeros
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  defp parse_moves(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_move/1)
  end

  defp parse_move("L" <> num), do: -String.to_integer(num)
  defp parse_move("R" <> num), do: String.to_integer(num)

  defp apply_move(move, origin) do
    (origin + move)
    |> rem(100)
    |> then(&(100 + &1))  # Add 100 to deal with negative numbers
    |> rem(100)
  end

  defp count_full_laps(move), do: move |> div(100) |> abs()
  defp count_partial_lap(0, 0), do: 0
  defp count_partial_lap(remainder, origin) when (remainder + origin) == 0, do: 1
  defp count_partial_lap(remainder, origin) when remainder < 0 and remainder + origin < 0, do: 1
  defp count_partial_lap(remainder, origin) when remainder > 0 and remainder + origin > 100, do: 1
  defp count_partial_lap(_remainder, _origin), do: 0

  defp track_move(move, { origin, _ }) do
    steps = count_full_laps(move) + count_partial_lap(rem(move, 100), origin)
    { apply_move(move, origin), steps }
  end


end
