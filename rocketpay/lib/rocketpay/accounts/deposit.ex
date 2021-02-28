defmodule Rocketpay.Accounts.Deposit do

  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call() do

    Multi.new()
      |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
      |>
  end

  defpget_account(repo, id) do

    case repo.get(Account, id) do

      nil -> {:erro, "Account not found! :("}
      account -> {:ok, account}
    end
  end
end
