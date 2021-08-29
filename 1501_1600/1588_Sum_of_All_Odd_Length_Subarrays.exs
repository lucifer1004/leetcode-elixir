defmodule Solution do
  @spec sum_odd_length_subarrays(arr :: [integer]) :: integer
  def sum_odd_length_subarrays(arr) do
    n = length(arr)

    arr
    |> Enum.with_index()
    |> Enum.reduce(0, fn {x, i}, sum ->
      sum + x * (div(i + 2, 2) * div(n + 1 - i, 2) + div(i + 1, 2) * div(n - i, 2))
    end)
  end
end
