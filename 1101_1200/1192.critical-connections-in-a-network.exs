defmodule TarjanState do
  defstruct [:dfn, :low, :ans, :time]

  def new() do
    %TarjanState{dfn: %{}, low: %{}, ans: [], time: 0}
  end
end

defmodule Solution do
  defp tarjan(u, p, adj, state) do
    state = Map.update!(state, :time, &(&1 + 1))
    state = Map.update!(state, :dfn, &Map.put(&1, u, state.time))
    state = Map.update!(state, :low, &Map.put(&1, u, state.time))

    Map.get(adj, u, [])
    |> Enum.reject(fn v -> v == p end)
    |> Enum.reduce(state, fn v, state ->
      if Map.has_key?(state.dfn, v) do
        low_u = min(state.low[u], state.dfn[v])
        Map.update!(state, :low, &Map.put(&1, u, low_u))
      else
        state = tarjan(v, u, adj, state)
        low_u = min(state.low[u], state.low[v])
        state = Map.update!(state, :low, &Map.put(&1, u, low_u))

        if state.low[v] > state.dfn[u] do
          Map.update!(state, :ans, &[[u, v] | &1])
        else
          state
        end
      end
    end)
  end

  @spec critical_connections(n :: integer, connections :: [[integer]]) :: [[integer]]
  def critical_connections(n, connections) do
    adj =
      Enum.reduce(connections, Map.new(), fn [u, v], acc ->
        Map.update(acc, u, [v], &[v | &1]) |> Map.update(v, [u], &[u | &1])
      end)

    initial_state = TarjanState.new()
    tarjan(0, -1, adj, initial_state).ans
  end
end
