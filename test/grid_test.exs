defmodule AdventOfCode2024.GridTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Grid

  describe "parse_string_grid" do
    test "empty grid" do
      assert Grid.parse_string_grid(["...", "...", "..."]) == %{}
    end

    test "non-empty grid" do
      assert Grid.parse_string_grid(["a.b", ".a.", "bca"]) == %{
               "a" => MapSet.new([{0, 0}, {1, 1}, {2, 2}]),
               "b" => MapSet.new([{2, 0}, {0, 2}]),
               "c" => MapSet.new([{1, 2}])
             }
    end
  end

  describe "grid_dimensions" do
    test "square grid" do
      assert Grid.grid_dimensions(["a.b", ".a.", "bca"]) == {3, 3}
    end

    test "rectangle grid" do
      assert Grid.grid_dimensions(["a.", "..", "bc", ".."]) == {2, 4}
    end
  end

  describe "in_bounds?/2" do
    test "yes in bounds on the late edge" do
      assert Grid.in_bounds?({2, 3}, {3, 4})
    end

    test "yes in bounds on the early edge" do
      assert Grid.in_bounds?({0, 0}, {3, 4})
    end

    test "not in bounds negative x" do
      refute Grid.in_bounds?({-1, 1}, {3, 4})
    end

    test "not in bounds negative y" do
      refute Grid.in_bounds?({1, -1}, {3, 4})
    end

    test "not in bounds x just too large" do
      refute Grid.in_bounds?({3, 2}, {3, 4})
    end

    test "not in bounds y just too large" do
      refute Grid.in_bounds?({2, 4}, {3, 4})
    end
  end

  describe "point_groupings" do
    test "Simple, easy case" do
      assert Grid.point_groupings(MapSet.new([{1, 1}, {1, 2}])) == [MapSet.new([{1, 1}, {1, 2}])]
    end

    test "Three groups. Diagonals not in the same group" do
      assert Grid.point_groupings(MapSet.new([{1, 1}, {2, 1}, {4, 4}, {5, 4}, {6, 3}])) |> Enum.sort() ==
               [MapSet.new([{1, 1}, {2, 1}]), MapSet.new([{4, 4}, {5, 4}]), MapSet.new([{6, 3}])] |> Enum.sort()
    end
  end
end
