defmodule AdventOfCode.Day01 do

  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    origin = 50
    moves = input
            |> String.trim()
            |> String.split("\n")
            |> Enum.map(&parse_move/1)
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

  defp parse_move("L" <> num), do: -String.to_integer(num)
  defp parse_move("R" <> num), do: String.to_integer(num)

  defp apply_move(move, origin) do
    (origin + move)
    |> rem(100)
    |> then(&(100 + &1))  # Add 100 to deal with negative numbers
    |> rem(100)
  end

end
