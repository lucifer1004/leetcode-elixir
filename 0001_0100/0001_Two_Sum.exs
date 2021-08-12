defmodule Solution do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    List.foldl(nums |> Enum.with_index(), {%{}, []}, fn {num, i}, {mp, ans} ->
      if mp[target - num] == nil,
        do: {mp |> Map.put(num, i), ans},
        else: {mp, [mp[target - num], i]}
    end)
    |> elem(1)
  end
end
