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

  def parse_string_grid(lines, exclude \\ ["."]) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y_index} -> parse_one_grid_line(line, y_index, exclude) end)
    |> Enum.group_by(fn {char, _x, _y} -> char end, fn {_char, x, y} -> {x, y} end)
    |> Map.new(fn {key, value} -> {key, MapSet.new(value)} end)
  end

  defp parse_one_grid_line(line, y_index, exclude) do
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reject(fn {character, _x_index} -> character in exclude end)
    |> Enum.map(fn {character, x_index} -> {character, x_index, y_index} end)
  end

  def grid_dimensions(lines) do
    y = Enum.count(lines)
    x = lines |> List.first() |> String.length()
    {x, y}
  end

  def in_bounds?({x, y}, {x_dim, y_dim}), do: x >= 0 and x < x_dim and y >= 0 and y < y_dim

  def merge_maps_with_sum(maps) do
    Enum.reduce(maps, fn map1, map2 -> Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end) end)
  end

  def point_groupings(points) do
    point = Enum.at(points, 0)
    other_points = MapSet.delete(points, point)

    {points_in_group, remaining_points} = point_grouping(other_points, MapSet.new([point]), [point])

    if Enum.empty?(remaining_points) do
      [points_in_group]
    else
      [points_in_group | point_groupings(remaining_points)]
    end
  end

  defp point_grouping(remaining_points, points_in_group, [] = _candidate_points) do
    {points_in_group, remaining_points}
  end

  defp point_grouping(remaining_points, points_in_group, [head_candidate | tail_candidates] = _candidate_points) do
    neighbors =
      head_candidate
      |> candidate_neighbors()
      |> MapSet.intersection(remaining_points)

    new_remaining_points = MapSet.difference(remaining_points, neighbors)
    new_points_in_group = MapSet.union(points_in_group, neighbors)
    new_candidates = Enum.to_list(neighbors) ++ tail_candidates

    point_grouping(new_remaining_points, new_points_in_group, new_candidates)
  end

  def candidate_neighbors({x, y}) do
    MapSet.new([{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}])
  end
end
