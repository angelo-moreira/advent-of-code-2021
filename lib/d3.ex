defmodule D3 do
  @moduledoc false
  def part1(file) do
    gamma =
      file
      |> File.stream!(trim: true, line_or_bytes: :line)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.to_charlist/1)
      |> Stream.map(
        &Enum.with_index(&1, fn char, index ->
          {index, [char]}
        end)
      )
      |> Enum.take_every(1)
      |> List.flatten()
      |> Enum.reduce([], fn {index, char}, acc ->
        case Enum.at(acc, index) do
          nil -> List.insert_at(acc, index, [char])
          _list -> List.update_at(acc, index, &[char | &1])
        end
      end)
      |> Enum.map(&Enum.frequencies/1)

    gamma_rate =
      gamma
      |> Enum.map(&Enum.max_by(&1, fn {_, occ} -> occ end))
      |> binary_to_number

    epsilon_rate =
      gamma
      |> Enum.map(&Enum.min_by(&1, fn {_, occ} -> occ end))
      |> binary_to_number

    Tuple.product({gamma_rate, epsilon_rate})
  end

  defp binary_to_number(binary_with_count) do
    binary_with_count
    |> Enum.map(fn {binary, _} -> binary end)
    |> to_string()
    |> Integer.parse(2)
    |> elem(0)
  end
end
