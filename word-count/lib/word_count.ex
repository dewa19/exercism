defmodule WordCount do
  @doc """
  https://exercism.org/tracks/elixir/exercises/word-count
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  def trim_tl(word) do
    String.downcase(word)
    |> String.trim()
    |> String.trim_leading("'")
    |> String.trim_trailing("'")
    |> String.trim_leading(",")
    |> String.trim_trailing(",")
    |> String.trim_leading(".")
    |> String.trim_trailing(".")
    |> String.trim_leading("?")
    |> String.trim_trailing("?")
    |> String.trim_leading("!")
    |> String.trim_trailing("!")
  end

  defp count_word(_word, []) do
    0
  end

  defp count_word(word, list) do
    item = hd(list)

    if item == word do
      1 + count_word(word, tl(list))
    else
      count_word(word, tl(list))
    end
  end

  @spec count(String.t()) :: map
  def count(sentence) do
    list = String.split(sentence)

    clean_word_list = Enum.map(list, fn str -> trim_tl(str) end)

    # I don't know why this works
    #Enum.reduce(clean_word_list, %{}, fn a_word, acc ->
    #  Map.update(acc, a_word, 1, fn count -> count + 1 end)
    #end)

    # I'm a bit understand why this one works
    Enum.reduce(clean_word_list, %{}, fn a_word, acc ->
      Map.update(acc, a_word, 1, fn _counter -> count_word(a_word, clean_word_list) end)
    end)

  end
end
