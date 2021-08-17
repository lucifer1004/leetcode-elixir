defmodule Solution do
  @spec longest_common_prefix(strs :: [String.t()]) :: String.t()
  def longest_common_prefix(strs) do
    longest_common_prefix(strs |> Enum.map(&String.graphemes(&1)), [])
  end

  @spec longest_common_prefix(strs :: [[String.t()]], ans :: [String.t()]) :: String.t()
  defp longest_common_prefix(strs, ans) do
    curr = strs |> List.first() |> List.first()

    if curr != nil && strs |> Enum.all?(&(List.first(&1) == curr)),
      do: longest_common_prefix(strs |> Enum.map(fn [head | tail] -> tail end), [curr | ans]),
      else: ans |> Enum.reverse() |> Enum.join("")
  end
end
