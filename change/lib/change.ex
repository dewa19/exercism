defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

      iex(61)> div(18,10)
  1
  iex(62)> div(8,5)
  1
  iex(63)> div(5,1)

  """

  def number_of_coin(_coin, 0), do: []

  def number_of_coin(coin, change) when change == coin, do: [coin]

  def number_of_coin(coin, change) do
    number_of_coin = div(change, coin)
    n = for _n <- 1..number_of_coin, do: coin
    n
  end

  defp generate_coins(0, _list_of_coins, change), do: [change]

  defp generate_coins(remain_change, list_of_coins, collected_coins) do
    case Enum.find(list_of_coins, fn value -> value <= remain_change end) do
      nil ->
        {:error, "cannot change"}

      coin ->
        number_of_coin = div(remain_change, coin)

        # IO.inspect(number_of_coin, label: "jumlah koin #{coin} - #{number_of_coin(coin,remain_change)}")
        # IO.inspect(remain_change - (number_of_coin * coin), label: "sisa kembalian #{remain_change - (number_of_coin * coin)}")

        collected_coins =
          generate_coins(
            remain_change - number_of_coin * coin,
            list_of_coins,
            [collected_coins | number_of_coin(coin, remain_change)]
          )

        # IO.inspect(collected_coins, label: "koin terkumpul")

        collected_coins
    end
  end

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    # collect necessary coins
    list_of_suited_coin =
      Enum.filter(coins, fn x -> x <= target end)
      |> Enum.reverse()

    initial_coins = []
    my_coins = generate_coins(target, list_of_suited_coin, initial_coins)

    case my_coins do
      {:error, "cannot change"} ->
        my_coins

      _ ->
        collected_coins =
          my_coins
          |> List.flatten()
          |> Enum.reverse()

        {:ok, collected_coins}
    end
  end
end
