defmodule Solution do
  @mod 1_000_000_007

  @spec check_record(n :: integer) :: integer
  def check_record(n) do
    check_record(n, [1, 0, 0, 0, 0, 0])
  end

  @spec check_record(
          n :: integer,
          dp :: [integer]
        ) :: integer
  defp check_record(n, dp) do
    if n == 0 do
      dp |> Enum.sum() |> rem(@mod)
    else
      [l0a0, l1a0, l2a0, l0a1, l1a1, l2a1] = dp

      check_record(n - 1, [
        rem(l0a0 + l1a0 + l2a0, @mod),
        l0a0,
        l1a0,
        rem(l0a0 + l1a0 + l2a0 + l0a1 + l1a1 + l2a1, @mod),
        l0a1,
        l1a1
      ])
    end
  end
end
