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
  @spec get_kth_from_end(head :: ListNode.t() | nil, k :: integer) :: ListNode.t() | nil
  def get_kth_from_end(head, k) do
    two_ptr(head, get_kth_from_start(head, k))
  end

  @spec two_ptr(head :: ListNode.t() | nil, fast :: ListNode.t() | nil) ::
          ListNode.t() | nil
  defp two_ptr(head, fast) do
    if fast == nil, do: head, else: two_ptr(head.next, fast.next)
  end

  @spec get_kth_from_start(head :: ListNode.t() | nil, k :: integer) :: ListNode.t() | nil
  defp get_kth_from_start(head, k) do
    cond do
      head == nil -> nil
      k == 0 -> head
      true -> get_kth_from_start(head.next, k - 1)
    end
  end
end
