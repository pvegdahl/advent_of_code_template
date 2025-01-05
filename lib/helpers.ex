defmodule AdventOfCode2024.Helpers do
  def file_to_lines!(filename) do
    File.stream!(filename, [:utf8])
    |> Enum.map(&String.trim/1)
  end

  def string_to_int_list(integers_string) do
    integers_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def reverse_map_of_lists(map_of_lists) do
    Map.to_list(map_of_lists)
    |> Enum.flat_map(fn {key, values} -> Enum.map(values, &{&1, key}) end)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Map.new()
  end

  def merge_maps_with_sum(maps) do
    Enum.reduce(maps, fn map1, map2 -> Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end) end)
  end
end
