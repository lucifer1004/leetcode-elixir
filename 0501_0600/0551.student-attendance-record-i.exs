defmodule Solution do
  @spec check_record(s :: String.t()) :: boolean
  def check_record(s) do
    s |> String.graphemes() |> Enum.count(&(&1 == "A")) < 2 && !(s |> String.contains?("LLL"))
  end
end
