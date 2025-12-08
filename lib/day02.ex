defmodule AdventOfCode.Day02 do

  @spec solve_part1(binary()) :: non_neg_integer()
  def solve_part1(input) do
    input
    |> parse_ranges()
    |> get_invalid_ids()
    |> Enum.sum()
  end

  @spec solve_part1_from_file(String.t()) :: non_neg_integer()
  def solve_part1_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part1()
  end

  @spec parse_ranges(binary()) :: [{integer(), integer()}]
  def parse_ranges(input) do
    transform = fn  txt_range ->
      [first, last] = txt_range
                      |> String.split("-")
                      |> Enum.map(&String.trim/1)
      {String.to_integer(first), String.to_integer(last)}
    end

    input
    |> String.split(",")
    |> Enum.map(transform)
  end

  @spec get_invalid_ids([{integer(), integer()}]) :: [integer()]
  def get_invalid_ids(ranges) do
    Enum.flat_map(ranges, fn {first, last} -> get_invalid_ids_in_range(first, last) end)
  end

  @spec get_invalid_ids_in_range(integer(), integer()) :: [integer()]
  def get_invalid_ids_in_range(first, last) do

    invalid_ids = Stream.unfold(first, fn
      num when num <= last ->
        next = next_candidate(num)
        if num == next do
          {num, next + 1}
        else
          {nil, next}
        end
      _ -> nil
    end)
    |> Enum.reject(&(&1 == nil))

    Enum.to_list(invalid_ids)
  end

  defp num_of_digits(num) do
    num
    |> to_string()
    |> String.length()
  end
  defp first_with_extra_digit(num) do
    d = num_of_digits(num)
    "1" <> String.duplicate("0", d) |> String.to_integer()
  end
  defp next_candidate(num) do
    lowest = if rem(num_of_digits(num), 2) == 0, do: num, else: first_with_extra_digit(num)
    num_digits = num_of_digits(lowest)
    candidate =
      lowest
      |> to_string()
      |> String.slice(0, div(num_digits, 2))
      |> String.duplicate(2)
      |> String.to_integer()

    if num > candidate do
      candidate
      |> to_string()
      |> String.slice(0, div(num_digits, 2))
      |> String.to_integer()
      |> then(&(&1 + 1))
      |> to_string()
      |> String.duplicate(2)
      |> String.to_integer()
    else
      candidate
    end
  end
end
