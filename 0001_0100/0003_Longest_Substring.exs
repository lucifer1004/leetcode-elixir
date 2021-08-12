defmodule Solution do
  @spec length_of_longest_substring(s :: String.t()) :: integer
  def length_of_longest_substring(s) do
    chars = String.graphemes(s)
    two_pointers(chars, chars, 0, %MapSet{})
  end

  @spec two_pointers(l :: [String], r :: [String], ans :: integer, mp :: map()) :: integer
  defp two_pointers(l, r, ans, mp) do
    if r == [] do
      ans
    else
      if MapSet.member?(mp, List.first(r)) do
        two_pointers(l |> List.delete_at(0), r, ans, mp |> MapSet.delete(List.first(l)))
      else
        two_pointers(
          l,
          r |> List.delete_at(0),
          max(ans, MapSet.size(mp) + 1),
          mp |> MapSet.put(List.first(r))
        )
      end
    end
  end
end
