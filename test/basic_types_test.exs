defmodule BasicTypesTest do

  use ExUnit.Case
  #require Benchmark

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

  test "double quote and single quote are different" do
    assert "abc" != 'abc'
  end

  test "anonymouse function" do
    add = fn a, b -> a + b end

    assert is_function(add)
    assert is_function(add, 2)
    refute is_function(add, 1)
    assert add.(1,1) == 2
  end

  test "function closure" do
    x = 1
    z = (fn y->x+y end).(2)
    assert z == 3
  end

  test "var assigned inside function not affect outside var" do
    x = 1
    (fn -> x=2 end).()
    assert x == 1
  end

  test "list definition" do
    x = [1,2,true, :atom]
    assert is_list(x)
    assert length(x)==4
  end

  test "concatenate and subtracte list" do
    x = [1,2]
    y=[2,3]
    assert x ++ y == [1,2,2,3]
    assert x -- y == [1]


  end

  test "list head and tail" do
    z = [1,2,3]
    assert hd(z) == 1
    assert tl(z) == [2,3]
  end

  test "tuple" do
    t = {:a,1,true}
    assert is_tuple(t)
    assert tuple_size(t) == 3
    assert elem(t,2) == true
    assert put_elem(t,2,'a') == {:a,1,'a'}
  end

  test "empty tail" do
    # prepend element is fastest way to add element to a list
    assert [1|[2|[3|[]]]] == [1,2,3]
    
  end

  test "read file" do
    # byte_size/1
    # tuple_size/1
    # length/1
    # String.length/1
    {:ok, content} = File.read('README.md')
    assert String.length(content) > 0
    assert byte_size("abc") == 3
    assert byte_size("中文") == 6
    assert String.length("中文") == 2
  end

  test "operators" do
    assert "foo" <> "bar" == "foobar"
    assert 1 == 1.0
    refute 1 === 1.0
    # number < atom < reference < functions < port < pid < tuple < maps < list < bitstring
    assert 1 < :atom
  end


end
