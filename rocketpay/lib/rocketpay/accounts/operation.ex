defmodule Rocketpay.Accounts.Operation do

  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call(%{"id" => id, "value" => value}, operation) do

    Multi.new()
      |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
      |> Multi.run(:update_balance, fn repo, %{account: account} -> update_balance(repo, account, value, operation) end)
  end

  #  params = %{"id" => "37197d60-b600-4e46-be41-64d14d5cd052", "value" => "50.0"} |> Rocketpay.deposit()

  defp get_account(repo, id) do

    case repo.get(Account, id) do

      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do

    account
      |> operation_values(value, operation)
      |> update_account(repo, account)
  end

  defp operation_values(%Account{balance: balance}, value, operation) do

    value
      |> Decimal.cast()
      |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, value}, balance, :deposit), do: Decimal.add(balance, value)
  defp handle_cast({:ok, value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_cast(:error, _balance, _operation), do: {:error, "Invalid Deposit Value!"}

  defp update_account({:error, _reason} = error, _repo, _account), do: error
  defp update_account(value, repo, account) do

    params = %{balance: value}

    account
      |> Account.changeset(params)
      |> repo.update()
  end
end
