defmodule Solution do
  @spec unhappy_friends(n :: integer, preferences :: [[integer]], pairs :: [[integer]]) :: integer
  def unhappy_friends(n, preferences, pairs) do
    preference_map =
      List.foldl(preferences |> Enum.with_index(), %{}, fn {x, u}, acc ->
        Map.merge(acc, for({v, i} <- x |> Enum.with_index(), into: %{}, do: {{u, v}, n - i}))
      end)

    pairs_of_pairs =
      for(
        [x, y] <- pairs,
        [u, v] <- pairs,
        x != u && y != v,
        do: [{{x, y}, {u, v}}, {{x, y}, {v, u}}, {{y, x}, {u, v}}, {{y, x}, {v, u}}]
      )
      |> List.flatten()

    List.foldl(pairs_of_pairs, %MapSet{}, fn {{x, y}, {u, v}}, acc ->
      if Map.get(preference_map, {x, u}) > Map.get(preference_map, {x, y}) &&
           Map.get(preference_map, {u, x}) > Map.get(preference_map, {u, v}),
         do: MapSet.put(acc, x),
         else: acc
    end)
    |> MapSet.size()
  end
end
