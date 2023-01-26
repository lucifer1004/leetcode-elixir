defmodule Solution do
  @spec corp_flight_bookings(bookings :: [[integer]], n :: integer) :: [integer]
  def corp_flight_bookings(bookings, n) do
    mp =
      bookings
      |> Enum.reduce(%{}, fn [first, last, seats], mp ->
        mp
        |> Map.update(first, seats, &(&1 + seats))
        |> Map.update(last + 1, -seats, &(&1 - seats))
      end)

    1..n
    |> Enum.reduce([], fn x, acc ->
      [(acc |> List.first(0)) + (mp |> Map.get(x, 0)) | acc]
    end)
    |> Enum.reverse()
  end
end
