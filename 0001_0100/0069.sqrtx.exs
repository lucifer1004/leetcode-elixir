defmodule Solution do
  @spec my_sqrt(x :: integer) :: integer
  def my_sqrt(x) do
    my_sqrt(x, 0, x)
  end

  @spec my_sqrt(x :: integer, lo :: integer, hi :: integer) :: integer
  defp my_sqrt(x, lo, hi) do
    if lo > hi do
      hi
    else
      mid = lo + div(hi - lo, 2)

      if mid * mid <= x,
        do: my_sqrt(x, mid + 1, hi),
        else: my_sqrt(x, lo, mid - 1)
    end
  end
end
