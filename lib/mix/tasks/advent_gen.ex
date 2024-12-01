defmodule Mix.Tasks.Advent.Gen do
  @moduledoc "A custom mix task to generate code for a new day"
  use Mix.Task

  alias AdventOfCodeTemplate.TemplateGenerator

  @shortdoc "Generate a source and test file for a new day"
  def run(days) do
    Enum.each(days, &one_day/1)
  end

  defp one_day(day) do
    write_file!(TemplateGenerator.source_file_path(day), TemplateGenerator.source(day))
    write_file!(TemplateGenerator.test_file_path(day), TemplateGenerator.test(day))
  end

  defp write_file!(path, content) do
    IO.puts("Creating #{path}")
    File.write!(path, content)
  end
end
