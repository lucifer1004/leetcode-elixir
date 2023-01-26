defmodule Solution do
  @inf 1_000_000_000

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
      0..k
      |> Enum.reduce(%{{src, 0} => 0}, fn m, mp ->
        0..(n - 1)
        |> Enum.reduce(mp, fn u, mp ->
          now = mp |> Map.get({u, m})

          if now == nil,
            do: mp,
            else:
              adj
              |> Map.get(u, [])
              |> Enum.reduce(mp, fn {v, w}, mp ->
                mp |> Map.update({v, m + 1}, now + w, &min(&1, now + w))
              end)
        end)
      end)

    ans = 0..(k + 1) |> Enum.reduce(@inf, &min(mp |> Map.get({dst, &1}, @inf), &2))

    if ans == @inf, do: -1, else: ans
  end
end
