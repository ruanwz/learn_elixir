defmodule EnumerablesAndStreamsTest do
  use ExUnit.Case
  test "list and map are enumerable" do
    assert Enum.map([1,2,3], &(&1*2)) == [2,4,6]
    assert Enum.map(%{1=>2, 3=>4}, fn {k,v} -> k * v end) == [2, 12]
  end

  test "Enum is eager" do
    odd? = &(rem(&1,2) != 0)
    assert Enum.filter(1..3, odd?) == [1,3]
  end

  test "pipeline operation" do
    odd? = &(rem(&1,2) != 0)
    result = 1..100_000 |> Enum.map(&(&1*3)) |> Enum.filter(odd?) |> Enum.sum
    assert result == 7500000000
  end

  test "Stream is lazy" do
    result = 1..100_000 |> Stream.map(&(&1*3))
    refute is_number(result)
    assert Enum.take(result,3) == [3,6,9]
  end

  test "Stream other api" do
    stream = Stream.cycle([1,2,3])
    assert Enum.take(stream, 10) == [1,2,3,1,2,3,1,2,3,1]

    stream = Stream.unfold("hello world", &String.next_codepoint/1)
    assert Enum.take(stream, 3) == ["h", "e", "l"]

    # Stream.resource/3
    stream = File.stream!("README.md")
    #Function<18.16982430/2 in Stream.resource/3>
    assert Enum.take(stream,3) == ["LearnElixir\n", "===========\n", "[![Build\n"] 
  end

    # The amount of functions and functionality in Enum and Stream modules can be daunting at first but you will get familiar with them case by case. In particular, focus on the Enum module first and only move to Stream for the particular scenarios where laziness is required to either deal with slow resources or large, possibly infinite, collections.

end
