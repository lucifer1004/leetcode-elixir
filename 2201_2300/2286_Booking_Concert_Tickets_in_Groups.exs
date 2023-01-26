defmodule SegmentTree do
  import Bitwise

  defp build(idx, l, r, m) do
    if l == r do
      :ets.insert(:tree, {idx, m, m})
      :ets.insert(:vec, {l, m})
      :ets.insert(:leaf, {l, idx})
    else
      mid = (l + r) >>> 1
      build(idx <<< 1, l, mid, m)
      build(idx <<< 1 ||| 1, mid + 1, r, m)
      :ets.insert(:tree, {idx, m * (r - l + 1), m})
    end
  end

  defp calc(idx) do
    [{_, seats, mx}] = :ets.lookup(:tree, idx <<< 1)
    [{_, seats2, mx2}] = :ets.lookup(:tree, idx <<< 1 ||| 1)
    :ets.insert(:tree, {idx, seats + seats2, max(mx, mx2)})
  end

  defp update(0), do: nil

  defp update(idx) when idx > 0 do
    calc(idx)
    update(idx >>> 1)
  end

  @spec update(pos :: integer, people :: integer) :: nil
  def update(pos, people) do
    [{_, idx}] = :ets.lookup(:leaf, pos)
    [{_, seats, mx}] = :ets.lookup(:tree, idx)
    :ets.insert(:tree, {idx, seats - people, mx - people})
    :ets.insert(:vec, {pos, seats - people})
    update(idx >>> 1)
  end

  @spec query(pos :: integer) :: integer
  def query(pos) do
    [{_, seats}] = :ets.lookup(:vec, pos)
    seats
  end

  defp query_sum(idx, l, r, rb) do
    if r <= rb do
      [{_, seats, _}] = :ets.lookup(:tree, idx)
      seats
    else
      mid = (l + r) >>> 1
      sum = query_sum(idx <<< 1, l, mid, rb)

      sum =
        if mid + 1 <= rb do
          sum + query_sum(idx <<< 1 ||| 1, mid + 1, r, rb)
        else
          sum
        end

      sum
    end
  end

  @spec query_sum(r :: integer) :: integer
  def query_sum(r) do
    [{_, n}] = :ets.lookup(:tree, :n)
    query_sum(1, 1, n, r)
  end

  defp query_max_first(idx, l, r, required) do
    [{_, _, mx}] = :ets.lookup(:tree, idx)

    cond do
      mx < required -> -1
      l == r -> l
      true ->
        mid = (l + r) >>> 1
        ans = query_max_first(idx <<< 1, l, mid, required)

        ans =
          if ans == -1 do
            query_max_first(idx <<< 1 ||| 1, mid + 1, r, required)
          else
            ans
          end

        ans
    end
  end

  @spec query_max_first(required :: integer) :: integer
  def query_max_first(required) do
    [{_, n}] = :ets.lookup(:tree, :n)
    query_max_first(1, 1, n, required)
  end

  defp fill(row, people) do
    now = query(row)
    used = min(now, people)
    update(row, used)

    cond do
      used < people -> fill(row + 1, people - used)
      used == now -> :ets.insert(:tree, {:start, row + 1})
      true -> :ets.insert(:tree, {:start, row})
    end
  end

  @spec fill(people :: integer) :: nil
  def fill(people) do
    [{_, start}] = :ets.lookup(:tree, :start)
    fill(start, people)
  end

  @spec new(n :: integer, m :: integer) :: nil
  def new(n, m) do
    if :ets.whereis(:tree) == :undefined do
      :ets.new(:tree, [:named_table])
      :ets.new(:vec, [:named_table])
      :ets.new(:leaf, [:named_table])
    end

    :ets.insert(:tree, {:n, n})
    :ets.insert(:tree, {:m, m})
    :ets.insert(:tree, {:start, 1})
    build(1, 1, n, m)
  end
end

defmodule BookMyShow do
  @spec init_(n :: integer, m :: integer) :: nil
  def init_(n, m) do
    SegmentTree.new(n, m)
  end

  @spec gather(k :: integer, max_row :: integer) :: [integer]
  def gather(k, max_row) do
    max_first = SegmentTree.query_max_first(k)

    if max_first == -1 || max_first > max_row + 1 do
      []
    else
      [{_, m}] = :ets.lookup(:tree, :m)
      start = m - SegmentTree.query(max_first)
      SegmentTree.update(max_first, k)
      [max_first - 1, start]
    end
  end

  @spec scatter(k :: integer, max_row :: integer) :: boolean
  def scatter(k, max_row) do
    if SegmentTree.query_sum(max_row + 1) < k do
      false
    else
      SegmentTree.fill(k)
      true
    end
  end
end
