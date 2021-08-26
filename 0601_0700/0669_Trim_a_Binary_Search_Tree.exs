defmodule Solution do
  @spec trim_bst(root :: TreeNode.t() | nil, low :: integer, high :: integer) ::
          TreeNode.t() | nil
  def trim_bst(root, low, high) do
    cond do
      root == nil ->
        nil

      root.val >= low && root.val <= high ->
        %TreeNode{
          val: root.val,
          left: trim_bst(root.left, low, high),
          right: trim_bst(root.right, low, high)
        }

      root.val < low ->
        trim_bst(root.right, low, high)

      root.val > high ->
        trim_bst(root.left, low, high)
    end
  end
end
