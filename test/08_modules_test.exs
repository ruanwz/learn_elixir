defmodule ModulesTest do
  use ExUnit.Case

  test "use defmodule macro to define module" do
    defmodule Math do
      def sum(a,b) do
        a+b
      end
    end
    assert Math.sum(1,2) == 3
    # use command elixirc to compile module
  end

  test "defp to define private function" do
    defmodule Math do
      defp do_sum(a,b) do
        a+b
      end
    end
    assert_raise UndefinedFunctionError, fn ->
      Math.do_sum(1,2)
    end
  end

  test "define function with guards" do
    defmodule Math do
      def zero?(0) do
        true
      end
      def zero?(x) when is_number(x) do
        false
      end
    end
    assert Math.zero?(0) == true
    assert Math.zero?(1) == false
    assert_raise FunctionClauseError, fn ->
      Math.zero?([1,2,3])
    end
  end

  test "capture functions" do
    defmodule Math do
      def zero?(0) do
        true
      end
    end
    fun = &Math.zero?/1
    assert is_function(fun) == true
    assert(fun.(0)) == true
  end

  test "use capture syntex as a shortcut to create function" do
    fun = &(&1 + 1)
    assert fun.(1) == 2
    # fun is same as fn(list, tail)->List.flatten(list,tail)
    fun = &List.flatten(&1, &2)
    assert fun.([1,[1,3,4],3], [4,5]) == [1,1,3,4,3,4,5]
  end

  test "default arguments" do
    defmodule Concat do
      def join(a, b, sep \\ " ") do
        a <> sep <> b
      end
    end
    assert Concat.join("Hello", "World", "_") == "Hello_World"
  end

end
