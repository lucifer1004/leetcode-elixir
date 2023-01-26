defmodule Solution do
  @spec count_points(points :: [[integer]], queries :: [[integer]]) :: [integer]
  def count_points(points, queries) do
    Enum.map(queries, fn [x, y, r] ->
      Enum.count(points, fn [x1, y1] ->
        (x1 - x) * (x1 - x) + (y1 - y) * (y1 - y) <= r * r
      end)
    end)
  end
end
