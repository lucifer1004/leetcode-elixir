defmodule Solution do
  @spec find_the_winner(n :: integer, k :: integer) :: integer
  def find_the_winner(n, k) do
    1 + (2..n |> Enum.reduce(0, &((&2 + k) |> rem(&1))))
  end
end
