defmodule RecursionTest do
  use ExUnit.Case

  test "loops through recursion" do
    defmodule Recursion do
      def output_multiple_times(msg, n) when n <=1 do
        msg
      end
      def output_multiple_times(msg,n) do
        msg <> output_multiple_times(msg, n-1)
      end
    end
    assert Recursion.output_multiple_times("a",2) == "aa"
  end

  test "reduce and map algorithms" do
    defmodule Math do
      def sum_list([head|tail], accumulator) do
        sum_list(tail, head + accumulator)
      end
    
      def sum_list([], accumulator) do
        accumulator
      end
    end
    assert Math.sum_list([1,2,3],0) == 6
    # erlang/elixir has tail call optimiztion

    assert Enum.reduce([1,2,3],0,fn(x,acc)->x+acc end) == 6
    assert Enum.map([1,2,3], fn(x)->2*x end) == [2,4,6]
    assert Enum.reduce([1,2,3],0,&+/2) == 6
    assert Enum.reduce([1,2,3],0,&(&1+&2)) == 6
    assert Enum.map([1,2,3], &(&1*2)) == [2,4,6]

  end
end
