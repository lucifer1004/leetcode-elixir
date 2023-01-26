defmodule Solution do
  defp is_subsequence_([], _) do
    true
  end

  defp is_subsequence_(_, []) do
    false
  end

  defp is_subsequence_([s | s_tail], [t | t_tail]) do
    if s == t do
      is_subsequence_(s_tail, t_tail)
    else
      is_subsequence_([s | s_tail], t_tail)
    end
  end

  @spec is_subsequence(s :: String.t(), t :: String.t()) :: boolean
  def is_subsequence(s, t) do
    is_subsequence_(s |> String.codepoints(), t |> String.codepoints())
  end
end
