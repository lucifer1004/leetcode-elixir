defmodule Solution do
  @spec k_weakest_rows(mat :: [[integer]], k :: integer) :: [integer]
  def k_weakest_rows(mat, k) do
    mat
    |> Enum.map(&Enum.sum/1)
    |> Enum.with_index()
    |> Enum.sort()
    |> Enum.take(k)
    |> Enum.map(&elem(&1, 1))
  end
end
