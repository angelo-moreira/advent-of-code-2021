defmodule D1Test do
  @moduledoc false
  use ExUnit.Case
  import D1, only: [part1: 1, part2: 1]

  @tag :d1_p1
  test "should produce correct day1 part 1 correct output" do
    assert part1("#{__DIR__}/d1_input.txt") == 7
  end

  @tag :d1_p2
  test "should produce correct day1 part 2 correct output" do
    assert part2("#{__DIR__}/d1_input.txt") == 5
  end
end
