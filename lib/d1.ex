defmodule D1 do
  @moduledoc false
  def part1(file) do
    file
    |> conver_to_ints()
    |> Enum.reduce(%{increased_by: 0, current_depth: nil}, &calculate_depth(&2, &1))
    |> Map.get(:increased_by)
  end

  defp conver_to_ints(file) do
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
    |> conver_to_ints()
    |> calculate_sliding_window(%{increased_by: 0, window: {}})
  end

  defguard bigger_window(first, second, third, fourth)
           when second + third + fourth > first + second + third

  defp calculate_sliding_window([new_depth | tail], %{window: {first, second, third}} = acc)
       when bigger_window(first, second, third, new_depth) do
    calculate_sliding_window(tail, %{
      window: {second, third, new_depth},
      increased_by: Map.get(acc, :increased_by) + 1
    })
  end

  defp calculate_sliding_window([new_depth | tail], %{window: {_, second, third}} = acc) do
    calculate_sliding_window(
      tail,
      Map.put(acc, :window, {second, third, new_depth})
    )
  end

  # adding tuples to the window until we reach 3
  defp calculate_sliding_window([head | tail], acc) do
    new_window = Tuple.append(acc.window, head)
    acc = Map.put(acc, :window, new_window)

    calculate_sliding_window(tail, acc)
  end

  defp calculate_sliding_window(_, %{increased_by: x}), do: x
end
