defmodule AdventOfCodeTemplate.Cache do
  def init do
    Agent.start(fn -> %{} end)
  end

  def has_key?(cache, key) do
    Agent.get(cache, &Map.has_key?(&1, key))
  end

  def put(cache, key, value) do
    Agent.update(cache, &Map.put(&1, key, value))
  end

  def get(cache, key) do
    Agent.get(cache, &Map.get(&1, key))
  end
end
