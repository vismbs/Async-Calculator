defmodule AsyncCalc do
  def start do
    spawn(fn -> loop(0) end)
  end

  defp loop(current_state) do
    new_state =
      receive do
        {:view, caller} ->
          send(caller, {:response, current_state})
          current_state

        {:add, value} ->
          current_state + value

        {:sub, value} ->
          current_state - value

        {:div, value} ->
          current_state / value

        {:mul, value} ->
          current_state * value

        _ ->
          IO.puts("Invalid Operation")
          current_state
      end

    loop(new_state)
  end

  def view(caller, pid) do
    send(pid, {:view, caller})

    receive do
      {:response, value} ->
        value
    end
  end

  def add(value, pid), do: send(pid, {:add, value})
  def sub(value, pid), do: send(pid, {:sub, value})
  def div(value, pid), do: send(pid, {:div, value})
  def mul(value, pid), do: send(pid, {:mul, value})
end
