defmodule Solution do
  @spec reverse_str(s :: String.t(), k :: integer) :: String.t()
  def reverse_str(s, k) do
    reverse_arr(s |> String.graphemes(), k) |> Enum.join("")
  end

  @spec reverse_arr(arr :: arg, k :: integer) :: [arg] when arg: var
  defp reverse_arr(arr, k) do
    case arr do
      [] ->
        []

      arr ->
        (arr |> Enum.take(k) |> Enum.reverse()) ++
          (arr |> Enum.drop(k) |> Enum.take(k)) ++ reverse_arr(arr |> Enum.drop(k * 2), k)
    end
  end
end
