defmodule AdventOfCodeTemplate.CacheTest do
  use ExUnit.Case, async: true

  alias AdventOfCodeTemplate.Cache

  test "an empty cache does not have any keys" do
    {:ok, cache} = Cache.init()
    refute Cache.has_key?(cache, :anything)
  end

  test "a cache has values that you put into it" do
    {:ok, cache} = Cache.init()
    Cache.put(cache, :key0, :value0)
    Cache.put(cache, :key1, :value1)
    Cache.put(cache, :key2, :value2)
    assert Cache.has_key?(cache, :key0)
    assert Cache.get(cache, :key0) == :value0
    assert Cache.get(cache, :key1) == :value1
    assert Cache.get(cache, :key2) == :value2
  end
end
