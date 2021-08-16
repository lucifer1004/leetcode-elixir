use Bitwise

defmodule Solution do
  @spec count_arrangement(n :: integer) :: integer
  def count_arrangement(n) do
    dp = %{0 => 1}

    Enum.reduce(0..((1 <<< n) - 1), dp, fn x, dp ->
      k = popcount(x) + 1
      now = dp |> Map.get(x, 0)

      Enum.reduce(0..(n - 1), dp, fn i, dp ->
        if (x &&& 1 <<< i) == 0 && (rem(i + 1, k) == 0 || rem(k, i + 1) == 0),
          do: dp |> Map.update(x ||| 1 <<< i, now, &(&1 + now)),
          else: dp
      end)
    end)
    |> Map.get((1 <<< n) - 1)
  end

  @spec popcount(x :: integer) :: integer
  defp popcount(x) do
    popcount(x, 0)
  end

  @spec popcount(x :: integer, ans :: integer) :: integer
  defp popcount(x, ans) do
    cond do
      x == 0 -> ans
      rem(x, 2) == 1 -> popcount(div(x, 2), ans + 1)
      true -> popcount(div(x, 2), ans)
    end
  end
end
