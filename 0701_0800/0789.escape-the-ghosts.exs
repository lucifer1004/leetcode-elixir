defmodule Solution do
  @spec escape_ghosts(ghosts :: [[integer]], target :: [integer]) :: boolean
  def escape_ghosts(ghosts, target) do
    [x, y] = target
    gmin = ghosts |> Enum.map(fn [x1, y1] -> abs(x - x1) + abs(y - y1) end) |> Enum.min()
    abs(x) + abs(y) < gmin
  end
end
