defmodule AliasRrequireImportTest do
  use ExUnit.Case
  test "alias examples" do
    defmodule Math do 
      alias Math.List, as: List
      # is the same as:
      # alias Math.List
      # it is lexically scoped, can also set inside specific functions
      def plus(a, b) do
        alias Math.List
        # ...
      end
    end
  end

  test "require examples" do
    # This line causes a CompileError if not require first
    # Integer.is_odd(3)

    require Integer
    assert Integer.is_odd(3)

    # In gereral a module does not need to be required before usage, 
    # except if we want to use the macros available in that module
  end

  test "import examples" do
    # use import whenever we want to easily access functions or macros from
    # other modules without using the fully-qualified name
    import List, only: [duplicate: 2]
    # can only import macros or functions
    import Integer, only: :macros
    import Integer, only: :functions
    assert duplicate(:ok, 3) == [:ok, :ok, :ok]

  end

  test "Aliases" do
    # Alias is a capitalized identifier which is converted to an atom
    # during compilation
    assert is_atom(String)
    assert to_string(String) == "Elixir.String"
    assert :"Elixir.String" == String

  end

  test "Nesting" do
  end
end


