defmodule Gigasecond do
  @doc """
  source : https://exercism.org/tracks/elixir/exercises/gigasecond
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, the_date} = Date.new(year, month, day)
    {:ok, the_time} = Time.new(hours, minutes, seconds)

    {:ok, date_time} = DateTime.new(the_date, the_time)

    date_time_later = DateTime.add(date_time, 1_000_000_000)

    {{date_time_later.year, date_time_later.month, date_time_later.day},
     {date_time_later.hour, date_time_later.minute, date_time_later.second}}
  end
end
