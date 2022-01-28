defmodule Stack.Server do
  use GenServer

  def push(server, val), do: GenServer.cast(server, {:push, val})
  def pop(server), do: GenServer.call(server, :pop)
  def stop(server), do: GenServer.cast(server, :stop)

  def start_link(name, initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: name)
  end

  @impl true
  def init(initial_state), do: {:ok, initial_state}

  @impl true
  def handle_cast({:push, val}, state) do
    {:noreply, [val | state]}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  @impl true
  def handle_call(:pop, _, []) do
    {:reply, [], []}
  end

  def handle_call(:pop, _, [hd | tl]) do
    {:reply, hd, tl}
  end
end
