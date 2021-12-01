defmodule D1 do
  @moduledoc false
  def part1(file) do
    file
    |> convert_to_ints()
    |> Enum.reduce(%{increased_by: 0, current_depth: nil}, &calculate_depth(&2, &1))
    |> Map.get(:increased_by)
  end

  defp convert_to_ints(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  defp calculate_depth(%{current_depth: cur_depth} = acc, depth)
       when depth > cur_depth do
    acc
    |> Map.put(:current_depth, depth)
    |> Map.put(:increased_by, acc.increased_by + 1)
  end

  defp calculate_depth(acc, depth),
    do: Map.put(acc, :current_depth, depth)

  def part2(file) do
    file
    |> convert_to_ints()
    |> calculate_sliding_window(0)
  end

  defp calculate_sliding_window([first, _, _, fourth | _] = depths, inc) do
    inc = if fourth > first, do: inc + 1, else: inc

    depths
    |> tl()
    |> calculate_sliding_window(inc)
  end

  defp calculate_sliding_window(_, inc), do: inc
end
