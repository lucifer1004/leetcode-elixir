defmodule Solution do
  defp count(s) do
    s
    |> String.codepoints()
    |> Enum.reduce(%{}, fn c, acc ->
      Map.update(acc, c, 1, &(&1 + 1))
    end)
  end

  @spec rearrange_characters(s :: String.t(), target :: String.t()) :: integer
  def rearrange_characters(s, target) do
    sc = count(s)
    tc = count(target)

    Enum.map(tc, fn {k, v} ->
      div(Map.get(sc, k, 0), v)
    end)
    |> Enum.min()
  end
end
