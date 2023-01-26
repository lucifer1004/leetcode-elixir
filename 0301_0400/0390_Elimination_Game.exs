defmodule Solution do
  @spec last_remaining(n :: integer) :: integer
  def last_remaining(n) do
    cond do
      n == 1 -> 1
      true -> 2 * (1 + div(n, 2) - last_remaining(div(n, 2)))
    end
  end
end
