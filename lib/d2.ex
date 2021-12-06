defmodule D2 do
  @moduledoc false
  def part1(file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&turn_to_tuple/1)
    |> Enum.reduce({0, 0}, fn tuple, acc ->
      calculate_position(tuple, acc)
    end)
    |> Tuple.product()
  end

  defp turn_to_tuple(<<"forward ", n::binary>>),
    do: {:forward, String.to_integer(n)}

  defp turn_to_tuple(<<"down ", n::binary>>),
    do: {:down, String.to_integer(n)}

  defp turn_to_tuple(<<"up ", n::binary>>),
    do: {:up, String.to_integer(n)}

  defp calculate_position({:forward, value}, {x, y}), do: {x + value, y}
  defp calculate_position({:down, value}, {x, y}), do: {x, y + value}
  defp calculate_position({:up, value}, {x, y}), do: {x, y - value}

  def part2(file) do
    %{depth: d, horizontal: h} =
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&turn_to_tuple/1)
      |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, fn tuple, acc ->
        calculate_position_with_aim(tuple, acc)
      end)

    d * h
  end

  defp calculate_position_with_aim({:forward, value}, %{horizontal: h, depth: d, aim: a} = acc) do
    acc
    |> Map.put(:horizontal, h + value)
    |> Map.put(:depth, d + a * value)
  end

  defp calculate_position_with_aim({:down, value}, %{aim: a} = acc) do
    Map.put(acc, :aim, a + value)
  end

  defp calculate_position_with_aim({:up, value}, %{aim: a} = acc) do
    Map.put(acc, :aim, a - value)
  end
end
