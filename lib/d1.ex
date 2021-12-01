defmodule D1 do
  @moduledoc false
  def part1(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{increased_by: 0, current_depth: nil}, &calculate_depth(&2, &1))
    |> Map.get(:increased_by)
  end

  defp calculate_depth(%{current_depth: cur_depth} = acc, depth)
       when depth > cur_depth do
    acc
    |> Map.put(:current_depth, depth)
    |> Map.put(:increased_by, acc.increased_by + 1)
  end

  defp calculate_depth(acc, depth),
    do: Map.put(acc, :current_depth, depth)
end
