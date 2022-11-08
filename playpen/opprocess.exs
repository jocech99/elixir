defmodule OpProc do
  defstruct proc_pid: nil

  def start() do
    self_pid = self()
    pid = spawn(fn -> op_helper_process(self_pid) end)
    %OpProc{
      proc_pid: pid
    }
  end

  def op_helper_process(sender) do
    receive do
      {:add, v1, v2} ->
        send(sender, {:ok, v1+v2})

      {:sub, v1, v2} ->
        send(sender, {:ok, v1-v2})

      {:mul, v1, v2} ->
        send(sender, {:ok, v1*v2})

      {:div, v1, v2} ->
        send(sender, {:ok, v1/v2})

      {:neg, v1} ->
        send(sender, {:ok, 0-v1})

      blah -> 
        IO.puts(blah)
        send(sender, {:error})
    end
  end

  def op(op_proc, {op, v1, v2}) do
    send(op_proc.proc_pid, {op, v1, v2})

    receive do
      {:ok, resp} -> resp
      {:error} -> 
        IO.puts("Error, invalid operation (#{op}, #{v1}, #{v2}")
        {:error}
    end
  end
end





