defmodule Stack.Supervisor do
  use Supervisor

  alias Stack.Server

  def start_link(initial_arg) do
    Supervisor.start_link(__MODULE__, initial_arg, name: __MODULE__)
  end

  def init(_initial_arg) do
    children = [
      %{
        id: Stack1,
        start: {Server, :start_link, [:stack1, [1]]}
      },
      %{
        id: Stack2,
        start: {Server, :start_link, [:stack2, [12]]}
      },
      %{
        id: Stack3,
        start: {Server, :start_link, [:stack3, []]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
