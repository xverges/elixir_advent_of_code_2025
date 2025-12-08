defmodule Mix.Tasks.Aoc.New do
  @moduledoc """
  Creates scaffolding for a new Advent of Code day.

  ## Usage

      mix aoc.new [day]

  If no day is provided, it will create the next day based on existing files.

  ## Examples

      mix aoc.new
      mix aoc.new 3
  """

  use Mix.Task

  @shortdoc "Creates scaffolding for a new Advent of Code day"

  @impl Mix.Task
  def run(args) do
    day =
      case args do
        [day_str] -> String.to_integer(day_str)
        [] -> find_next_day()
      end

    day_padded = String.pad_leading(to_string(day), 2, "0")

    lib_file = "lib/day#{day_padded}.ex"
    test_file = "test/day#{day_padded}_test.exs"
    input_file = "inputs/day#{day_padded}.txt"

    if File.exists?(lib_file) or File.exists?(test_file) do
      Mix.shell().error("Day #{day_padded} already exists!")
      System.halt(1)
    end

    create_lib_file(lib_file, day_padded)
    create_test_file(test_file, day_padded)
    create_input_file(input_file)

    Mix.shell().info("Created scaffolding for Day #{day_padded}:")
    Mix.shell().info("  - #{lib_file}")
    Mix.shell().info("  - #{test_file}")
    Mix.shell().info("  - #{input_file}")
  end

  defp find_next_day do
    "lib"
    |> File.ls!()
    |> Enum.filter(&String.starts_with?(&1, "day"))
    |> Enum.map(fn "day" <> rest ->
      rest
      |> String.replace(".ex", "")
      |> String.to_integer()
    end)
    |> Enum.max(fn -> 0 end)
    |> Kernel.+(1)
  end

  defp create_lib_file(path, day_padded) do
    content = """
    defmodule AdventOfCode.Day#{day_padded} do
      @spec solve_part1(binary()) :: non_neg_integer()
      def solve_part1(input) do
        input
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
    end
    """

    File.write!(path, content)
  end

  defp create_test_file(path, day_padded) do
    content = """
    defmodule AdventOfCode.Day#{day_padded}Test do
      use ExUnit.Case

      describe "AdventOfCode.Day#{day_padded}.part1" do
        test "example input matches example output" do
          input = \"\"\"
          # TODO: Add example input
          \"\"\"

          expected = 0  # TODO: Add expected result
          assert AdventOfCode.Day#{day_padded}.solve_part1(input) == expected
        end

        @tag :skip
        test "submitted solution works" do
          assert AdventOfCode.Day#{day_padded}.solve_part1_from_file("inputs/day#{day_padded}.txt") == 0
        end
      end

      describe "AdventOfCode.Day#{day_padded}.part2" do
        @tag :skip
        test "example input matches example output" do
          input = \"\"\"
          # TODO: Add example input
          \"\"\"

          expected = 0  # TODO: Add expected result
          assert AdventOfCode.Day#{day_padded}.solve_part2(input) == expected
        end

        @tag :skip
        test "submitted solution works" do
          assert AdventOfCode.Day#{day_padded}.solve_part2_from_file("inputs/day#{day_padded}.txt") == 0
        end
      end
    end
    """

    File.write!(path, content)
  end

  defp create_input_file(path) do
    File.write!(path, "")
  end
end
