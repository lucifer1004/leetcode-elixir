defmodule Solution do
  defp solve(n, k, now) do
    if n == 0 do
      now
    else
      if k - 1 <= 26 * (n - 1) do
        solve(n - 1, k - 1, ["a" | now])
      else
        solve(n - 1, 26 * (n - 1), [<<96 + k - 26 * (n - 1)::utf8>> | now])
      end
    end
  end

  @spec get_smallest_string(n :: integer, k :: integer) :: String.t
  def get_smallest_string(n, k) do
    solve(n, k, [])
    |> Enum.reverse()
    |> Enum.join()
  end
end
