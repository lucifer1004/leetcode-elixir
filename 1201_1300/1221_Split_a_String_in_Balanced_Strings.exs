defmodule Solution do
  @spec balanced_string_split(s :: String.t()) :: integer
  def balanced_string_split(s) do
    s
    |> String.graphemes()
    |> Enum.reduce({0, 0, 0}, fn ch, {l, r, ans} ->
      if ch == "L" do
        if l + 1 == r, do: {0, 0, ans + 1}, else: {l + 1, r, ans}
      else
        if r + 1 == l, do: {0, 0, ans + 1}, else: {l, r + 1, ans}
      end
    end)
    |> elem(2)
  end
end
