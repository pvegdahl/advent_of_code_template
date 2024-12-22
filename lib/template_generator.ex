defmodule AdventOfCodeTemplate.TemplateGenerator do
  def source(day) do
    """
    defmodule AdventOfCodeTemplate.Day#{day} do
      alias AdventOfCodeTemplate.Helpers

      def part_a(_lines) do
        -1
      end

      def part_b(_lines) do
        -1
      end

      def a() do
        Helpers.file_to_lines!("inputs/day#{day}.txt")
        |> part_a()
      end

      def b() do
        Helpers.file_to_lines!("inputs/day#{day}.txt")
        |> part_b()
      end
    end
    """
  end

  def test(day) do
    """
    defmodule AdventOfCodeTemplate.Day#{day}Test do
      use ExUnit.Case, async: true

      alias AdventOfCodeTemplate.Day#{day}

      @tag :skip
      test "Day#{day} part A example" do
        assert Day#{day}.part_a(example_input()) == 42
      end

      defp example_input() do
        \"""
        TODO
        \"""
        |> String.trim()
        |> String.split("\\n")
        |> Enum.map(&String.trim/1)
      end

      @tag :skip
      test "Day#{day} part B example" do
        assert Day#{day}.part_b(example_input()) == 42
      end
    end
    """
  end

  def source_file_path(day), do: "lib/day#{day}.ex"

  def test_file_path(day), do: "test/day#{day}_test.exs"
end
