defmodule AdventOfCodeTemplate.Cli do
  @module_prefix "Elixir.AdventOfCodeTemplate.Day"

  def run_day(day_number) do
    get_day_module(day_number)
    |> run_all_functions()
  end

  defp get_day_module(day_number) do
    (@module_prefix <> day_number)
    |> String.to_existing_atom()
  end

  defp run_all_functions(day_module) do
    [:a, :b]
    |> Enum.map(&run_function(day_module, &1))
    |> Enum.join("\n")
  end

  defp run_function(day_module, function_atom) do
    function_output = Function.capture(day_module, function_atom, 0).()
    day_name = get_day_name_from_module(day_module)

    "___#{day_name}-#{Atom.to_string(function_atom)}___\n#{function_output}\n"
  end

  defp get_day_name_from_module(day_module) do
    day_module
    |> Atom.to_string()
    |> String.replace_prefix(@module_prefix, "Day")
  end
end
