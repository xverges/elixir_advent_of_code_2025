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

  @spec solve_part2(binary()) :: non_neg_integer()
  def solve_part2(input) do
    input
    |> parse_ranges()
    |> get_invalid_ids(:part2)
    |> Enum.sum()
  end

  @spec solve_part2_from_file(String.t()) :: non_neg_integer()
  def solve_part2_from_file(filename) do
    filename
    |> File.read!()
    |> solve_part2()
  end

  @spec parse_ranges(binary()) :: [{integer(), integer()}]
  def parse_ranges(input) do
    transform = fn txt_range ->
      [first, last] =
        txt_range
        |> String.split("-")
        |> Enum.map(&String.trim/1)

      {String.to_integer(first), String.to_integer(last)}
    end

    input
    |> String.split(",")
    |> Enum.map(transform)
  end

  @spec get_invalid_ids([{integer(), integer()}], atom()) :: [integer()]
  def get_invalid_ids(ranges, strategy \\ :part1) do
    Enum.flat_map(ranges, fn {first, last} -> get_invalid_ids_in_range(first, last, strategy) end)
  end

  @spec get_invalid_ids_in_range(integer(), integer(), atom()) :: [integer()]
  def get_invalid_ids_in_range(first, last, strategy \\ :part1) do
    invalid_ids =
      Stream.unfold(first, fn
        num when num <= last ->
          next = next_candidate(num, strategy)

          if num == next do
            {num, next + 1}
          else
            {nil, next}
          end

        _ ->
          nil
      end)
      |> Enum.reject(&(&1 == nil))

    Enum.to_list(invalid_ids)
  end

  defp num_of_digits(num) do
    num
    |> to_string()
    |> String.length()
  end

  defp next_candidate(num, strategy) do
    num_digits = num_of_digits(num)

    next_candidate_with_length(num, num_digits, strategy) ||
      next_candidate_with_length(num, num_digits + 1, strategy)
  end

  defp next_candidate_with_length(num, num_digits, :part1) do
    # Part1: only patterns repeated exactly 2 times (even digit counts)
    if rem(num_digits, 2) == 0 do
      pattern_length = div(num_digits, 2)
      find_candidate_for_pattern(num, pattern_length, 2)
    else
      nil
    end
  end

  defp next_candidate_with_length(num, num_digits, :part2) do
    # Size of the potentially repeated fragments
    pattern_lengths = get_divisors(num_digits) |> Enum.filter(&(div(num_digits, &1) >= 2))

    # For each fragment, find the smallest invalid ID >= num
    pattern_lengths
    |> Enum.map(fn pattern_length ->
      repetitions = div(num_digits, pattern_length)
      find_candidate_for_pattern(num, pattern_length, repetitions)
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.min(fn -> nil end)
  end

  defp find_candidate_for_pattern(num, pattern_length, reps) do
    # Find smallest number >= num that is `pattern` repeated `reps` times
    num_str = to_string(num)
    target_length = pattern_length * reps

    # If num has fewer digits than target, start with smallest pattern
    if String.length(num_str) < target_length do
      min_pattern = :math.pow(10, pattern_length - 1) |> trunc()
      String.duplicate(to_string(min_pattern), reps) |> String.to_integer()
    else
      # Extract pattern from num and potentially increment
      current_pattern_str = String.slice(num_str, 0, pattern_length)
      candidate = String.duplicate(current_pattern_str, reps) |> String.to_integer()
      current_pattern = String.to_integer(current_pattern_str)

      min_pattern = if candidate >= num, do: current_pattern, else: current_pattern + 1
      pattern = to_string(min_pattern)

      # Have we gone past 9...9?
      if String.length(pattern) != pattern_length do
        nil
      else
        String.duplicate(pattern, reps) |> String.to_integer()
      end
    end
  end

  defp get_divisors(n) do
    1..n
    |> Enum.filter(&(rem(n, &1) == 0))
  end
end
