defmodule Solution do
  @spec reverse_vowels(s :: String.t()) :: String.t()
  def reverse_vowels(s) do
    chars = s |> String.graphemes()
    vowels = get_vowels(chars)
    vowel_chars = vowels |> Enum.map(&(&1 |> elem(0))) |> Enum.reverse()
    pos = vowels |> Enum.map(&(&1 |> elem(1)))

    chars
    |> Enum.with_index()
    |> Enum.reduce({[], vowel_chars, pos}, fn {char, index}, {ans, vowel_chars, pos} ->
      if pos != [] && index == pos |> List.first(),
        do:
          {[vowel_chars |> List.first() | ans], vowel_chars |> List.delete_at(0),
           pos |> List.delete_at(0)},
        else: {[char | ans], vowel_chars, pos}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> Enum.join("")
  end

  @spec get_vowels(s :: [String.t()]) :: []
  defp get_vowels(s) do
    s |> Enum.with_index() |> Enum.filter(&vowel?(&1 |> elem(0)))
  end

  @spec vowel?(ch :: String.t()) :: boolean
  defp vowel?(ch) do
    "aeiouAEIOU" |> String.contains?(ch)
  end
end
