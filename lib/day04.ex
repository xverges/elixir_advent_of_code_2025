defmodule AdventOfCode.Day04 do
  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    matrix = parse_input(input)

    for {row, row_idx} <- Enum.with_index(matrix),
        {val, col_idx} <- Enum.with_index(row),
        val == 1 do
      get_weight_of_neighbors(matrix, row_idx, col_idx)
    end
    |> Enum.filter(&(&1 < 4))
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
    input
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  @spec parse_input(binary()) :: [[integer()]]
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.graphemes()
    |> Enum.map(fn char ->
      case char do
        "@" -> 1
        _ -> 0
      end
    end)
  end

  @neighbor_offsets [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]
  defp get_neighbors(matrix, row, col) do
    rows = length(matrix)
    cols = length(hd(matrix))

    for {drow, dcol} <- @neighbor_offsets,
        nrow = row + drow,
        ncol = col + dcol,
        nrow >= 0 and nrow < rows and ncol >= 0 and ncol < cols do
      {nrow, ncol, Enum.at(matrix, nrow) |> Enum.at(ncol)}
    end
  end

  defp get_weight_of_neighbors(matrix, row, col) do
    get_neighbors(matrix, row, col)
    |> Enum.map(fn {_, _, val} -> val end)
    |> Enum.sum()
  end
end
