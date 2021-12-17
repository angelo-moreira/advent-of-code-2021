defmodule D3 do
  @moduledoc false
  def part1(file) do
    gamma =
      file
      |> split_into_rows()
      |> Enum.map(
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

  def split_into_rows(file) do
    file
    |> File.stream!(trim: true, line_or_bytes: :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_charlist/1)
    |> Enum.take_every(1)
  end

  defp binary_to_number(binary_with_count) do
    binary_with_count
    |> Enum.map(fn {binary, _} -> binary end)
    |> to_string()
    |> Integer.parse(2)
    |> elem(0)
  end

  def part2(file) do
    rows = split_into_rows(file)

    oxygen =
      rows
      |> oxygen_generator_rating(0)
      |> to_string()
      |> Integer.parse(2)
      |> elem(0)

    co2 =
      rows
      |> co2_scrubber_rating(0)
      |> to_string()
      |> Integer.parse(2)
      |> elem(0)

    Tuple.product({oxygen, co2})
  end

  def oxygen_generator_rating([first_list | _] = list_of_chars, index)
      when length(first_list) > index do
    frequencies =
      list_of_chars
      |> Enum.map(&Enum.at(&1, index))
      |> Enum.frequencies()

    {most_frequent_char, _occurences} =
      Enum.max_by(frequencies, fn {char, occ} ->
        occ * 100 + char
      end)

    list_of_chars
    |> Enum.filter(fn list_of_chars ->
      Enum.at(list_of_chars, index) == most_frequent_char
    end)
    |> oxygen_generator_rating(index + 1)
  end

  def oxygen_generator_rating([rating | _], _index), do: rating

  def co2_scrubber_rating([first_list | _] = list_of_chars, index)
      when length(first_list) > index do
    frequencies =
      list_of_chars
      |> Enum.map(&Enum.at(&1, index))
      |> Enum.frequencies()

    {less_frequent_char, _occurences} =
      Enum.min_by(frequencies, fn {_char, occ} ->
        occ
      end)

    list_of_chars
    |> Enum.filter(fn list_of_chars ->
      Enum.at(list_of_chars, index) == less_frequent_char
    end)
    |> co2_scrubber_rating(index + 1)
  end

  def co2_scrubber_rating([rating | _], _index), do: rating
end
