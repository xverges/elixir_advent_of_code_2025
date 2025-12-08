defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  describe "AdventOfCode.Day02.part1" do
    test "we get a list of range tuples from input" do
      input = "\n11-22, 95-115,998-1012   "
      expected = [{11, 22}, {95, 115}, {998, 1012}]
      assert AdventOfCode.Day02.parse_ranges(input) == expected
    end

    test "we get invalid ids from a range" do
      assert AdventOfCode.Day02.get_invalid_ids_in_range(11, 22) == [11, 22]
      assert AdventOfCode.Day02.get_invalid_ids_in_range(95, 115) == [99]
      assert AdventOfCode.Day02.get_invalid_ids_in_range(998, 1012) == [1010]
    end

    test "verify provided example works" do
      input =
        "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

      ranges = AdventOfCode.Day02.parse_ranges(input)
      expected = [11, 22, 99, 1010, 1_188_511_885, 222_222, 446_446, 38_593_859]
      assert AdventOfCode.Day02.get_invalid_ids(ranges) == expected
      assert AdventOfCode.Day02.solve_part1(input) == 1_227_775_554
    end

    test "submitted solution works" do
      assert AdventOfCode.Day02.solve_part1_from_file("inputs/day02.txt") == 38_310_256_125
    end
  end

  describe "AdventOfCode.Day02.part2" do
    test "we get invalid ids from a range" do
      assert AdventOfCode.Day02.get_invalid_ids_in_range(11, 22, :part2) == [11, 22]
      assert AdventOfCode.Day02.get_invalid_ids_in_range(95, 115, :part2) == [99, 111]
      assert AdventOfCode.Day02.get_invalid_ids_in_range(998, 1012, :part2) == [999, 1010]
      assert AdventOfCode.Day02.get_invalid_ids_in_range(222_220, 222_224, :part2) == [222_222]
      assert AdventOfCode.Day02.get_invalid_ids_in_range(565_653, 565_659, :part2) == [565_656]
    end

    test "verify provided example works" do
      input =
        "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

      ranges = AdventOfCode.Day02.parse_ranges(input)

      expected = [
        11,
        22,
        99,
        111,
        999,
        1010,
        1_188_511_885,
        222_222,
        446_446,
        38_593_859,
        565_656,
        824_824_824,
        2_121_212_121
      ]

      assert AdventOfCode.Day02.get_invalid_ids(ranges, :part2) == expected
      assert AdventOfCode.Day02.solve_part2(input) == 4_174_379_265
    end
  end

  test "submitted solution works" do
    assert AdventOfCode.Day02.solve_part2_from_file("inputs/day02.txt") == 58_961_152_806
  end
end
