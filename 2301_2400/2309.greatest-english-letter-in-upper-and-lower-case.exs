defmodule Solution do
  @spec greatest_letter(s :: String.t()) :: String.t()
  def greatest_letter(s) do
    s
    |> String.codepoints()
    |> Enum.reduce({%{}, %MapSet{}, ""}, fn c, {map, set, ans} ->
      if !MapSet.member?(set, c) do
        cup = String.upcase(c)
        map = Map.put(map, cup, Map.get(map, cup, 0) + 1)
        set = MapSet.put(set, c)
        ans = if Map.get(map, cup) == 2, do: max(cup, ans), else: ans
        {map, set, ans}
      else
        {map, set, ans}
      end
    end)
    |> elem(2)
  end
end
