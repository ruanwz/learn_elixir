defmodule ProcessesTest do
  use ExUnit.Case
  test "spawn" do
    pid = spawn fn -> 1+2 end

    assert is_pid(pid)
    assert Process.alive?(pid)
    :timer.sleep(100)
    refute Process.alive?(pid)

    current_pid = self()
    assert Process.alive?(current_pid)
  end

  test "send and receive" do
    send self(), {:hello, "world"}
    received = receive do
      {:hello, msg} -> msg
      {:wolrd, msg} -> "won't match"
    end

    assert received == "world"
  end

  test "receive with timeout" do
    received = receive do
      {:hello, msg} -> msg
    after
      100 -> "nothing after 0.1 sec"
    end
    assert received == "nothing after 0.1 sec"
  end

  test "send from different pid" do
    parent = self()
    child = spawn fn -> send(parent, {:hello, self()}) end
    received = receive do
      {:hello, msg} -> msg
    end
    assert received == child
  end

  test "in the shell, flush/0 flushes and prints all messages in the mailbox" do
    send self(), :hello
    # must be called in shell
    # flush()
  end

  test "links" do
    # this testcase pass because raise happen in spawned process but can see it in the shell

    parent = spawn fn ->
      spawn fn -> raise "oops" end
      receive do
        {:not_exist_msg, msg} -> msg
      end
    end
    
    :timer.sleep(100)
    assert Process.alive?(parent)

    # this raised error can be captured
    parent = spawn fn ->
      spawn_link fn -> raise "oops" end
      receive do
        {:not_exist_msg, msg} -> msg
      end
    end
    
    :timer.sleep(100)
    refute Process.alive?(parent)
  end

  test "Task.start/1 and Task.start_link/1 is better with error details" do
    parent = spawn fn ->
      {:ok, pid} = Task.start fn -> raise "oops" end
    end
  end
  
  defmodule KV do
    def start_link do
      Task.start_link fn -> loop(%{}) end
    end

    defp loop(map) do
      receive do
        {:get, key, caller} ->
          send caller, Map.get(map, key)
          loop(map)
        {:put, key, value}->
          loop(Map.put(map, key, value))
      end
    end
  end

  test "use process to maintain state" do

    {:ok, pid} = KV.start_link
    send pid, {:get, :hello, self()}
    value = receive do
      val -> val
    end
    assert value == nil

    send pid, {:put, :hello, "world"}
    #:timer.sleep(100)
    send pid, {:get, :hello, self()}

    value = receive do
      val -> val
    end
    assert value == "world"
  end

  test "register pid" do
    {:ok, pid} = KV.start_link
    Process.register(pid, :kv)

    send pid, {:put, :hello, "world"}
    send pid, {:get, :hello, self()}
    value = receive do
      val -> val
    end
    assert value == "world"
  end

  test "Agents are simple abstractions around state" do
    {:ok, pid} = Agent.start_link(fn -> %{} end)
    assert Agent.update(pid, fn map -> Map.put(map, :hello, "world") end) == :ok
    assert Agent.get(pid, fn map -> Map.get(map, :hello) end) == "world"
  end
end
