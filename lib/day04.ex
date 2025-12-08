defmodule AdventOfCode.Day04 do
  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    matrix = parse_input(input)

    get_all_weights_of_neighbors(matrix, 4)
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
    matrix = parse_input(input)
    remove_rolls(matrix, 0, -1, 4)
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  @spec parse_input(binary()) :: map()
  def parse_input(input) do
    lines =
      input
      |> String.split("\n", trim: true)

    for {line, row_idx} <- Enum.with_index(lines),
        {val, col_idx} <- Enum.with_index(parse_line(line)),
        val == 1,
        into: %{},
        do: {{row_idx, col_idx}, val}
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
    for {drow, dcol} <- @neighbor_offsets,
        nrow = row + drow,
        ncol = col + dcol,
        Map.has_key?(matrix, {nrow, ncol}) do
      {{nrow, ncol}, Map.get(matrix, {nrow, ncol})}
    end
  end

  defp get_weight_of_neighbors(matrix, row, col) do
    get_neighbors(matrix, row, col)
    |> Enum.map(fn {_, val} -> val end)
    |> Enum.sum()
  end

  def get_all_weights_of_neighbors(matrix, threshold) do
    for(
      {{row, column}, _val} <- matrix,
      do: {{row, column}, get_weight_of_neighbors(matrix, row, column)}
    )
    |> Enum.filter(fn {_, val} -> val < threshold end)
  end

  defp remove_rolls(matrix, acc, last_removed, threshold) do
    if last_removed == 0 do
      acc
    else
      rolls_removed =
        matrix
        |> get_all_weights_of_neighbors(threshold)

      keys_to_drop = Enum.map(rolls_removed, fn {key, _weight} -> key end)
      updated_matrix = Map.drop(matrix, keys_to_drop)
      last_removed = length(rolls_removed)
      remove_rolls(updated_matrix, acc + last_removed, last_removed, threshold)
    end
  end
end
