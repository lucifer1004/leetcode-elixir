defmodule Solution do
  @spec get_maximum_generated(n :: integer) :: integer
  def get_maximum_generated(n) do
    mp =
      2..n
      |> Enum.reduce(%{0 => 0, 1 => 1}, fn x, mp ->
        if rem(x, 2) == 0,
          do: mp |> Map.put(x, mp |> Map.get(div(x, 2))),
          else: mp |> Map.put(x, (mp |> Map.get(div(x, 2))) + (mp |> Map.get(div(x, 2) + 1)))
      end)

    0..n |> Enum.reduce(0, &max(&2, mp |> Map.get(&1)))
  end
end
