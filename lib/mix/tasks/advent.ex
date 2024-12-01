defmodule Mix.Tasks.Advent do
  @moduledoc "A custom mix task to run code for a specific day (Totally unnecessary)"
  use Mix.Task

  @shortdoc "Run the AoC code for the given days"
  def run(days) do
    Enum.each(days, &run_and_print_day/1)
  end

  defp run_and_print_day(day) do
    AdventOfCodeTemplate.Cli.run_day(day)
    |> IO.puts()
  end
end
