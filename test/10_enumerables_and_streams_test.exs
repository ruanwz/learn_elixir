defmodule EnumerablesAndStreamsTest do
  use ExUnit.Case
  test "list and map are enumerable" do
    assert Enum.map([1,2,3], &(&1*2)) == [2,4,6]
    assert Enum.map(%{1=>2, 3=>4}, fn {k,v} -> k * v end) == [2, 12]
  end
end
