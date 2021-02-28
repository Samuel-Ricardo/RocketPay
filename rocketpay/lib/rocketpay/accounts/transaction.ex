defmodule Rocketpay.Accounts.Transaction do

  alias Ecto.Multi

  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse
  alias Rocketpay.Repo
  
  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do

    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    Multi.new()
      |> Multi.merge( fn _changes -> Operation.call(withdraw_params, :withdraw) end)
      |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
      |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do

    case Repo.transaction(multi) do

      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: to_account, withdraw: from_account}} ->
         {:ok, TransactionResponse.build(from_account, to_account)}

    end
  end
end

#params = %{"from" => "37197d60-b600-4e46-be41-64d14d5cd052", "to" => "bd0ac006-79f4-4206-8b92-82a4a709aa5c", "value" => 1.00} |> Rocketpay.Accounts.Transaction.call()
