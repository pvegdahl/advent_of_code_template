defmodule AdventOfCodeTemplate.TemplateGenerator.Test do
  use ExUnit.Case, async: true

  alias AdventOfCodeTemplate.TemplateGenerator

  test "Generate a source template" do
    assert TemplateGenerator.source("42") == """
           defmodule AdventOfCodeTemplate.Day42 do
             alias AdventOfCodeTemplate.Helpers

             def part_a(_lines) do
               -1
             end

             def part_b(_lines) do
               -1
             end

             def a() do
               Helpers.file_to_lines!("inputs/day42.txt")
               |> part_a()
             end

             def b() do
               Helpers.file_to_lines!("inputs/day42.txt")
               |> part_b()
             end
           end
           """
  end

  test "Generate a test template" do
    assert TemplateGenerator.test("47") == """
           defmodule AdventOfCodeTemplate.Day47Test do
             use ExUnit.Case, async: true

             alias AdventOfCodeTemplate.Day47

             @tag :skip
             test "Day47 part A example" do
               assert Day47.part_a(example_input()) == 42
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
             test "Day47 part B example" do
               assert Day47.part_b(example_input()) == 42
             end
           end
           """
  end

  test "Create a filename for a source file" do
    assert TemplateGenerator.source_file_path("86") == "lib/day86.ex"
  end

  test "Create a filename for a test file" do
    assert TemplateGenerator.test_file_path("99") == "test/day99_test.exs"
  end
end
