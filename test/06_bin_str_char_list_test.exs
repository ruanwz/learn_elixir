defmodule BinStrCharListTest do
  use ExUnit.Case

  test "String is binary" do
    assert is_binary "hello"
  end

  test "get code point value" do
    assert ?a == 97
  end

  test "check binary is string" do
    refute String.valid?(<<123,234>>)
    assert String.valid?(<<97,98>>)
  end

  test "binary operation" do
    <<1,2,x>> = <<1,2,3>>
    assert x == 3
    <<1,2,y::binary>> = <<1,2,3,4>>
    assert y == <<3,4>>
  end

  test "a char list contains the code points of the characters between single-quotes" do
    assert 'hełło' == [104, 101, 322, 322, 111]
    assert to_char_list('hełło') == [104, 101, 322, 322, 111]
    assert to_string(:hello) == "hello"
  end
end
