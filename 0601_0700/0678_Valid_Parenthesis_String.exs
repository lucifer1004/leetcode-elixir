defmodule Solution do
  @spec check_valid_string(s :: String.t()) :: boolean
  def check_valid_string(s) do
    {lo, hi} =
      s
      |> String.graphemes()
      |> Enum.reduce({0, 0}, fn ch, {lo, hi} ->
        cond do
          hi < 0 ->
            {lo, hi}

          ch == "(" ->
            {lo + 1, hi + 1}

          ch == ")" ->
            {max(0, lo - 1), hi - 1}

          true ->
            {max(0, lo - 1), hi + 1}
        end
      end)

    lo <= 0 && hi >= 0
  end
end
