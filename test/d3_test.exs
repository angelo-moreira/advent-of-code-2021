defmodule D3Test do
  @moduledoc false
  use ExUnit.Case
  import D3, only: [part1: 1]

  @tag :d3_p1
  test "should produce correct day3 part 1 correct output" do
    assert part1("#{__DIR__}/d3_input.txt") == 198
  end

  @tag :d3_p2
  test "should produce correct day3 part 2 correct output" do
    assert part2("#{__DIR__}/d3_input.txt") == 230
  end
end
