defmodule Solution do
  @mod 1_000_000_007

  @spec fib(n :: integer) :: integer
  def fib(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> fib(0, 1, n - 1)
    end
  end

  @spec fib(prev :: integer, curr :: integer, rem :: integer) :: integer
  defp fib(prev, curr, rem) do
    if rem == 0, do: curr, else: fib(curr, mod(prev + curr, @mod), rem - 1)
  end
end
