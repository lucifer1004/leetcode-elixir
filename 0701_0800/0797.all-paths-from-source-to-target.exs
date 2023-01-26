defmodule Solution do
  @spec all_paths_source_target(graph :: [[integer]]) :: [[integer]]
  def all_paths_source_target(graph) do
    n = length(graph)

    adj =
      for {adj, u} <- Enum.with_index(graph),
          into: %{},
          do: {u, for(v <- adj, into: %MapSet{}, do: {v})}

    dfs(n - 1, adj, [0], [])
  end

  defp dfs(target, adj, path, ans) do
    [curr | _] = path

    if curr == target do
      [Enum.reverse(path) | ans]
    else
      adj
      |> Map.get(curr)
      |> Enum.reduce(ans, fn v, ans ->
        dfs(target, adj, [v | path], ans)
      end)
    end
  end
end
