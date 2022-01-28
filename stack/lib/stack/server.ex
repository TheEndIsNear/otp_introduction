defmodule Stack.Server do
  use GenServer

  def push(server, val), do: GenServer.cast(server, {:push, val})
  def pop(server), do: GenServer.call(server, :pop)
  def stop(server), do: GenServer.cast(server, :stop)

  def start_link(name, initial_state) do
    GenServer.start_link(__MODULE__, {name, initial_state}, name: name)
  end

  @impl true
  def init({name, _} = initial_state) do
    IO.puts("Starting #{name}")
    {:ok, initial_state}
  end

  @impl true
  def handle_cast({:push, val}, {name, stack}) do
    {:noreply, {name, [val | stack]}}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  @impl true
  def handle_call(:pop, _, {_, []}) do
    {:reply, [], []}
  end

  def handle_call(:pop, _, {name, [hd | tl]}) do
    {:reply, hd, {name, tl}}
  end

  @impl true
  def terminate(_reason, {name, _} = state) do
    IO.puts("Server #{name} stopping...")

    {:stop, state}
  end
end
