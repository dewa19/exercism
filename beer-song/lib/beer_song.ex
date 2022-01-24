defmodule BeerSong do
  @doc """
  source : https://exercism.org/tracks/elixir/exercises/beer-song
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(1) do
    "\n1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.
    \nNo more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall."
  end

  def verse(n) do
    "\n#{n} bottles of beer on the wall, #{n} bottles of beer.\nTake one down and pass it around, #{
      n - 1
    } bottle of beer on the wall."
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    Enum.each(range, fn n ->
      if n>0 do
        IO.puts(verse(n))
      end

    end)
  end
end
