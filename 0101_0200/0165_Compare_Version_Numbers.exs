defmodule Solution do
  @spec compare_version(version1 :: String.t(), version2 :: String.t()) :: integer
  def compare_version(version1, version2) do
    compare(
      version1 |> String.split(".") |> Enum.map(&String.to_integer/1),
      version2 |> String.split(".") |> Enum.map(&String.to_integer/1)
    )
  end

  @spec compare(version1 :: [integer], version2 :: [integer]) :: integer
  defp compare(version1, version2) do
    case {version1, version2} do
      {[], []} ->
        0

      {[], [0 | tail2]} ->
        compare([], tail2)

      {[0 | tail1], []} ->
        compare(tail1, [])

      {[], version2} ->
        -1

      {version1, []} ->
        1

      {[head1 | tail1], [head2 | tail2]} ->
        cond do
          head1 > head2 -> 1
          head1 < head2 -> -1
          true -> compare(tail1, tail2)
        end
    end
  end
end
