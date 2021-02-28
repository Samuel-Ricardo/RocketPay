defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do

    setup %{conn: conn}

    params = %{

      name: "Ricardo",
      password: "1234",
      nickname: "Riccardo",
      email: "ricardo@gmail.com",
      age: 16
    }

    {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

    conn = put_req_header(conn, "Authorization", "Basic U2FtdWVsOlNhbXVlbDEyMw==")

    {:ok, conn: conn, account_id: account_id}
  end

  test "when all params are valid,make the deposit", %{conn: conn, account_id: account_id} do

    params = %{"value" => "50.00"}

    response =
      conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)


    assert %{
      "account" => %{"balance" => "50.00", "id" => _id},
      "message" => "Ballance changed sucessfully"
    } = response

  end

  test "when params are valid , return error", %{conn: conn, account_id: account_id} do

    params = %{"value" => "Dog"}

    response =
      conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value"}

    assert response == expected_response

  end
end
