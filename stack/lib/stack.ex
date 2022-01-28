defmodule Stack do
  alias Stack.Server
  defdelegate push(server, val), to: Server
  defdelegate pop(server), to: Server
  defdelegate stop(server), to: Server
end
