defmodule D2Test do
  @moduledoc false
  use ExUnit.Case
  import D2, only: [part1: 1, part2: 1]

  @tag :d2_p1
  test "should produce correct day2 part 1 correct output" do
    assert part1("#{__DIR__}/d2_input.txt") == 150
  end

  @tag :d2_p2
  test "should produce correct day1 part 2 correct output" do
    assert part2("#{__DIR__}/d2_input.txt") == 900
  end
end
