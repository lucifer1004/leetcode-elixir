defmodule Solution do
  @spec running_sum(nums :: [integer]) :: [integer]
  def running_sum(nums) do
    nums
    |> Enum.reduce([0], fn num, acc -> [acc |> (List.first() + num) | acc] end)
    |> Enum.take(length(nums))
    |> Enum.reverse()
  end
end
