defmodule Solution do
  @spec maximum_importance(n :: integer, roads :: [[integer]]) :: integer
  def maximum_importance(n, roads) do
    initial = Map.new(0..(n - 1), fn x -> {x, 0} end)

    Enum.reduce(roads, initial, fn [from, to], acc ->
      tmp = Map.update(acc, from, 1, fn x -> x + 1 end)
      Map.update(tmp, to, 1, fn x -> x + 1 end)
    end)
    |> Map.values()
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> x * (i + 1) end)
    |> Enum.sum()
  end
end
