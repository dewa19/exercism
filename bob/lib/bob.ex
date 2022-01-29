defmodule Bob do
  @doc """
  source : https://exercism.org/tracks/elixir/exercises/bob
  """

  defp remove_non_verbal_characters(input) do
    str = String.replace(input, ~r/[~#|!@#$%^&<>+_\-()\/{}\)*]/, "")
    str
  end

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    clean_input =
      input
      |> String.trim()
      |> remove_non_verbal_characters()

    cond do
      # He says 'Fine. Be that way!' if you address him without actually saying anything.
      clean_input == "" ->
        "Fine. Be that way!"

      # He answers 'Whoa, chill out!' if you YELL AT HIM (in all capitals).
      Regex.match?(~r/([A-Z]+)$/, clean_input) ->
        "Whoa, chill out!"

      # He answers 'Calm down, I know what I'm doing!' if you yell a question at him.
      Regex.match?(~r/([A-Z ]+)[?]+$/, clean_input) ->
        "Calm down, I know what I'm doing!"

      # Bob answers 'Sure.' if you ask him a question, such as "How are you?".
      Regex.match?(~r/(^([A-Z]|[a-z])+(\s)*)(\d)*?/, clean_input) ->
        "Sure."

      # He answers 'Whatever.' to anything else.
      true ->
        "Whatever."
    end
  end
end
