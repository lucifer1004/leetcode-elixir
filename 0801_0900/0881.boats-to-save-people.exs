defmodule Solution do
  @spec num_rescue_boats(people :: [integer], limit :: integer) :: integer
  def num_rescue_boats(people, limit) do
    asc = people |> Enum.sort() |> Enum.with_index()
    desc = asc |> Enum.reverse()
    calc(asc, desc, limit, 0)
  end

  @spec calc(
          asc :: [{integer, integer}],
          desc :: [{integer, integer}],
          limit :: integer,
          ans :: integer
        ) :: integer
  defp calc(asc, desc, limit, ans) do
    [{hi, hi_idx} | desc_rem] = desc
    [{lo, lo_idx} | asc_rem] = asc

    cond do
      hi_idx < lo_idx -> ans
      hi_idx == lo_idx -> ans + 1
      hi + lo <= limit -> calc(asc_rem, desc_rem, limit, ans + 1)
      true -> calc(asc, desc_rem, limit, ans + 1)
    end
  end
end
