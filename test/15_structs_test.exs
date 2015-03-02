defmodule User do
  defstruct name: "John", age: 27
end

defmodule StructsTest do
  use ExUnit.Case
  # structs are extensions built on top of maps that provide
  # compile-time checks and default values
  test "define struct" do
    assert %User{} == %User{age: 27, name: "John"}
    assert %User{age: 33} == %User{age: 33, name: "John"}
  end

  test "test undefined field" do
    #compile error
    # assert_raise fn -> %User{oops: :field} end
  end

  test "access and update structs" do
    john = %User{}
    assert john.name == "John"
    # update syntax (|)
    meg = %{john | name: "Meg"}
    assert  meg == %User{age: 27, name: "Meg"}
  end

  test "structs are just bare maps" do
    john = %User{}
    assert is_map(john)
    assert john.__struct__ == User

    # none of protocols implemented for maps are available for structs

    assert_raise Protocol.UndefinedError, fn -> john[:name] end

    assert_raise Protocol.UndefinedError, fn -> 
      Enum.each john, fn({field, value})-> IO.puts(value) end 
    end

    # work with functions from Map module
    # Map.put
    # Map.merge
    # Map.keys
  end
end
