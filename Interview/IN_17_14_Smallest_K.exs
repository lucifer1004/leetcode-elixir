defmodule Solution do
  @spec smallest_k(arr :: [integer], k :: integer) :: [integer]
  def smallest_k(arr, k) do
    arr |> Enum.sort() |> Enum.take(k)
  end
end
