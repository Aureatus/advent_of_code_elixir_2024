defmodule Day1 do
  @part_1_example_data [[3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3]]

  def get_input do
    data =
      File.read!(~c"lib/day_1/day_1_input.txt")
      |> String.split(~r"\n")
      |> Enum.map(&String.split(&1, ~r"\s", trim: true))

    list_1 = Enum.map(data, &Enum.at(&1, 0)) |> Enum.map(&String.to_integer/1)
    list_2 = Enum.map(data, &Enum.at(&1, 1)) |> Enum.map(&String.to_integer/1)

    [list_1, list_2]
  end

  def part_1() do
    data = get_input()
    # check list of locations most likely to be visited
    # locations listed by id.
    # Two lists, not in sync
    # (Example)
    # 3   4
    # 4   3
    # 2   5
    # 1   3
    # 3   9
    # 3   3

    #  Sort list, fold together, map over to get distance between the two numbers
    #  Then add all distances to find total distance.

    data
    |> Enum.map(fn id_list -> Enum.sort(id_list) end)
    |> Enum.zip()
    |> Enum.map(fn {id_1, id_2} -> max(id_1, id_2) - min(id_1, id_2) end)
    |> Enum.reduce(fn num, acc -> acc + num end)
  end

  def part_2 do
    # map through left list, do a filter of second list based on it to get count of occurences, then multiply number by it.
    # Add all nums in list to get total similarity score.

    data = get_input()

    list_1 = Enum.at(data, 0)
    list_2 = Enum.at(data, 1)

    list_1
    |> Enum.map(fn id -> Enum.count(list_2, &(&1 === id)) * id end)
    |> Enum.reduce(fn num, acc -> acc + num end)
  end
end
