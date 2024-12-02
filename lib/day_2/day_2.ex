defmodule Day2 do
  # # 6 reports (lines) with 5 levels per line
  # Input is a list of lists

  # Need to check that in each sublist, the levels are all increasing OR all decreasing
  # Then need to check that each pair of 2 values either increase or decrease
  # Maybe could do this by chunking 3 vals at a time into a stream, and just do a > b > c || a < b < c?

  defp get_reports do
    File.stream!("lib/day_2/day_2_input.txt")
    |> Stream.map(fn report ->
      report
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(fn level -> level |> String.to_integer() end)
    end)
  end

  def total(levels) do
    Enum.any?(0..(Enum.count(levels) - 1), fn index ->
      levels = List.delete_at(levels, index)

      sorted_levels = Enum.sort(levels)

      level_chunks = Enum.chunk_every(sorted_levels, 2, 1, :discard)

      are_increasing_or_decreasing_consistently? =
        (sorted_levels === levels || sorted_levels === Enum.reverse(levels)) &&
          sorted_levels |> Enum.uniq() |> Enum.count() === Enum.count(levels)

      all_diffs_valid? =
        Enum.all?(level_chunks, fn [a, b] ->
          diff = b - a
          diff >= 1 && diff <= 3
        end)

      all_diffs_valid? && are_increasing_or_decreasing_consistently?
    end)
  end

  def both_parts do
    get_reports()
    |> Enum.filter(&total/1)
    |> Enum.count()
  end
end
