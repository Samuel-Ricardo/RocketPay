defmodule Rocketpay.Accounts.Withdraw do

  alias Ecto.Multi
  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Repo

  def call(params) do

    params
      |> Operation.call(:withdraw)
      |> run_transaction()
  end

  #  params = %{"id" => "37197d60-b600-4e46-be41-64d14d5cd052", "value" => "50.0"} |> Rocketpay.deposit()

  defp run_transaction(multi) do
    case Repo.transaction(multi) do

      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{withdraw: account}} -> {:ok, account}
    end
  end
end
