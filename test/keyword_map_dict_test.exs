defmodule KeywordMapDictTest do
  use ExUnit.Case

  test "keyword is list of 2 item tuples, where first item is atom" do
    list = [{:a, 1}, {:b, 2}]
    assert  list == ([a: 1, b: 2])
    assert list[:a] == 1
  end

  test "keyword characteristics" do
    # keys must be atoms
    # keys are ordered by developer
    # keys can be given more than once

    assert [a: 1, a: 2, b: 3][:a] == 1
  end

  test "when keyword list is the last argument, square brackets are optional" do
    assert (if false, do: :this, else: :that) == (if(false,[do: :this, else: :that]))
  end

  test "map are for key value, allow any value to be a key, keys are no ordered" do
    map = %{:a => 1, 2 => :b}
    assert map[:a] == 1
    assert map[:c] == nil

    # the last one win
    map = %{a: 1, a: 2}
    assert map[:a] == 2
  end

  test "map api and syntax" do
    map = %{:a => 1, 2 => :b}
    assert map.a == map[:a]
    assert (Map.get map, :a) == 1
    assert Map.to_list(map) == [{2, :b}, {:a, 1}]
    assert_raise KeyError, "key :c not found in: %{2 => :b, :a => 1}", fn -> 
      map.c 
    end

    assert %{map |:a => 2} == %{:a =>2, 2 => :b}
  end

  test "dict" do
    # dict is like an interface. both keyword lists and maps are called dictionaries

    keyword = []
    map = %{}
    assert Dict.put(keyword, :a, 1) == [a: 1]
    assert Dict.put(map, :a, 1) == %{a: 1}
  end
end
