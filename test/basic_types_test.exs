defmodule BasicTypesTest do

  use ExUnit.Case

  test "construct an atom" do
    x = :an_atom
    assert is_atom(x) == true
  end

  test "construct a tuple" do
    x = {1,2,3,:a, "abc", 'abc'}
    assert is_tuple(x) == true
  end

  test "disallow rebind a var" do
    assert_raise MatchError, "no match of right hand side value: 2", fn ->
      x = 1
      ^x = 2
    end
  end
end
