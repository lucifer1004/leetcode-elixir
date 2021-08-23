defmodule Solution do
  @spec find_cheapest_price(
          n :: integer,
          flights :: [[integer]],
          src :: integer,
          dst :: integer,
          k :: integer
        ) :: integer
  def find_cheapest_price(n, flights, src, dst, k) do
    adj =
      flights
      |> Enum.reduce(%{}, fn [u, v, w], mp ->
        mp |> Map.update(u, [{v, w}], &[{v, w} | &1])
      end)

    mp =
      for(u <- 0..(n - 1), m <- 0..(k + 1), into: %{}, do: {{u, m}, 1_000_000_000})
      |> Map.put({src, 0}, 0)

    mp =
      0..k
      |> Enum.reduce(mp, fn m, mp ->
        0..(n - 1)
        |> Enum.reduce(mp, fn u, mp ->
          adj
          |> Map.get(u, [])
          |> Enum.reduce(mp, fn {v, w}, mp ->
            mp |> Map.update({v, m + 1}, 1_000_000_000, &min(&1, (mp |> Map.get({u, m})) + w))
          end)
        end)
      end)

    ans = 0..(k + 1) |> Enum.reduce(1_000_000_000, &min(mp |> Map.get({dst, &1}), &2))
    if ans == 1_000_000_000, do: -1, else: ans
  end
end
