# Definition for a binary tree node.
#
# defmodule TreeNode do
#   @type t :: %__MODULE__{
#           val: integer,
#           left: TreeNode.t() | nil,
#           right: TreeNode.t() | nil
#         }
#   defstruct val: 0, left: nil, right: nil
# end

defmodule Solution do
  @spec is_balanced(root :: TreeNode.t() | nil) :: boolean
  def is_balanced(root) do
    balance_and_depth(root) |> elem(0)
  end

  @spec balance_and_depth(root :: TreeNode.t() | nil) :: {boolean, integer}
  defp balance_and_depth(root) do
    if root == nil do
      {true, 0}
    else
      {left_balance, left_depth} = balance_and_depth(root.left)
      {right_balance, right_depth} = balance_and_depth(root.right)

      {left_balance && right_balance && abs(left_depth - right_depth) <= 1,
       max(left_depth, right_depth) + 1}
    end
  end
end
