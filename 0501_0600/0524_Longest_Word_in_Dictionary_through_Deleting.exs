defmodule Solution do
  @spec find_longest_word(s :: String.t(), dictionary :: [String.t()]) :: String.t()
  def find_longest_word(s, dictionary) do
    dictionary
    |> Enum.reduce("", fn t, ans ->
      if(can_match(s |> String.graphemes(), t |> String.graphemes())) do
        la = ans |> String.length()
        lt = t |> String.length()
        if lt > la || (lt == la && t < ans), do: t, else: ans
      else
        ans
      end
    end)
  end

  @spec can_match(s :: [char], t :: [char]) :: bool
  defp can_match(s, t) do
    case {s, t} do
      {_, []} ->
        true

      {[], _} ->
        false

      {[hs | ts], [ht | tt]} ->
        if hs == ht, do: can_match(ts, tt), else: can_match(ts, t)
    end
  end
end
