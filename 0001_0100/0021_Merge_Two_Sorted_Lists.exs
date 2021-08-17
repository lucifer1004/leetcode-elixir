# Definition for singly-linked list.
#
# defmodule ListNode do
#   @type t :: %__MODULE__{
#           val: integer,
#           next: ListNode.t() | nil
#         }
#   defstruct val: 0, next: nil
# end

defmodule Solution do
  @spec merge_two_lists(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def merge_two_lists(l1, l2) do
    reverse(merge_two_lists(l1, l2, nil), nil)
  end

  @spec merge_two_lists(
          l1 :: ListNode.t() | nil,
          l2 :: ListNode.t() | nil,
          p :: ListNode.t()
        ) ::
          ListNode.t() | nil
  defp merge_two_lists(l1, l2, p) do
    cond do
      l1 == nil && l2 == nil ->
        p

      l1 == nil || (l2 != nil && l1.val > l2.val) ->
        merge_two_lists(l1, l2.next, %ListNode{val: l2.val, next: p})

      true ->
        merge_two_lists(l1.next, l2, %ListNode{val: l1.val, next: p})
    end
  end

  @spec reverse(p :: ListNode.t() | nil, q :: ListNode.t() | nil) :: ListNode.t() | nil
  defp reverse(p, q) do
    if p == nil, do: q, else: reverse(p.next, %ListNode{val: p.val, next: q})
  end
end
