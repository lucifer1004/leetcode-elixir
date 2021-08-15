defmodule Solution do
  @mod 1_000_000_007

  @spec find_paths(
          m :: integer,
          n :: integer,
          max_move :: integer,
          start_row :: integer,
          start_column :: integer
        ) :: integer
  def find_paths(m, n, max_move, start_row, start_column) do
    if max_move == 0,
      do: 0,
      else: find_paths(m, n, max_move, 1, 1, 0, %{{start_row + 1, start_column + 1, 0} => 1}, 0)
  end

  @spec find_paths(
          m :: integer,
          n :: integer,
          max_move :: integer,
          row :: integer,
          column :: integer,
          move :: integer,
          mp :: map(),
          ans :: integer
        ) :: integer
  def find_paths(m, n, max_move, row, column, move, mp, ans) do
    now = Map.get(mp, {row, column, move}, 0)

    {new_mp, new_ans} =
      List.foldl([{-1, 0}, {0, -1}, {0, 1}, {1, 0}], {mp, ans}, fn {dr, dc}, {mp, ans} ->
        if row + dr >= 1 && row + dr <= m && column + dc >= 1 && column + dc <= n,
          do:
            {mp
             |> Map.get_and_update(
               {row + dr, column + dc, move + 1},
               fn x ->
                 if x == nil, do: {x, now}, else: {x, x + now}
               end
             )
             |> elem(1), ans},
          else: {mp, rem(ans + now, @mod)}
      end)

    cond do
      column < n -> find_paths(m, n, max_move, row, column + 1, move, new_mp, new_ans)
      row < m -> find_paths(m, n, max_move, row + 1, 1, move, new_mp, new_ans)
      move + 1 < max_move -> find_paths(m, n, max_move, 1, 1, move + 1, new_mp, new_ans)
      true -> new_ans
    end
  end
end
