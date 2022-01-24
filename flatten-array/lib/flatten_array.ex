defmodule FlattenArray do
  @doc """
    source : https://exercism.org/tracks/elixir/exercises/flatten-array

    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  defp flat_it(element) when not is_list(element) and not is_nil(element), do: [element]

  defp flat_it(nil) do
    []
  end

  defp flat_it([]) do
    []
  end

  defp flat_it(list) do
    flat_it(hd(list)) ++ flat_it(tl(list))
  end

  @spec flatten(list) :: list
  def flatten(list) do
    flat_it(list)
  end
end
