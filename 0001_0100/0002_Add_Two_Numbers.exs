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
  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def add_two_numbers(l1, l2) do
    add_two_numbers(l1, l2, 0)
  end

  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil, carry :: integer) ::
          ListNode.t() | nil
  defp add_two_numbers(l1, l2, carry) do
    case {l1, l2, carry} do
      {nil, nil, 0} ->
        nil

      {nil, nil, 1} ->
        struct(%ListNode{val: 1, next: nil})

      {l1, nil, carry} ->
        struct(%ListNode{
          val: rem(l1.val + carry, 10),
          next: add_two_numbers(l1.next, nil, div(l1.val + carry, 10))
        })

      {nil, l2, carry} ->
        struct(%ListNode{
          val: rem(l2.val + carry, 10),
          next: add_two_numbers(nil, l2.next, div(l2.val + carry, 10))
        })

      {l1, l2, carry} ->
        struct(%ListNode{
          val: rem(l1.val + l2.val + carry, 10),
          next: add_two_numbers(l1.next, l2.next, div(l1.val + l2.val + carry, 10))
        })
    end
  end
end
