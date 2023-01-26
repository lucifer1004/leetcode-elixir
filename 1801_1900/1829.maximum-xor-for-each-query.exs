use Bitwise

defmodule Solution do
  @spec get_maximum_xor(nums :: [integer], maximum_bit :: integer) :: [integer]
  def get_maximum_xor(nums, maximum_bit) do
    nums
    |> Enum.reduce({0, []}, fn num, {xor, acc} ->
      xor = bxor(xor, num)
      {xor, [bxor(xor, (1 <<< maximum_bit) - 1) | acc]}
    end)
    |> elem(1)
  end
end
