defmodule Solution do
  @spec k_weakest_rows(mat :: [[integer]], k :: integer) :: [integer]
  def k_weakest_rows(mat, k) do
    mat
    |> Enum.map(fn x -> x |> Enum.sum() end)
    |> Enum.with_index()
    |> Enum.sort()
    |> Enum.take(k)
    |> Enum.map(fn x -> x |> elem(1) end)
  end
end
