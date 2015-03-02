defmodule IOFileTest do
  use ExUnit.Case
  test "IO module" do
    IO.puts "hello world"
    # IO.gets "yes or no?"
  end

  test "IO module change default output" do
    IO.puts :stderr, "hello world"
  end

  test "File module open in binary mode by default, use IO.binwrite to write" do
    {:ok, file} = File.open "/tmp/learn_elixir.txt", [:write]
    IO.binwrite file, "世界world"
    File.close file
    assert File.read("/tmp/learn_elixir.txt") == {:ok, "世界world"}

    # can open in utf8
    {:ok, file} = File.open "/tmp/learn_elixir_utf8.txt", [:write, :utf8]

    # other File functions:
    # File.rm/1
    # File.mkdir/1
    # File.mkdir_p/1
    # File.cp_r/2
    # File.rm/2
  end

  test "bang method raise if error" do
    File.read "unknown"
    assert_raise File.Error, "could not read file unknown: no such file or directory", fn -> File.read! "unknown" end

    # Tips: Avoid this code
    # {:ok, body} = File.read(file)
    # Because the error message is about pattern doesn't match
  end


  test "Path module" do
    assert Path.join("foo", "/bar") == "foo/bar"

    assert Path.expand("~/test") == "/home/david/test"
  end

  test "process and group leaders" do
    # IO.write(pid, binary) send a message to the pid process with operation
    # pid = spawn fn ->
    #   receive do: (msg -> IO.inspect msg)
    # end
    # IO.write(pid, "hello")
    # {:io_request, #PID<0.41.0>, #PID<0.57.0>, {:put_chars, :unicode, "hello"}}

    # StringIO module
    {:ok, pid} = StringIO.open("hello")
    assert IO.read(pid, 2) == "he"

    # when write to :stdio, actually send msg to group leader, which writes to the standard-input file descriptor
    IO.puts :stdio, "hello"
    IO.puts Process.group_leader, "hello"
  end

  test "strings are bytes and char lists are lists with code points" do

  # if file is opened without encoding, file is expected to be in raw mode,
  # functions in IO module starting with bin* must be used
  # these functions expect an iodata(a list of integers representing bytes and binaries) as argument
  #
  # if file is opened with :utf8, 
  # remaining functions in IO module are used
  # these functions expects a char_data(a list of characters or strings)

  #mixed of lists, integers and binaries
  IO.puts ['hello', ?\s, "world"]
  
  end
end
