defmodule Rocketpay.Accounts.Deposit do

  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call() do

    Multi.new()
      |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
      |> Multi.run(:account, fn repo, %{account: account} -> update_balance(repo, account, value))
  end

  defp get_account(repo, id) do

    case repo.get(Account, id) do

      nil -> {:erro, "Account not found! :("}
      account -> {:ok, account}
    end

  defp update_balance(repo, account, value) do

    account
      |> sum_values(value)
      |> update_account(repo)
  end

  defp sum_values (%Account{balance: balance}, value) do

    value
      |> Decimal.cast()
      |> handle_cast(balance)
  end

  defp handle_cast({:ok, value}, balance), do: Decimal.add(value, balance)
  defp handle_cast(:error, _balance), do: {:error, "Invalid Deposit Value!"}

  defp update_account({:error, _reason} = error, _repo), do: error
  defp update_account(value, repo) do

    params = %{balance: value}
      |> Account.changeset()
      |> repo.update()
  end
end
