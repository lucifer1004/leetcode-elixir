defmodule Solution do
  @inf 1_000_000_000_000

  @spec find_median_sorted_arrays(nums1 :: [integer], nums2 :: [integer]) :: float
  def find_median_sorted_arrays(nums1, nums2) do
    l1 = length(nums1)
    l2 = length(nums2)
    half = div(l1 + l2, 2)
    odd = rem(l1 + l2, 2) == 1

    if l1 >= l2 do
      {nums1_part1, nums1_part2} = nums1 |> Enum.split(half)
      median_search(nums1_part1, nums1_part2, [], nums2, odd)
    else
      {nums2_part1, nums2_part2} = nums2 |> Enum.split(half)
      median_search(nums2_part1, nums2_part2, [], nums1, odd)
    end
  end

  @spec median_search(
          n1p1 :: [integer],
          n1p2 :: [integer],
          n2p1 :: [integer],
          n2p2 :: [integer],
          odd :: boolean
        ) :: float
  defp median_search(n1p1, n1p2, n2p1, n2p2, odd) do
    pre1 = n1p1 |> List.last(-@inf)
    pre2 = n2p1 |> List.last(-@inf)
    nxt1 = n1p2 |> List.first(@inf)
    nxt2 = n2p2 |> List.first(@inf)

    if max(pre1, pre2) <= min(nxt1, nxt2) do
      if odd, do: min(nxt1, nxt2), else: (max(pre1, pre2) + min(nxt1, nxt2)) / 2
    else
      median_search(
        n1p1 |> Enum.drop(-1),
        Enum.take(n1p1, -1) ++ n1p2,
        n2p1 ++ Enum.take(n2p2, 1),
        n2p2 |> Enum.drop(1),
        odd
      )
    end
  end
end
